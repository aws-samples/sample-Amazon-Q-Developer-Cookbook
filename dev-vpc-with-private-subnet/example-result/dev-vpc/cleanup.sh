#!/bin/bash

# Exit on error
set -e

STACK_NAME="dev-vpc"

echo "Deleting $STACK_NAME stack..."

# Delete the CloudFormation stack
aws cloudformation delete-stack \
    --stack-name $STACK_NAME

echo "Waiting for stack deletion to complete..."
aws cloudformation wait stack-delete-complete \
    --stack-name $STACK_NAME

echo "Stack deletion completed successfully!"