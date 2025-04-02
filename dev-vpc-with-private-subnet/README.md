## Prompts for creating a starter dev enviornment on AWS
This recipe contains to create a VPC with private subnet that can be used to launch other enviornments shown in this cookbook

Use this prompt with in your IDE extension or plugin with the [```/dev``` command](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/software-dev.html). 

### Prompt
The prompt contains requirements for setting up:
- A CloudFormation template (dev-vpc.yaml) that creates a vpc with a private subnet and NAT gateway.
- An accompanying INSTRUCTIONS.md file with detailed setup and usage documentation

```
Create a new folder named dev-vpc. In this folder create a CloudFormation template dev-vpc.yaml, deployment shell scripts, and INSTRUCTIONS.md that together implement and document the following:

CloudFormation Template Requirements:
Create a new VPC with only private subnets.
Create a private subnets in two availability zones in the VPC
Create a NAT Gateway for internet connectivity to resources that are launched in the private subnet
Tag all resources with cost_group=[stack name]
Use 'dev-vpc' as the stack name and prefix for all resource names
Include an output section that displays the VPC and subnet IDs

Deploy and Cleanup Requirements:
Create deploy.sh and cleanup.sh scripts that will deploy the cloudformation template. 
The script should use the wait functionality to wait for deployment to be complete and then print the output of the deployment. 


INSTRUCTIONS Requirements:
Assume a *nix environment. All instructions should work in for Mac or Linux shell enviornments
Network architecture overview
Any prerequisites or required IAM permissions for launching the stack
Deployment instructions using AWS CLI including:
Prerequisites including an AWS account, AWS cli installed and configured with necessary permissions, and Session Manager plugin installed
How to deploy the initial stack using CLI commands or the shell scripts created
Instructions for getting the VPC ID
Instructions for cleanup using the CLI or shell scripts created
The solution should prioritize security best practices and clear documentation.
```




