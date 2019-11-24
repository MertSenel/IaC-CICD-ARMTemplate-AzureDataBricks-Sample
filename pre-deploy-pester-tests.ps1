Param(
  [string] [Parameter(Mandatory=$true)] $ResourceGroupName
)

Describe "DataBrick ARM Template Deployment Tests" {
  BeforeAll {
    $DebugPreference = "Continue"
  }

  AfterAll {
    $DebugPreference = "SilentlyContinue"
  }

  Context "Run Mock Deployment for Prerequisites Template with Test Cmdlet" {
    $output = Test-AzResourceGroupDeployment `
                              -Mode "Complete" `
                              -ResourceGroupName $ResourceGroupName `
                              -TemplateFile ".\prereqs\prereq.azuredeploy.json" `
                              -TemplateParameterFile ".\prereqs\prereq.azuredeploy.parameters.json" `
                              -ErrorAction Stop `
                               5>&1

    if($output){
      $matchinfo = $output | Select-String -Pattern "Body:"
      $result = (($matchinfo[1] -split "Body:")[1] | ConvertFrom-Json).properties
    }
    else{
      echo "output is null"
    }
    It "Should be deployed successfully" {
      $result.provisioningState | Should -Be "Succeeded"
    }
  }

  Context "Run Mock Deployment for Main Template with Test Cmdlet" {
    $output = Test-AzResourceGroupDeployment `
                              -Mode "Complete" `
                              -ResourceGroupName $ResourceGroupName `
                              -TemplateFile ".\azuredeploy.json" `
                              -TemplateParameterFile "azuredeploy.parameters.json" `
                              -ErrorAction Stop `
                               5>&1

    if($output){
      $matchinfo = $output | Select-String -Pattern "Body:"
      $result = (($matchinfo[1] -split "Body:")[1] | ConvertFrom-Json).properties
    }
    else{
      echo "output is null"
    }
    It "Should be deployed successfully" {
      $result.provisioningState | Should -Be "Succeeded"
    }
  }
}