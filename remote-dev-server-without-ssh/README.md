## Prompts for creating a starter dev enviornment on AWS
This recipe contains two prompts that guide the creation of a EC2 based development environment on AWS. This can be useful for many use cases including experimentation with sample code, devops, and ongoing development. 

Use these prompts with in your IDE extension or plugin with the [```/dev``` command](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/software-dev.html). 

### First Prompt
The first code block contains requirements for setting up:
- A CloudFormation template (ec2-ssm.yaml) that creates a secure EC2 instance accessible only through AWS Systems Manager Session Manager
- An accompanying INSTRUCTIONS.md file with detailed setup and usage documentation
- The infrastructure includes a VPC, NAT Gateway, security groups, and IAM roles configured with security best practices
- Deployment instructions using AWS CLI with clear prerequisites and cleanup steps

``` bash
Create a new folder named dev-environment. In this folder create a CloudFormation template ec2-ssm.yaml, deployment script deploy.sh, and INSTRUCTIONS.md that together implement and document the following:

CloudFormation Template Requirements:
Launch an Amazon Linux 2023 EC2 instance using the latest default AMI from SSM without a public IP in a VPC that is provided.
Configure a security group for the instance that is open to port 443 egress only with no ingress ports open
Configure all necessary IAM roles and policies for SSM Session Manager connectivity
Tag all resources with cost_group=[stack name]
Use 'remote-dev-server-with-ssm' as the stack name and prefix for all resource names
Include an output section that displays the EC2 instance ID
Accept a parameter for an EC2 key pair name

Deployment shell script requirements:
Look for a VPC in the account with the name "dev-vpc" and get the VPC ID and subnet id for use in the cloudformation template. 
Ensure the subnet has internet access through a NAT gateway
First check if a nat gateway for outbound internet access already exists before creating one
Create an ec2 key pair to be used in the cloudformation template


INSTRUCTIONS Requirements:
Assume a *nix environment. All instructions should work in for Mac or Linux shell enviornments
Network architecture overview
Any prerequisites or required IAM permissions
Deployment instructions using AWS CLI including:
Prerequisites including an AWS account with VPC, AWS cli installed and configured with necessary permissions, and Session Manager plugin installed
How to create an EC2 key pair and store it in the appropriate ssh folder for the system
How to deploy the initial stack
Instructions for getting the instance id and how to verify the instance is running and ready to connect
Instructions for connecting to the instance using SSM Session Manager via AWS CLI
Instructions for cleanup

The solution should prioritize security best practices and clear documentation.
```
### Second Prompt
The second code block extends the INSTRUCTIONS.md to include:
- Additional SSH configuration for connecting to the EC2 instance through SSM
- Instructions for setting up ProxyCommand in SSH config
- Commands for connecting via standard SSH using the configured key pair
- Maintains existing SSM connection instructions while adding SSH connectivity options

Together these prompts create a template and documentation for a secure, SSM-managed development environment that can be accessed through both SSM Session Manager and standard SSH commands.

``` bash
Update the INSTRUCTIONS.md to add instructions for modifying my SSH config to connect through SSM for this instance.
Requirements:
Keep the existing instructions for connecting using ssm
Provide additional instructions for adding a ProxyCommand to the ssh config file for the instance that was created
Be sure to reference the key pair that was created in the original instructions
Provide instructions for using the ssh command from a prompt to connect to the instance

Also create a cleanup.sh script to delete the stack
```




