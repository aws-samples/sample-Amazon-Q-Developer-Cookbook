# Amazon Q Developer Cookbook

This repository contains a collection of prompt recipes for using Amazon Q Developer to accelerate infrastructure as code (IaC) development. It serves as a cookbook demonstrating how to leverage Amazon Q Developer to create, modify, and manage AWS resources through code.

## What is Amazon Q Developer?

Amazon Q Developer is an AI-powered assistant that helps developers build on AWS faster. It can generate code, transform existing code, provide recommendations, and help troubleshoot issues. For infrastructure as code, Amazon Q Developer can help create CloudFormation templates, Terraform configurations, and other IaC resources with natural language prompts.

## Repository Contents

- **Prompt Recipes**: Examples of prompts that can be used with Amazon Q Developer to create infrastructure as code
  - [Development VPC with private subnet](/dev-vpc-with-private-subnet): Create a VPC with private subnets for testing instances
  - [Remote Development Server Without SSH](/remote-dev-server-without-ssh): Setup remote development environments in the private subnet and access through SSM
  - [SageMaker AI Notebook](/Sagemaker-AI-notebook): Create a notebook for testing a sample repo from Github. 

## Getting Started with Amazon Q Developer

### Prerequisites

- An [AWS account](https://docs.aws.amazon.com/accounts/latest/reference/accounts-welcome.html)
- The AWS CLI: [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Appropriate permissions to use Amazon Q Developer

### Installation Options

1. [Installing the Amazon Q Developer extension or plugin in your IDE](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-in-IDE.html)
2. [Installing Amazon Q for command line](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)


### Using Amazon Q Developer

To use Amazon Q Developer for infrastructure as code:

1. Start with a clear description of what you want to build
2. Provide specific requirements and constraints
3. Iterate on the generated code with follow-up prompts
4. Review and test the generated code before deployment

## Resources

- [Amazon Q Developer Documentation](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html)
- [AWS CloudFormation Documentation](https://docs.aws.amazon.com/cloudformation/)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [Amazon Q Developer Blog](https://aws.amazon.com/blogs/aws/category/artificial-intelligence/amazon-q/)

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

