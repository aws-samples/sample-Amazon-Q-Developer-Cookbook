
## Prompts for creating a starter dev enviornment on AWS
This recipe shows how to use the Amazon Q Developer command line chat feature to deploy a SageMaker AI Notebook. 
The command line chat can execute local commands on your behalf including downloading a git repo and reading local files. 

### Conversaion Prompts
The excerpts below are suggestions to help you get started. Adjust as necessary based on the responses you get

Start your chat console by entering ```q chat``` at your command prompt.

#### First create a local folder and download a sample project with notebooks to it
``` bash
Create a new folder named SageMaker-notebook and do the following steps in the new folder

Download a copy of this repo into the folder without cloning it
https://github.com/aws-samples/sample-for-multi-modal-document-to-json-with-sagemaker-ai.git
```

#### Now ask Q to inspect the project for AWS resources and permissions required
``` bash
Review the downloaded code and identify the resources and IAM permissions required to execute the notebooks. Create an instructions.md file with your findings.
```
#### Ask Q to help create a SageMaker AI Notebook instance to run the code 
```bash
Review the instructions that you just made and create a CloudFormation template named notebook.yaml that will deploy a SageMaker AI Notebook and all dependant resources. 
Make sure the IAM role used by the notebook uses the principals of least privlage. Only define permission statements that are narrowly scoped to the resources needed. 
Use a lifecycle configuration to download the code repo to the notebook but don't install other dependancies. Create a readme file in the notebook that provides instructions for installing other dependancies. 
Make sure the ec2-user has permissions to work in the folder where the code is downloaded.
Create a deploy-instructions.md file for the template that also includes instructions for cleanin up the stack. 
```

#### Ask Q to attempt to deploy the stack following the instructions
```bash
Deploy the template following the deployment-instructions. 
```

#### Ask Q to attempt to help cleanup
```bash
Delete the deployed stack using the cleanup steps in deploy-instructions
```
