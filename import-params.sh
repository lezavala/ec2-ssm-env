#!/bin/bash

# Set options
while getopts p:r: option
do
case "${option}"
in
p) PARAMETER_PATH=${OPTARG};;
r) REGION=${OPTARG};;
esac
done

# Functions
AWS=`which aws`

get_parameter_store_tags() {
    echo $($AWS ssm get-parameters-by-path --with-decryption --path $1  --region $2)
}

params_to_env () {
    params=$1

    # If .Tags does not exist we assume ssm Parameteres object.
    SELECTOR="Name"

    for key in $(echo $params | /usr/bin/jq -r ".[][].${SELECTOR}"); do
                value=$(echo $params | /usr/bin/jq -r ".[][] | select(.${SELECTOR}==\"$key\") | .Value")
                key=$(echo "${key##*/}" | /usr/bin/tr ':' '_' | /usr/bin/tr '-' '_' | /usr/bin/tr '[:lower:]' '[:upper:]')
                export $key="$value"
                echo "$key=$value"
    done
}


# Get TAGS
if [ -z "$PARAMETER_PATH" ]
      then
              echo "Please provide a parameter store path. -p option"
              exit 1
fi
TAGS=$(get_parameter_store_tags ${PARAMETER_PATH} ${REGION})
echo "Tags fetched via ssm from ${PARAMETER_PATH} ${REGION}"

echo "Adding new variables..."
params_to_env "$TAGS"
