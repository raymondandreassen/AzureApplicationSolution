

terraform apply -var-file .\credentials.tfvars

sleep 1

$filename = "AzureApplicationSolutionBackup_" + (Get-Date -Format "yyyy-MM-dd_HH-mm-ss") + ".zip"
Compress-Archive -Path .\..\Terraform -DestinationPath ..\..\AzureApplicationSolutionBackup\$filename