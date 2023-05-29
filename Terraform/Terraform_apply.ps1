

terraform apply -var-file .\01.secrets.tfvars

sleep 1

$filename = "terraform_" + (Get-Date -Format "yyyy-MM-dd_HH-mm-ss") + ".tfstate"
# Compress-Archive -Path .\..\Terraform -DestinationPath ..\..\AzureApplicationSolutionBackup\$filename
Copy-Item -Path .\terraform.tfstate .\..\..\AzureApplicationSolutionBackup\$filename 