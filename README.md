# IaC-CICD-ARMTemplate-AzureDataBricks-Sample - Showcase Project

Infrastructure as Code Showcase Project using ARM Templates and CICD for Azure Databricks

[![Build Status](https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_apis/build/status/MertSenel.IaC-CICD-ARMTemplate-AzureDataBricks-Sample?branchName=master)](https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_build/latest?definitionId=5&branchName=master) [![Deployment Status](https://vsrm.dev.azure.com/mertsenel/_apis/public/Release/badge/2bffee41-9bcd-41f2-a297-352aba60e0dd/3/9)](https://vsrm.dev.azure.com/mertsenel/_apis/public/Release/badge/2bffee41-9bcd-41f2-a297-352aba60e0dd/3/9) 

## CI/CD Sample using ARM Template Deploying an Azure DataBricks Workspace with VNET Injection

### Azure DevOps Project
https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples

### Credits

The base ARM template referenced from Azure quickstart templates:

<https://github.com/Azure/azure-quickstart-templates/tree/master/101-databricks-workspace-with-vnet-injection>

## Builds
https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_build?definitionId=5&_a=summary&view=buildsHistory
## Releases
https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_release?definitionId=3&view=mine&_a=releases

# Details of the Project, Improvements and Additions on top of the base ARM Template:

## Project:
- ARM Template has been modified to support Environment paramater, this would allow multiple SDLC enviroments can be deployed via same template, with minimum input as namings are generated within variables block via the input of the paramater.
- The environment abbrevation ex. dev, qa, test, staging, prod is automatically appended to naming conventions of resources and resource groups.
- This structure allows dynamic paramaterization of the CD pipelines. 

(The project was initially just deployed a standalone DataBricks Workspace, later on I've converted the project to deploy Azure Databricks worksapce with VNET injection. I will leave development branches in case you want to see my work, history is also available through Pull Requests)

## Azure DevOps Pipelines:
### Continuous Integration
- Yaml based pipeline built for validating the ARM template and archiving template and parameter files to be consumed by Release Pipelines.
- A Pester test script is also added, for a second verification with the Azure Powershell AZ Module's Test-AzResourceGroupDeployment and evauluation ouput of this cmdlet. 
- ~~TODO: Although Pester test script is successfully passing its test while running locally, it is unable to get a succesfull pass result while running on hosted agents of the Azure DevOps. To be Fixed.~~

#### Local Pester Test Run Screenshot:
![Alt text](README-Resources/Pester-Test-Pass.png?raw=true "Pester-Test-Pass")

- Pester Tests are now fixed for CI. Results are published in NUnit format and published to the Build CI Pipeline.
#### Pester Tests Run Screenshot from Build CI:
![Alt text](README-Resources/Sample-Build-CI-PublishedTestResults.png?raw=true "Sample-Build-CI-PublishedTestResults")

#### Sample Build Pipeline Screenshot:
![Alt text](README-Resources/Sample-Build-CI.png?raw=true "Sample-Build-CI")

### Continuous Deployment
- Enabled Continous Deployment for both Pull Request and Push(to master and release branches) to Dev environment.
- This environment and Release stage can later be used to run integration tests before promoting deployment to higher stages.
- Created a Release Pipeline to have Dev and Test and UAT Stages, with stage specific "env" variables to pass to ARM Deployment task to override the "env" parameter of the ARM template.
- Have seperate ARM templates for prerequisites resources and main DataBricks resource. Release Pipeline variables are used to pipe output (VNET Resource ID) to the main template as a paramater. 

### Release Screenshots
#### Sample Release Pipeline
![Alt text](README-Resources/Sample-Release-Pipeline.png?raw=true "Sample-Release-Pipeline")
#### Sample Release Pipeline Stage
![Alt text](README-Resources/Sample-Release-Pipeline-Stage.png?raw=true "Sample-Release-Pipeline-Stage")


## Code Management / GitHub
- Enabled master branch protection in GitHub repository with status checks requirement for safe contribution. 

## Deployed Resource Screenshots in Azure After Release

Below screenshots are to demonstrate naming convention and how easy it is to scale projects for different stages with dynamic paramaters.

### Resource Groups
### All Resource Groups after Successful Release
![Alt text](README-Resources/Deployed-RGs-After-Releases.png?raw=true "Deployed-RGs-After-Releases")

### CI (Manual Run from Local)
![Alt text](README-Resources/AZDB-VNETinj-CI-Resources.png?raw=true "AZDB-VNETinj-CI-Resources")
### DEV
![Alt text](README-Resources/AZDB-VNETinj-DEV-Resources.png?raw=true "AZDB-VNETinj-DEV-Resources")
### TEST
![Alt text](README-Resources/AZDB-VNETinj-TEST-Resources.png?raw=true "AZDB-VNETinj-TEST-Resources")
### UAT
![Alt text](README-Resources/AZDB-VNETinj-UAT-Resources.png?raw=true "AZDB-VNETinj-UAT-Resources")

## Other Screenshots

#### Sample VNET Delegation
![Alt text](README-Resources/Sample-VNET-Delegation.png?raw=true "Sample-VNET-Delegation")

#### Sample NSG After Databricks Delegation
![Alt text](README-Resources/Sample-NSG-After-Databricks-Delegation.png?raw=true "Sample-NSG-After-Databricks-Delegation")
