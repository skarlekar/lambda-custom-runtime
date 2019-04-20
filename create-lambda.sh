#!/bin/bash

export FUNCTION_NAME=bash-runtime

# Check if lambda exists
LAMBDA_ARN=$(aws lambda list-functions | jq '.Functions[] | select(.FunctionName == env.FUNCTION_NAME) | .FunctionArn' |  sed "s/\"//g")
if [ ! -z "$LAMBDA_ARN" ]; then
    echo LAMBDA: $FUNCTION_NAME exists as ARN: $LAMBDA_ARN. Attempting to update function...
    aws lambda update-function-code --function $FUNCTION_NAME \
        --zip-file fileb://function.zip
else
    echo LAMBDA $FUNCTION_NAME does not exist. Attempting to create function...
    aws lambda create-function --function-name $FUNCTION_NAME \
        --zip-file fileb://function.zip --handler function.handler --runtime provided \
        --role arn:aws:iam::219104658389:role/my-ecs-tasks-role
fi
