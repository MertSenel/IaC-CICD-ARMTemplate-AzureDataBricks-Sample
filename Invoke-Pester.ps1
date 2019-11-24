Param(
  [string] $WorkingDirForCI
)

#This block should only be executed while running in CI pipeline
if($WorkingDirForCI){
Write-Output "Changing working directory to $WorkingDirForCI"
Set-Location -Path $WorkingDirForCI
Get-ChildItem #list directory objects
}


$parameters = @{ ResourceGroupName = "databricks-rg-ci"; `
                 TemplateFile = ".\azuredeploy.json"; `
                 ParametersFile = ".\azuredeploy.parameters.json";
                 }
$script = @{ Path = ".\pre-deploy-pester-test.ps1"; Parameters = $parameters }

$timestamp = Get-Date -Format MM-dd-yyyy_HH_mm_ss


$DebugPreference = "Continue"
Invoke-Pester -Script $script -OutputFile ".\TEST-Pester-Test-Results-$timestamp.xml" -OutputFormat "NUnitXML"
$DebugPreference = "SilentlyContinue"