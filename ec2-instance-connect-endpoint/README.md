# Prompt for Creating EC2 Instance Connect Endpoint CloudFormation Template
```
Create a CloudFormation template that implements an EC2 Instance Connect Endpoint with the following requirements:

## Core Resources
1. EC2 Instance Connect Endpoint
   - Deploy in specified VPC and subnet
   - Include appropriate tags
   - Enable DNS resolution

2. Security Groups:
   - Create security group for EC2 Instance Connect Endpoint
   - Create security group for target EC2 instances
   - Configure appropriate inbound/outbound rules
   - Add Description for Ingress and Egress Rules

## Security Group Rules Requirements
1. EC2 Instance Connect Endpoint Security Group:
   - Allow outbound traffic to target EC2 instances on port 22
   - Restrict to VPC CIDR range
   
2. Target EC2 Instance Security Group:
   - Allow inbound SSH (port 22) only from EC2 Instance Connect Endpoint security group
   - Allow necessary outbound traffic

## Parameters
Include parameters for:
- VPC ID
- Subnet ID
- Environment name (for tagging)
- CIDR ranges

## Outputs
Output the following only:
- EC2 Instance Connect Endpoint ID
- Security Group IDs

## Additional Requirements
1. Include proper resource naming convention
2. Implement appropriate tagging strategy
3. Follow AWS security best practices
4. Include descriptions for all resources and parameters
5. Ensure proper dependencies between resources

## Template Format
- Use YAML format
- Include appropriate comments for clarity
- Follow AWS CloudFormation best practices
- Include template metadata and description

The template should enable secure SSH access to EC2 instances through EC2 Instance Connect Endpoint while following security best practices and proper network isolation.

```

# EC2 Instance Connect Endpoint - Usage Guide

This guide provides instructions for deploying the EC2 Instance Connect Endpoint and connecting to EC2 instances through it.

## Deploying the CloudFormation Template

1. Save the CloudFormation template as `ec2-instance-connect-endpoint.yaml`
2. Open [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/) and Click the "Create stack" button, Select "With new resources (standard)"
3. Upload `ec2-instance-connect-endpoint.yaml` template file from your local system and Click "Next".
4. Enter a Stack name (must be unique) and fill in the following parameters required by your template.
    - VPC ID
    - Subnet ID
    - Environment name (for tagging)
    - CIDR ranges
5. Click "Next" and review all the configuration settings. Click "Submit".
6. Wait for the stack status to show "CREATE_COMPLETE"

## Attaching Newly Created Instance Security Group

1. Open [Amazon EC2 Console](https://console.aws.amazon.com/ec2/)
2. Select your instance
3. Click Actions → Security → Change Security Groups
4. Select the `XXXXXX-ec2-instance-sg` existing security groups and add the new security group
5. Click Save

## Connecting to your Amazon EC2 instance using EC2 Instance Connect Endpoint

1. Open [Amazon EC2 console](https://console.aws.amazon.com/ec2/).
2. In the navigation pane, choose Instances.
3. Select the instance, and then choose Connect.
4. Choose the EC2 Instance Connect tab.
5. For Connection type, choose Connect using EC2 Instance Connect Endpoint.
6. For EC2 Instance Connect Endpoint, choose the ID of the EC2 Instance Connect Endpoint.
7. For Username, if the AMI that you used to launch the instance uses a username other than ec2-user, enter the correct username.
8. For Max tunnel duration (seconds), enter the maximum allowed duration for the SSH connection.
9. The duration must comply with any maxTunnelDuration condition specified in the IAM policy. If you don't have access to the IAM policy, contact your administrator.
10. Choose Connect. This opens a terminal window for your instance.

For other ways to connect, refer to Connect to an [Amazon EC2 instance using EC2 Instance Connect Endpoint](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-using-eice.html)