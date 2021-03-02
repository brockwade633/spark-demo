#!/bin/zsh

stackName=${1:-spark-demo}
region=${2:-us-west-2}

cfn-lint cfn/spark-demo.yaml

aws cloudformation deploy --template-file cfn/spark-demo.yaml \
    --stack-name $stackName \
    --capabilities CAPABILITY_IAM \
    --region $region