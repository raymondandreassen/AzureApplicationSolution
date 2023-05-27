# #
# # NETTVERKS PRIVATE LINK 
# #

# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_link_service

# resource "azurerm_private_link_service" "vnet_privatelink" {
#   name                      = "${local.tag_appName}-privatelink"
#   resource_group_name       = azurerm_resource_group.Backend-Network.name
#   location                  = local.resource_location
#   tags                      = { tfVer = "2023-05-27" }

#   load_balancer_frontend_ip_configuration_ids = [  ]        // azurerm_lb.example.frontend_ip_configuration.0.id]

#   #auto_approval_subscription_ids              = local.network_allowedsubid  // NONE = ALL 
#   #visibility_subscription_ids                 = local.network_visiblesubid  // NONE = ALL

#   nat_ip_configuration {
#     name                       = "primary"
#     private_ip_address         = local.privateLinkIp1
#     private_ip_address_version = "IPv4"
#     subnet_id                  = azurerm_subnet.subnetBackendResources.id
#     primary                    = true
#   }

  # nat_ip_configuration {
  #   name                       = "secondary"
  #   private_ip_address         = local.privateLinkIp2
  #   private_ip_address_version = "IPv4"
  #   subnet_id                  = azurerm_subnet.subnetBackendResources.id
  #   primary                    = false
  # }
#}