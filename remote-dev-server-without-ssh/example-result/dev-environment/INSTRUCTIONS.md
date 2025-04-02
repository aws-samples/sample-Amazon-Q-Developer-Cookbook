# EC2 Instance with SSM Session Manager Access

This solution deploys an Amazon Linux 2023 EC2 instance that can be accessed securely using AWS Systems Manager Session Manager. The instance is launched in a private subnet without a public IP address, maximizing security by eliminating the need for inbound SSH access.

## Network Architecture Overview

The solution assumes an existing VPC named "dev-vpc" with the following components:
- Private subnet(s) with NAT Gateway access for outbound internet connectivity
- NAT Gateway in a public subnet
- Internet Gateway attached to the VPC
- Appropriate route tables configured for private subnets

## Prerequisites

1. AWS Account with appropriate permissions:
   - IAM permissions to create and manage:
     - EC2 instances and security groups
     - IAM roles and instance profiles
     - CloudFormation stacks
   - Access to Systems Manager Session Manager

2. Tools and configurations:
   - AWS CLI installed and configured with appropriate credentials
   - Session Manager plugin for AWS CLI installed
     - [Install Session Manager Plugin for AWS CLI](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
   - Bash-compatible shell environment (Linux/macOS)

3. Existing VPC infrastructure:
   - VPC named "dev-vpc"
   - Private subnet with NAT Gateway access
   - Appropriate route tables configured

## Deployment Instructions

1. Navigate to the deployment directory:
   ```bash
   cd dev-environment
   ```

2. Make the deployment script executable:
   ```bash
   chmod +x deploy.sh
   ```

3. Run the deployment script:
   ```bash
   ./deploy.sh
   ```

   The script will:
   - Verify the existence of the required VPC and subnet
   - Create an EC2 key pair if it doesn't exist
   - Deploy the CloudFormation stack
   - Output the instance ID upon completion

4. Verify the instance is running:
   ```bash
   aws ec2 describe-instances \
     --instance-ids <INSTANCE_ID> \
     --query 'Reservations[0].Instances[0].State.Name' \
     --output text
   ```
   Wait until the state is "running"

## Connecting to the Instance

To connect to the instance using Session Manager:

```bash
aws ssm start-session --target <INSTANCE_ID>
```

You should see a shell prompt indicating you're connected to the instance:
```
Starting session with SessionId: ...
sh-4.2$
```

Note: The instance is configured without SSH access for enhanced security. All connections should be made through Session Manager.

## Cleanup Instructions

To remove all resources created by this solution:

1. Delete the CloudFormation stack:
   ```bash
   aws cloudformation delete-stack --stack-name remote-dev-server-with-ssm
   ```

2. Delete the EC2 key pair (optional):
   ```bash
   aws ec2 delete-key-pair --key-name remote-dev-server-with-ssm-key
   rm ~/.ssh/remote-dev-server-with-ssm-key.pem
   ```

## Security Best Practices Implemented

1. No public IP address assigned to the instance
2. No inbound security group rules
3. Minimal outbound access (port 443 only)
4. IAM roles with least privilege permissions
5. Secure remote access through AWS Systems Manager Session Manager
6. No direct SSH access required
7. Instance deployed in a private subnet