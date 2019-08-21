#!/bin/sh

if [ -z "$TEMPLATE" ]; then
    echo Empty template specified
    exit 1
fi

if [ -z "$AWS_STACK_NAME" ]; then
    echo AWS Stack Name invalid
    exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo AWS Access Key ID invalid
    exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo AWS Secret Access Key invalid
    exit 1
fi

if [ -z "$AWS_REGION" ]; then
    echo AWS Region invalid
    exit 1
fi

if [ -z "$AWS_DEPLOY_BUCKET" ]; then
    echo AWS Deploy Bucket invalid
    exit 1
fi

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
region = $AWS_REGION" > ~/.aws/credentials

echo "[default]
output = text
region = $AWS_REGION" > ~/.aws/config

aws cloudformation package --template-file $TEMPLATE --output-template-file serverless-output.yaml --s3-bucket $AWS_DEPLOY_BUCKET
aws cloudformation deploy --template-file serverless-output.yaml --stack-name $AWS_STACK_NAME --capabilities CAPABILITY_IAM
