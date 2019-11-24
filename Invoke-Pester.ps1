Param(
  [string] $WorkingDirForCI
)

#This block should only be executed while running in CI pipeline
if($WorkingDirForCI){
Write-Output "Changing working directory to $WorkingDirForCI"
Set-Location -Path $WorkingDirForCI
Get-ChildItem #list directory objects
}

#Get Latest Pester
Install-Module -Name Pester -Force -SkipPublisherCheck


$parameters = @{ ResourceGroupName = "databricks-rg-ci"; }
$script = @{ Path = ".\pre-deploy-pester-tests.ps1"; Parameters = $parameters }

$timestamp = Get-Date -Format MM-dd-yyyy_HH_mm_ss

Invoke-Pester -Script $script -OutputFile ".\TEST-Pester-Test-Results-$timestamp.xml" -OutputFormat "NUnitXML"
