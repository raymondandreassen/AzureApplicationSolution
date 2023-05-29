
#
# Network Peering
#

# resource "azurerm_virtual_network_peering" "vite_app_peering_fw_gw_subnet" {
#   name                          = local.waf_we1net_name  
#   remote_virtual_network_id     = local.waf_we1net_id    
#   resource_group_name           = azurerm_resource_group.rg-Backend-Network.name
#   virtual_network_name          = "${local.tag_appEnviroment}-${local.tag_appName}-network-vnet"
#   depends_on = [
#     azurerm_virtual_network.vite_app_vnet,
#   ]
# }

# resource "azurerm_virtual_network_peering" "vite_app_peering_waf_subnet" {
#   name                          = local.waf_we1waf_name  
#   remote_virtual_network_id     = local.waf_we1waf_id     
#   resource_group_name           = azurerm_resource_group.rg-Backend-Network.name
#   virtual_network_name          = "${local.tag_appEnviroment}-${local.tag_appName}-network-vnet"
#   depends_on = [
#     azurerm_virtual_network.vite_app_vnet,
#   ]
# }



