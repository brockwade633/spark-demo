#!/bin/zsh

stackName=${1:-spark-demo}
region=${2:-us-west-2}
bucket=${3:-deployment-cfn-templates}

echo 'cfn-lint ...'
cfn-lint cfn/spark-demo.yaml

echo 'packaging...'
aws cloudformation package \
    --template-file cfn/${stackName}.yaml \
    --s3-bucket ${bucket} \
    --s3-prefix ${stackName} \
    --region ${region} \
    --output-template-file cfn/${stackName}-packaged.yaml

echo 'deploying...'
aws cloudformation deploy \
    --no-fail-on-empty-changeset \
    --template-file cfn/${stackName}-packaged.yaml \
    --stack-name ${stackName} \
    --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND \
    --region ${region}