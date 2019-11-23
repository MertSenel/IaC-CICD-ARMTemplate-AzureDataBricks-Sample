$parameters = @{ ResourceGroupName = "databricks-rg-ci"; `
                 TemplateFile = ".\azuredeploy.json"; `
                 ParametersFile = ".\azuredeploy.parameters.json";
                 }
$script = @{ Path = ".\pre-deploy-pester-test.ps1"; Parameters = $parameters }

$timestamp = Get-Date -Format MM-dd-yyyy_HH_mm_ss

Invoke-Pester -Script $script -OutputFile ".\TEST-Pester-Test-Results-$timestamp.xml" -OutputFormat "NUnitXML"