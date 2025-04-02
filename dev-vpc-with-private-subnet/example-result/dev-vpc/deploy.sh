#!/bin/bash

# Exit on error
set -e

STACK_NAME="dev-vpc"
TEMPLATE_FILE="dev-vpc.yaml"

echo "Deploying $STACK_NAME stack..."

# Deploy the CloudFormation stack
aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --template-body file://$TEMPLATE_FILE \
    --capabilities CAPABILITY_IAM

echo "Waiting for stack creation to complete..."
aws cloudformation wait stack-create-complete \
    --stack-name $STACK_NAME

echo "Stack deployment completed successfully!"

# Display stack outputs
echo -e "\nStack Outputs:"
aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query 'Stacks[0].Outputs' \
    --output table