#
# SQL SERVER
#
# When running a complete build, somehow it failes on the simple fact that master db is not created.
# Rerun, and it works, as a workaround. 

locals {    
    storage_name                        = "sqlstoreage"             // 3-24 characters, lowercase letters and numbers only.
    storage_account_tier                = "Standard"                // For instance Basic is limited by 2GB, Standard by 250GB, and Premium by 500GB per database. 
    storage_account_replication_type    = "LRS"                     // Local redundancy storage 
    sql_server_name                     = lower("${local.tag_appName}-sqlserver")
    sql_server_version                  = "12.0"                    // Highest version, checked 05.03.2023
    tags_sectionsql                     = { tfVer = "2023-05-27" }
}

resource "azurerm_storage_account" "sqlstorageaccount" {
  name                                  = lower("${local.tag_appName}${local.storage_name}")
  resource_group_name                   = azurerm_resource_group.Backend-Database.name
  location                              = local.resource_location
  account_tier                          = local.storage_account_tier
  account_replication_type              = local.storage_account_replication_type
  tags                                  = { tfVer = "2023-05-27" }
}

resource "azurerm_mssql_server" "sqlserver" {
  name                                  = local.sql_server_name
  resource_group_name                   = azurerm_resource_group.Backend-Database.name
  location                              = local.resource_location
  version                               = local.sql_server_version
  administrator_login                   = var.sql_administrator_login       // Se 1password
  administrator_login_password          = var.sql_administrator_password    // Se 1password
  public_network_access_enabled         = false                             // disable public network access
  minimum_tls_version                   = "1.2"                             // 18/03/2023, Raymond TLS 1.2    1.0, 1.1 , 1.2 and Disabled       
  // allow_ad_auth_only                    = true                             // Foreløbig, kun for Synapse 
  identity { type = "SystemAssigned" }
  azuread_administrator {
    login_username                      = var.sql_administrator
    object_id                           = "9fded440-a6cc-4a55-8f76-69aee2c19b13"    // TODO: HIDE
    tenant_id                           = "4e7f212d-74db-4563-a57b-8ae44ed05526"    // TODO: HIDE
  }
  tags                                  = { tfVer = "2023-05-27" }
  #depends_on                            = [ azurerm_user_assigned_identity.vite_sql_userassignedidentity ]
}
resource "azurerm_mssql_server_extended_auditing_policy" "sqlserver_auditpolicy" {
  server_id                               = azurerm_mssql_server.sqlserver.id
  log_monitoring_enabled                  = true
} 


# resource "azurerm_mssql_database" "vitesqlfirstdatabase" {
#   name                                    = "example-db"
#   server_id                               = azurerm_mssql_server.vite_sqlserver.id
#   collation                               = "SQL_Latin1_General_CP1_CI_AS"
#   license_type                            = "LicenseIncluded"                         // LicenseIncluded, BasePrice.
#   max_size_gb                             = 4
#   read_scale                              = true
#   sku_name                                = "S0"                                      // GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100 (og flere)
#   zone_redundant                          = false
#   auto_pause_delay_in_minutes             = 60  // 60 minutes 
#   storage_account_type                    = "Local"                                   // Geo, Local and Zone

#   tags = {
#     foo = "bar"
#   }
# }


# resource "azurerm_monitor_diagnostic_setting" "sqlserver_logging" {
#   name                                    = "${local.sql_server_name}-loganalytics"
#   target_resource_id                      = "${azurerm_mssql_server.sqlserver.id}/databases/master"
#   log_analytics_workspace_id              = azurerm_log_analytics_workspace.log_analytics_workspace.id
#   enabled_log {
#     category = "SQLSecurityAuditEvents"
#     retention_policy { enabled = false }
#   }

#   metric {
#     category = "AllMetrics"
#     retention_policy { enabled = false }
#   }
# }

# DB Private Endpoint
resource "azurerm_private_endpoint" "sqlserver-endpoint" {
  depends_on                            = [azurerm_mssql_server.sqlserver]
  name                                  = "${local.sql_server_name}-endpoint"
  location                              = local.resource_location
  resource_group_name                   = azurerm_resource_group.Backend-Database.name
  subnet_id                             = azurerm_subnet.subnetBackendResources.id
  private_service_connection {
    name                                = "${local.sql_server_name}-endpoint"
    is_manual_connection                = "false"
    private_connection_resource_id      = azurerm_mssql_server.sqlserver.id
    subresource_names                   = ["sqlServer"]
  }
  tags                                  = { tfVer = "2023-05-27" } 
}

# # DB Private Endpoint Connecton
# data "azurerm_private_endpoint_connection" "vite-sqlserver-endpointconnection" {
#   depends_on                            = [azurerm_private_endpoint.vite-sqlserver-endpoint]
#   name                                  = azurerm_private_endpoint.vite-sqlserver-endpoint.name
#   resource_group_name                   = azurerm_resource_group.rg-Backend-Database.name
# }

# # DB Private DNS A Record
# Jeg mangler ID til privat DNS Zone privatelink.database.windows.net
# resource "azurerm_private_dns_a_record" "vitesqlserver-endpoint-dns-a-record" {
#   depends_on                            = [azurerm_mssql_server.vite_sqlserver]
#   name                                  = lower(azurerm_mssql_server.vite_sqlserver.name)
# //  zone_name                             = azurerm_private_dns_zone.vnet-endpoint-internaldns-databasezone.name
#   zone_name                             = "privatelink.database.windows.net"      // Kan ikke refere her, da de er utenfor terraform
#   resource_group_name                   = azurerm_resource_group.rg-Backend-Database.name
#   ttl                                   = 300
#   records                               = [data.azurerm_private_endpoint_connection.vite-sqlserver-endpointconnection.private_service_connection.0.private_ip_address]
  
#   connection {
#     name                                = "vite_sqlserver-endpoint"
#     private_dns_zone_id                 = azurerm_private_dns_zone.vnet-endpoint-internaldns-databasezone.id
#   }

#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section06
#     )}"
# }

# Private DNS to VNET link
# Kan ikke kjøres fordi: Virtual Network Link Name: "vitesqldb-vnet-link"): polling after CreateOrUpdate: Code="Conflict" Message="Private zone 'privatelink.database.windows.net' is already linked to the virtual network '/subscriptions/aad6e5e4-7d41-4109-bcee-8ea0c2ba370d/resourceGroups/Backend-Network/providers/Microsoft.Network/virtualNetworks/vNet-Vite2'."
# resource "azurerm_private_dns_zone_virtual_network_link" "dns-zone-to-vnet-link" {
#   name                        = "vitesqldb-vnet-link"
#   resource_group_name         = azurerm_resource_group.Backend-Network.name
#   private_dns_zone_name       = azurerm_private_dns_zone.vnet-endpoint-internaldns-databasezone.name
#   virtual_network_id          = azurerm_virtual_network.vNetwork.id
# }

############################ OUTPUTS ############################

#output "sql_db" {
#  description = "SQL Server DB and Database"
#  value = "${azurerm_sql_database.kopi-sql-db.server_name}/${azurerm_sql_database.kopi-sql-db.name}"
#}

# resource "azurerm_mssql_server_security_alert_policy" "vite_sqlserver_securityalertpolicy" {
# resource "azurerm_mssql_virtual_network_rule" "vite_sqlserver_networkrule" {
#   name                = "vnet-rule-mssqlserver"
#   server_id           = azurerm_mssql_server.vite_sqlserver.id
#   subnet_id           = azurerm_subnet.res-vNet-BackendResources.id          # specify subnet id for virtual network rule
# }
# resource "azurerm_mssql_database" "test" {
#   name           = "vite_test_db"
#   server_id      = azurerm_mssql_server.vite_sqlserver.id
#   collation      = "SQL_Latin1_General_CP1_CI_AS"
#   license_type   = "LicenseIncluded"
#   max_size_gb    = 4
#   read_scale     = true
#   sku_name       = "S0"
#   zone_redundant = true
#   tags = {
#   }
# }