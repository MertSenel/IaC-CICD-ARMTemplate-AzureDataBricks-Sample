Param(
  [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
  [string] [Parameter(Mandatory=$true)] $TemplateFile,
  [string] [Parameter(Mandatory=$true)] $ParametersFile
)

Describe "DataBrick ARM Template Deployment Tests" {
  BeforeAll {
    $DebugPreference = "Continue"
  }

  AfterAll {
    $DebugPreference = "SilentlyContinue"
  }

  Context "Run Mock Deployment with Test Cmdlet" {
    $output = Test-AzResourceGroupDeployment `
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