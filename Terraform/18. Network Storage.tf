#
# STORAGE ACCOUNT
#

# resource "azurerm_storage_account" "vite_app_strageaccount" {
#   name                          = lower("${local.tag_appEnviroment}${local.tag_appName}workdiagur3cx")
#   account_replication_type      = local.storageaccount_replicationtype
#   account_tier                  = local.storageaccount_accounttier
#   location                      = local.resource_location
#   min_tls_version               = local.storageaccount_minTls
#   resource_group_name           = azurerm_resource_group.rg-Backend-Network.name
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Network,
#   ]
# }

