# ec2-ssm-env
**This script was written for my personal use and may not be suited to use in a production environment.**
Import tags from parameter store as Shell environment variables.

## Requirements
- jq package https://stedolan.github.io/jq/
- AWS CLI tool https://github.com/aws/aws-cli (probably already installed in your AMI)
- IAM policy allowing you to use `ssm:GetParametersByPath`

## Usage
sh import-params.sh -p /NAMESPACE/ENV/ -r us-west-1

**Note**
The above will look for parameters stored under the path: /NAMESPACE/ENV/

IE
- /NAMESPACE/ENV/APP_NAME
- /NAMESPACE/ENV/APP_KEY
- /NAMESPACE/ENV/DYNAMODB_HOST

It will then set then envirnoment as:
- APP_NAME=value
- APP_KEY=value
- DYNAMODB_HOST=value

## Acknowledgement
- berpj
- Guy

## Todo
- Modify script to allow for importing a single parameter..
