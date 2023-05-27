# #
# # NETTVERKS SIKKERHETSGRUPPE 
# #

# resource "azurerm_network_security_group" "vite_app_netNSGbackend" {
#   location                          = local.resource_location
#   name                              = local.networksecuritygroup_backend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Network,
#   ]
# }

# resource "azurerm_network_security_group" "vite_app_netNSGfrontend" {
#   location                          = local.resource_location
#   name                              = local.networksecuritygroup_frontend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section04
#     )}"
#   depends_on = [
#     azurerm_resource_group.rg-Backend-Network,
#   ]
# }

# #
# # NETTVERKS REGLER FOR BACKEND
# #

# resource "azurerm_network_security_rule" "vite_app_netNSGbackend_dc_dns" {
#   name                              = "AllowDnsFromDcsubnetBackendsubnet"
#   description                       = "Allow DNS replies from the domain controllers"
#   network_security_group_name       = local.networksecuritygroup_backend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name

#   destination_address_prefix        = local.vNet_SubnetFrontend
#   source_address_prefix             = local.vNet_AddressSpace

#   access                            = "Allow"
#   destination_port_range            = "53"
#   direction                         = "Inbound"
#   priority                          = 1200
#   protocol                          = "Udp"
#   source_port_range                 = "*"
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGbackend,
#   ]
# }
# resource "azurerm_network_security_rule" "vite_app_netNSGloadbal_backend" {
#   name                              = "AllowProbeFromAzureloadbalancerToBackendsubnet"
#   description                       = "Allow probe from Azure Load Balancer to the Backend Subnet"
#   network_security_group_name       = local.networksecuritygroup_backend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name

#   destination_address_prefix        = local.vNet_SubnetFrontend
#   destination_port_range            = "*"

#   access                            = "Allow"
#   direction                         = "Inbound"
#   priority                          = 3900
#   protocol                          = "*"
#   source_address_prefix             = "AzureLoadBalancer"
#   source_port_range                 = "*"
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGbackend,
#   ]
# }
# resource "azurerm_network_security_rule" "vite_app_net_denyAllBackend" {
#   name                              = "DenyAll"
#   description                       = "Deny all other traffic"
#   network_security_group_name       = local.networksecuritygroup_backend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name

#   destination_address_prefix        = "*"
#   source_address_prefix             = "*"

#   access                            = "Deny"
#   destination_port_range            = "*"
#   direction                         = "Inbound"
#   priority                          = 4000
#   protocol                          = "*"
#   source_port_range                 = "*"
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGbackend,
#   ]
# }

# #
# # NETTVERKS REGLER FOR FRONTEND
# #

# resource "azurerm_network_security_rule" "vite_app_netNSGfrontend_dc_dns" {
#   name                              = "AllowDnsFromDcsubnetToFrontendsubnet"
#   description                       = "Allow DNS replies from the domain controllers"
#   network_security_group_name       = local.networksecuritygroup_frontend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name

#   destination_address_prefix        = local.vNet_SubnetFrontend
#   source_address_prefix             = local.vNet_AddressSpace

#   access                            = "Allow"
#   destination_port_range            = "53"
#   direction                         = "Inbound"
#   priority                          = 1200
#   protocol                          = "Udp"
#   source_port_range                 = "*"
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGfrontend,
#   ]
# }
# resource "azurerm_network_security_rule" "vite_app_netNSGloadbal_frontend" {
#   name                              = "AllowProbeFromAzureloadbalancerToFrontendsubnet"
#   description                       = "Allow probe from Azure Load Balancer to the Frontend Subnet"
#   network_security_group_name       = local.networksecuritygroup_frontend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name
  
#   destination_address_prefix        = local.vNet_SubnetFrontend
#   source_address_prefix             = "AzureLoadBalancer"

#   access                            = "Allow"
#   destination_port_range            = "*"
#   direction                         = "Inbound"
#   priority                          = 3900
#   protocol                          = "*"
#   source_port_range                 = "*"
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGfrontend,
#   ]
# }
# resource "azurerm_network_security_rule" "vite_app_net_denyAllFrontend" {
#   name                              = "DenyAll"
#   description                       = "Deny all other traffic"
#   network_security_group_name       = local.networksecuritygroup_frontend
#   resource_group_name               = azurerm_resource_group.rg-Backend-Network.name

#   destination_address_prefix        = "*"
#   source_address_prefix             = "*"

#   access                            = "Deny"
#   destination_port_range            = "*"
#   direction                         = "Inbound"
#   priority                          = 4000
#   protocol                          = "*"
#   source_port_range                 = "*"
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGfrontend,
#   ]
# }


# resource "azurerm_subnet_network_security_group_association" "vite_app_network_nsg_association_backend" {
#   network_security_group_id = azurerm_network_security_group.vite_app_netNSGbackend.id 
#   subnet_id                 = azurerm_subnet.vite_app_subnetBackend.id                
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGbackend,
#     # EN AV DISSE TO
#     azurerm_subnet.vite_app_subnetBackend,
#     # azurerm_subnet_route_table_association.vite_app_network_routetable_association_backend 
#   ]
# }
# resource "azurerm_subnet_route_table_association" "vite_app_network_routetable_association_backend" {
#   route_table_id = azurerm_route_table.vite_app_netrouting_backend.id 
#   subnet_id      = azurerm_subnet.vite_app_subnetBackend.id 
#   depends_on = [
#     azurerm_route_table.vite_app_netrouting_backend,
#     # EN AV DISSE TO
#     azurerm_subnet.vite_app_subnetBackend
#     # azurerm_subnet_network_security_group_association.vite_app_network_nsg_association_backend 
#   ]
# }



# resource "azurerm_subnet_network_security_group_association" "vite_app_network_nsg_association_frontend" {
#   network_security_group_id = azurerm_network_security_group.vite_app_netNSGfrontend.id 
#   subnet_id                 = azurerm_subnet.vite_app_subnetFrontend.id 
#   depends_on = [
#     azurerm_network_security_group.vite_app_netNSGfrontend,
#     # EN AV DISSE TO
#     azurerm_subnet.vite_app_subnetFrontend,
#     # azurerm_subnet_route_table_association.vite_app_network_routetable_association_frontend
#   ]
# }

# resource "azurerm_subnet_route_table_association" "vite_app_network_routetable_association_frontend" {
#   route_table_id = azurerm_route_table.vite_app_netrouting_frontend.id 
#   subnet_id      = azurerm_subnet.vite_app_subnetFrontend.id 
#   depends_on = [
#     azurerm_route_table.vite_app_netrouting_frontend,
#     # EN AV DISSE TO
#     azurerm_subnet.vite_app_subnetFrontend,    
#     # azurerm_subnet_network_security_group_association.vite_app_network_nsg_association_frontend,
#   ]
# }

