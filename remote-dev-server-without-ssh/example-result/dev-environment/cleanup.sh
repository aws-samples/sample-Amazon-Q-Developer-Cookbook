#!/bin/bash

# Get the stack name from the command line argument or use a default
STACK_NAME="remote-dev-server-with-ssm"

# Delete the CloudFormation stack
aws cloudformation delete-stack --stack-name $STACK_NAME

# Wait for the stack to be deleted
echo "Waiting for stack deletion to complete..."
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

echo "Stack deletion completed"