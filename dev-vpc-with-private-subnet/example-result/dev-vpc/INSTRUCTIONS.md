# Remote Development VPC Deployment Guide

This guide provides instructions for deploying a secure VPC infrastructure using AWS CloudFormation. The infrastructure includes a VPC with private subnets across two availability zones and NAT Gateway for secure outbound internet connectivity.

## Architecture Overview

The template creates the following resources:
- VPC named 'remote-dev-vpc'
- Two private subnets in different availability zones
- NAT Gateway for outbound internet connectivity
- Associated route tables and network configuration
- All resources are tagged with cost_group=[stack name]

## Prerequisites

1. AWS Account with sufficient permissions
2. AWS CLI installed and configured
3. Required IAM Permissions:
   - cloudformation:*
   - ec2:*
   - elasticloadbalancing:*

## Deployment Instructions

### Using the deployment script

1. Ensure AWS CLI is configured with appropriate credentials:
```bash
aws configure
```

2. Run the deployment script:
```bash
./deploy.sh
```

The script will:
- Deploy the CloudFormation stack
- Wait for deployment completion
- Display stack outputs including VPC and subnet IDs

### Manual Deployment using AWS CLI

If you prefer to deploy manually:

```bash
aws cloudformation create-stack \
  --stack-name dev-vpc \
  --template-body file://dev-vpc.yaml \
  --capabilities CAPABILITY_IAM

# Wait for stack completion
aws cloudformation wait stack-create-complete \
  --stack-name dev-vpc

# Get stack outputs
aws cloudformation describe-stacks \
  --stack-name dev-vpc \
  --query 'Stacks[0].Outputs'
```

### Getting VPC Information

To retrieve the VPC ID after deployment:

```bash
aws cloudformation describe-stacks \
  --stack-name dev-vpc \
  --query 'Stacks[0].Outputs[?OutputKey==`VpcId`].OutputValue' \
  --output text
```

## Cleanup

To remove all resources:

1. Using the cleanup script:
```bash
./cleanup.sh
```

2. Manual cleanup:
```bash
aws cloudformation delete-stack --stack-name dev-vpc
aws cloudformation wait stack-delete-complete --stack-name dev-vpc
```

## Security Considerations

- All subnets are private for enhanced security
- NAT Gateway provides secure outbound internet connectivity
- Resources are isolated within the VPC
- No direct inbound internet access to resources