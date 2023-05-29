
# # ROUTING 
# resource "azurerm_route_table" "vite_app_netrouting_backend" {
#   name                              = local.routetablebackend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   disable_bgp_route_propagation     = true
#   location                          = local.resource_location
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Network
#   ]
# }
# resource "azurerm_route_table" "vite_app_netrouting_frontend" {
#   name                              = local.routetablefrontend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   disable_bgp_route_propagation     = true
#   location                          = local.resource_location
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Network
#   ]
# }

# resource "azurerm_route_table" "vite_app_netrouting_gateway" {
#   name                              = local.routetablegateway
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   disable_bgp_route_propagation     = true
#   location                          = local.resource_location
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Network
#   ]
# }


# # ROUTES
# resource "azurerm_route" "vite_app_netrouting_routeEverywhere" {
#   name                              = "Everywhere"
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   address_prefix                    = "0.0.0.0/0"
#   next_hop_in_ip_address            = local.network_firewall_ip
#   next_hop_type                     = "VirtualAppliance"
#   route_table_name                  = local.routetablebackend
#   depends_on = [
#     azurerm_route_table.vite_app_netrouting_backend,
#   ]
# }
# resource "azurerm_route" "vite_app_netrouting_routeEverywhereFrontend" {
#   name                              = "Everywhere"
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   address_prefix                    = "0.0.0.0/0"
#   next_hop_in_ip_address            = local.network_firewall_ip
#   next_hop_type                     = "VirtualAppliance"
#   route_table_name                  = local.routetablefrontend
#   depends_on = [
#     azurerm_route_table.vite_app_netrouting_frontend,
#   ]
# }

# resource "azurerm_route" "vite_app_netrouting_routeEverywhereGateway" {
#   name                              = "Everywhere"
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   address_prefix                    = "0.0.0.0/0"
#   next_hop_in_ip_address            = local.network_firewall_ip
#   next_hop_type                     = "VirtualAppliance"
#   route_table_name                  = local.routetablegateway
#   depends_on = [
#     azurerm_route_table.vite_app_netrouting_gateway,
#   ]
# }


