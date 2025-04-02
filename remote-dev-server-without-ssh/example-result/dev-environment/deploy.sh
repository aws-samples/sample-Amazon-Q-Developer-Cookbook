#!/bin/bash

# Exit on any error
set -e

STACK_NAME="remote-dev-server-with-ssm"
REGION=$(aws configure get region)
VPC_NAME="dev-vpc-remote-dev-vpc"

# Function to check if a key pair exists
check_key_pair() {
    aws ec2 describe-key-pairs --key-names "$1" 2>/dev/null
    return $?
}

# Get VPC ID
VPC_ID=$(aws ec2 describe-vpcs \
    --filters "Name=tag:Name,Values=$VPC_NAME" \
    --query 'Vpcs[0].VpcId' \
    --output text)

if [ -z "$VPC_ID" ] || [ "$VPC_ID" == "None" ]; then
    echo "Error: VPC with name $VPC_NAME not found"
    exit 1
fi

# Get private subnet with NAT Gateway
SUBNET_ID=$(aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=$VPC_ID" "Name=map-public-ip-on-launch,Values=false" \
    --query 'Subnets[0].SubnetId' \
    --output text)

if [ -z "$SUBNET_ID" ] || [ "$SUBNET_ID" == "None" ]; then
    echo "Error: No private subnet found in VPC"
    exit 1
fi

# Check if NAT Gateway exists
NAT_GATEWAY_ID=$(aws ec2 describe-nat-gateways \
    --filter "Name=vpc-id,Values=$VPC_ID" "Name=state,Values=available" \
    --query 'NatGateways[0].NatGatewayId' \
    --output text)

if [ "$NAT_GATEWAY_ID" == "None" ]; then
    echo "Warning: No NAT Gateway found. Please ensure the subnet has internet access through a NAT Gateway."
    exit 1
fi

# Create EC2 key pair if it doesn't exist
KEY_PAIR_NAME="${STACK_NAME}-key"
if ! check_key_pair "$KEY_PAIR_NAME"; then
    echo "Creating new key pair: $KEY_PAIR_NAME"
    aws ec2 create-key-pair \
        --key-name "$KEY_PAIR_NAME" \
        --query 'KeyMaterial' \
        --output text > ~/.ssh/"$KEY_PAIR_NAME".pem
    chmod 400 ~/.ssh/"$KEY_PAIR_NAME".pem
    echo "Key pair created and saved to ~/.ssh/$KEY_PAIR_NAME.pem"
fi

# Deploy CloudFormation stack
echo "Deploying CloudFormation stack..."
aws cloudformation deploy \
    --template-file ec2-ssm.yaml \
    --stack-name "$STACK_NAME" \
    --parameter-overrides \
        KeyPairName="$KEY_PAIR_NAME" \
        VpcId="$VPC_ID" \
        SubnetId="$SUBNET_ID" \
    --capabilities CAPABILITY_NAMED_IAM

# Get instance ID
INSTANCE_ID=$(aws cloudformation describe-stacks \
    --stack-name "$STACK_NAME" \
    --query 'Stacks[0].Outputs[?OutputKey==`InstanceId`].OutputValue' \
    --output text)

echo "Deployment complete!"
echo "Instance ID: $INSTANCE_ID"
echo "To connect using Session Manager, run:"
echo "aws ssm start-session --target $INSTANCE_ID"