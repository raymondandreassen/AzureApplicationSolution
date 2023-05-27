
# #
# # NETTVERKS AUDIT OG LOGGING
# #

# resource "azurerm_network_watcher" "vite_app_networkwatcher" {
#   location                          = local.resource_location
#   name                              = "${local.tag_appEnviroment}-${local.tag_appName}-network-networkwatcher"
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Network,
#   ]
# }

# resource "azurerm_eventgrid_system_topic" "vite_app_audit_AGE" {
#   location                      = "global"
#   name                          = "${local.tag_appEnviroment}-${local.tag_appName}-audit-governance-egst"
#   resource_group_name           = azurerm_resource_group.rg-Backend-Logging.name
#   source_arm_resource_id        = local.eventgrid_resourceid
#   # TODO: I eksemplet referer de source_arm_resource_id til en resurrsgruppe
#   tags = {
#   }
#   topic_type = "microsoft.resources.subscriptions"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Logging
#   ]
# }
# resource "azurerm_eventgrid_system_topic_event_subscription" "vite_app_audit_AGEsubscr" {
#   labels                        = ["IaCVersion 2021-04-14", "ConfigVersion 3.9.1.1652", "functions-event_azureactivitiessink"] # TODO: wtf er dette?
#   name                          = "governance"
#   resource_group_name           = azurerm_resource_group.rg-Backend-Logging.name
#   system_topic                  = "${local.tag_appEnviroment}-${local.tag_appName}-audit-governance-egst"
#   advanced_filter {



  
#     string_not_contains {
#       key    = "data.operationName"
#       values = [
#         "Microsoft.Resources/tags/write", 
#         "Microsoft.Resources/deployments/write", 
#         "Microsoft.Security/policies/write", 
#         "Microsoft.Authorization/locks/write", 
#         "Microsoft.Authorization/roleAssignments/write", 
#         "microsoft.insights/diagnosticSettings/write", 
#         "Microsoft.EventGrid/systemTopics/eventSubscriptions/write", 
#         "Microsoft.Web/sites/Extensions/write", 
#         "Microsoft.Web/sites/host/functionKeys/write", 
#         "Microsoft.Compute/restorePointCollections/restorePoints/write", 
#         "Microsoft.OperationalInsights/workspaces/linkedServices/write", 
#         "Microsoft.Security/workspaceSettings/write", 
#         "Microsoft.Security/pricings/write"
#         ]
#     }
#   }
#   azure_function_endpoint {
#     function_id                       = local.eventgridId
#     max_events_per_batch              = 1
#     preferred_batch_size_in_kilobytes = 64
#   }
#   depends_on = [
#     azurerm_eventgrid_system_topic.vite_app_audit_AGE,
#   ]
# }


# resource "azurerm_network_watcher_flow_log" "vite_app_networkflowlog_backend" {
#   enabled                           = true
#   name                              = "BackendSubnet-flowlog"
#   network_security_group_id         = azurerm_network_security_group.vite_app_netNSGbackend.id
#   network_watcher_name              = "${local.tag_appEnviroment}-${local.tag_appName}-network-networkwatcher"
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   storage_account_id                = azurerm_storage_account.vite_app_strageaccount.id 
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   retention_policy {
#     days    = 30
#     enabled = true
#   }
#   traffic_analytics {
#     enabled                         = true
#     interval_in_minutes             = 10
#     workspace_id                    = local.logging_workspaceid
#     workspace_region                = local.resource_location
#     workspace_resource_id           = local.logging_workspace_id
#   }
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGbackend,
#     azurerm_network_watcher.vite_app_networkwatcher,
#     azurerm_storage_account.vite_app_strageaccount,
#   ]
# }
# resource "azurerm_network_watcher_flow_log" "vite_app_networkflowlog_frontend" {
#   enabled                           = true
#   name                              = "FrontendSubnet-flowlog"
#   network_security_group_id         = azurerm_network_security_group.vite_app_netNSGfrontend.id 
#   network_watcher_name              = "${local.tag_appEnviroment}-${local.tag_appName}-network-networkwatcher"
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   storage_account_id                = azurerm_storage_account.vite_app_strageaccount.id 
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   retention_policy {
#     days    = 30
#     enabled = true
#   }
#   traffic_analytics {
#     enabled                         = true
#     interval_in_minutes             = 10
#     workspace_id                    = local.logging_workspaceid
#     workspace_region                = local.resource_location
#     workspace_resource_id           = local.logging_workspace_id
#   }
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGfrontend,
#     azurerm_network_watcher.vite_app_networkwatcher,
#     azurerm_storage_account.vite_app_strageaccount,
#   ]
# }
