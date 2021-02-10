#!/bin/bash

set -e

if [[ -z "$TEMPLATE" ]]; then
    echo "Empty template specified. Looking for template.yml..."

    if [[ ! -f "template.yml" ]]; then
        echo template.yml not found
        exit 1
    fi

    TEMPLATE="template.yml"
fi

if [[ -z "$AWS_STACK_NAME" ]]; then
    echo AWS Stack Name invalid
    exit 1
fi

if [[ -z "$AWS_ACCESS_KEY_ID" ]]; then
    echo AWS Access Key ID invalid
    exit 1
fi

if [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
    echo AWS Secret Access Key invalid
    exit 1
fi

if [[ -z "$AWS_REGION" ]]; then
    echo AWS Region invalid
    exit 1
fi

if [[ -z "$AWS_DEPLOY_BUCKET" ]]; then
    echo AWS Deploy Bucket invalid
    exit 1
fi

if [[ ! -z "$AWS_BUCKET_PREFIX" ]]; then
    AWS_BUCKET_PREFIX="--s3-prefix ${AWS_BUCKET_PREFIX}"
fi

if [[ $FORCE_UPLOAD == true ]]; then
    FORCE_UPLOAD="--force-upload"
fi

if [[ $USE_JSON == true ]]; then
    USE_JSON="--use-json"
fi

if [[ -z "$CAPABILITIES" ]]; then
    CAPABILITIES="--capabilities CAPABILITY_IAM"
else
    CAPABILITIES="--capabilities $CAPABILITIES"
fi

if [[ ! -z "$PARAMETER_OVERRIDES" ]]; then
    PARAMETER_OVERRIDES="--parameter-overrides $PARAMETER_OVERRIDES"
fi

if [[ ! -z "$ROLE_ARN" ]]; then
    ROLE_ARN="--role-arn ${ROLE_ARN}"
fi

mkdir ~/.aws
touch ~/.aws/credentials
touch ~/.aws/config

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
region = $AWS_REGION" > ~/.aws/credentials

echo "[default]
output = text
region = $AWS_REGION" > ~/.aws/config

aws cloudformation package --template-file $TEMPLATE --output-template-file serverless-output.yaml --s3-bucket $AWS_DEPLOY_BUCKET $AWS_BUCKET_PREFIX $FORCE_UPLOAD $USE_JSON
aws cloudformation deploy --template-file serverless-output.yaml --stack-name $AWS_STACK_NAME $CAPABILITIES $PARAMETER_OVERRIDES $ROLE_ARN
