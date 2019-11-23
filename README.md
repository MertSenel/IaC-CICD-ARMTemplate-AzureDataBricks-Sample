# IaC-CICD-ARMTemplate-AzureDataBricks-Sample
Infrastructure as Code Showcase Project using ARM Templates and CICD for Azure Databricks

[![Build Status](https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_apis/build/status/MertSenel.IaC-CICD-ARMTemplate-AzureDataBricks-Sample?branchName=master)](https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_build/latest?definitionId=5&branchName=master) [![Deployment Status](https://vsrm.dev.azure.com/mertsenel/_apis/public/Release/badge/2bffee41-9bcd-41f2-a297-352aba60e0dd/3/7)](https://vsrm.dev.azure.com/mertsenel/_apis/public/Release/badge/2bffee41-9bcd-41f2-a297-352aba60e0dd/3/7) 

## CI/CD Sample using ARM Template Deploying an Azure DataBricks Workspace - Showcase Project

### Azure DevOps Project: 
https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples

### Credits:

The base ARM template referenced from Azure quickstart templates:

<https://github.com/Azure/azure-quickstart-templates/tree/master/101-databricks-workspace>

## Builds
https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_build
## Releases
https://dev.azure.com/mertsenel/Infrastructure-as-Code-Samples/_release

# Details of the Project, Improvements and Additions on top of the base ARM Template:

## Project:
- ARM Template has been modified to support Environment paramater, this would allow multiple SDLC enviroments can be deployed via same template, with minimum input as namings are generated within variables block via the input of the paramater.
- The environment abbrevation ex. dev,qa,test,staging, prod is automatically appended to naming conventions of resources and resource groups.
- This structure allows dynamic paramaterization of the CD pipelines. 

## Azure DevOps Pipelines:
### Continuous Integration
- Yaml based pipeline built for validating the ARM template and archiving template and parameter files to be consumed by Release Pipelines.
- A Pester test script is also added, for a second verification with the Azure Powershell AZ Module's Test-AzResourceGroupDeployment and evauluation ouput of this cmdlet. 
- TODO: Although Pester test script is successfully passing it's test while running locally, it is unable to get a succesfull pass result while running on hosted agents of the Azure DevOps. To be Fixed.

#### Local Pester Test Run Screenshot:
![Alt text](README-Resources/Pester-Test-Pass.png?raw=true "Pester-Test-Pass")

### Continuous Deployment
- Enabled Continous Deployment for both Pull Request and Push(to master and release branches) to Dev environment. 
  - This environment and Release stage can later be used to run integration tests before promoting deployment to higher stages.  
- Added Continous Monitoring to the App Service via Application Insights with Release Pipeline task
- Created a Release Pipeline to have Dev and Test Stages, with stage specifif "env" variables to pass to ARM Deployment task to override the "env" parameter of the ARM template. 
  - Have stage specific variables to use same code with various configurations.

## Code Management / GitHub
- Enabled master branch protection in GitHub repository with status checks requirement for safe contribution. 
