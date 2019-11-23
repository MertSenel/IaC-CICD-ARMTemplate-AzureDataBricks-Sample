Param(
  [string] $ResourceGroupName = "databricks-rg-ci",
  [string] $TemplateFile = "azuredeploy.json",
  [string] $ParametersFile = "azuredeploy.parameters.json"
)

Describe "DataBrick ARM Template Deployment Tests" {
  BeforeAll {
    $DebugPreference = "Continue"
  }

  AfterAll {
    $DebugPreference = "SilentlyContinue"
  }

  Context "Run Mock Deployment with Test Cmdlet" {
    $output = Test-AzureRmResourceGroupDeployment `
                              -Mode "Complete" `
                              -ResourceGroupName $ResourceGroupName `
                              -TemplateFile $TemplateFile `
                              -TemplateParameterFile $ParametersFile `
                              -ErrorAction Stop `
                               5>&1

    $result = (($output[27] -split "Body:")[1] | ConvertFrom-Json).properties

    It "Should be deployed successfully" {
      $result.provisioningState | Should -Be "Succeeded"
    }
  }
}