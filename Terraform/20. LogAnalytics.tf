#
#   Log Analytics Workspace and Application Insights
#

locals {
    log_analytics_workspace_sku             = "PerGB2018"                               # Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018. Defaults to PerGB2018.
    log_analytics_workspace_retension       = 30
    app_insights_name                       = "${local.tag_appName}-appinsights"  
    app_insights_type                       = "web" 
    tags_sectionLog                         = { tfVer = "2023-05-27" }
}

// Pricing models: https://learn.microsoft.com/en-us/azure/azure-monitor//usage-estimated-costs#moving-to-the-new-pricing-model

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
   name                                     = "${local.tag_appName}-loganalyticsworkspace"
   location                                 = local.resource_location
   resource_group_name                      = azurerm_resource_group.Backend-Logging.name
   sku                                      = local.log_analytics_workspace_sku
   retention_in_days                        = local.log_analytics_workspace_retension
   tags                                     = { tfVer = "2023-05-27" }
}

resource "azurerm_application_insights" "log_application_insights" {
   name                                     = local.app_insights_name
   location                                 = local.resource_location
   resource_group_name                      = azurerm_resource_group.Backend-Logging.name
   workspace_id                             = azurerm_log_analytics_workspace.log_analytics_workspace.id
   application_type                         = local.app_insights_type
   depends_on                               = [ azurerm_log_analytics_workspace.log_analytics_workspace ]
   tags                                     = { tfVer = "2023-05-27" }
}

# output "instrumentation_key" {
#   description               = "Application Insights Instrumentation Key"
#   value                     = azurerm_application_insights.log_application_insights.instrumentation_key
#   sensitive                 = true
# }

# output "app_id" {
#   description = "Application Insights App ID"
#   value = azurerm_application_insights.log_application_insights.app_id
# }