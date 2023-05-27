# About Azure Application Solution
### I need a setup for my applications, containing: 
1. Private network
1. Protected by a Web Application Gateway
1. Private DNS
1. VPN for network access to inner parts
1. SQL Server
1. Setup (template) for every web application I make

### All this using Terraform
1. Credentials
1. Nice and clean
1. Every major step in it's own file
1. Wize .gitignore file

## Setup
### Git stuff
Default .gitignore file for terraform. Avoid: 
* Secrets (*.tfvars)
* tfstate (how to keep it is not covered)

## Design, pr resource groups
1. Backend-Logging
    1. Log Analytics
    1. Application Insights
    1. And anything releated to logging
1. Backend-Network
    1. vNet
    1. 

## Secrets
### credentials.tfvars
tenant_id                           = "xx-x-x-x-xx"
subscription_id                     = "xx-x-x-x-xx"       
client_id                           = "xx-x-x-x-xx"
client_secret                       = "xxx"
sql_administrator_login             = "xxx"
sql_administrator_password          = "xxx"

## And the show can start
terraform init  
terraform validate  
terraform plan -var-file .\credentials.tfvars  





## Links
1. [Hashicorp Terraform](https://www.hashicorp.com/products/terraform)
1. [Overview of Terraform on Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/overview)
1. [Hashicorp Developer](https://developer.hashicorp.com/terraform/tutorials/azure-get-started)
1. [Terrafy Github](https://github.com/Azure/aztfy#goal)

