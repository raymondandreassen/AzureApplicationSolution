#
#   credentials.tfvars fil. 
#

#   Application credentials
variable "subscription_id" {
    type = string
    description = "Azure subscription id (target subscription)"
}
variable "tenant_id" {
    type = string
    description = "Azure subscription tenant id"
}
variable "client_id" {
    type = string
    description = "App id for authentisering til Azure, see password manager."
}
variable "client_secret" {
    type = string
    description = "App password for authentisering til Azure, see password manager."
    sensitive = true
}

#   SQL server
variable "sql_administrator" {
    type = string
    description = "Sql Server administrator, Azure AD account."
}
variable "sql_administrator_login" {
    type = string
    description = "Username for sql login, see password manager."
}
variable "sql_administrator_password" {
    type = string
    description = "Sql logings password, see password manager."
    sensitive = true
}

