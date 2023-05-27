#
# Web Application Gateway
#

# azurerm_application_gateway
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway

# azurerm_web_application_firewall_policy
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy

locals {    
    instance_count                        = 1     // Number of instances to deploy
}     


resource "azurerm_public_ip" "application_gateway_vnet_public_ip" {
  name                                = "${local.tag_appName}-NetworkGateway-PublicIP"
  resource_group_name                 = azurerm_resource_group.Backend-Network.name
  location                            = local.resource_location
  allocation_method                   = "Dynamic"    
   tags                               = { tfVer = "2023-05-27" }
}

resource "azurerm_application_gateway" "application_gateway" {
   name                               = "${local.tag_appName}-application-gateway"
   resource_group_name                = azurerm_resource_group.Backend-Network.name
   location                           = local.resource_location
   tags                               = { tfVer = "2023-05-27" }

   sku {
     name                             = "WAF_Medium"                // Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2.
     tier                             = "WAF"                       // Standard, Standard_v2, WAF and WAF_v2.
     capacity                         = local.instance_count        // When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU.
   }
   gateway_ip_configuration {
     name                             = "AppGw-gateway-ip-configuration"
     subnet_id                        = azurerm_subnet.subnetAppGateway.id
   }
  frontend_ip_configuration {
     name                             = "AppGw-frontend-ipconfig"
     public_ip_address_id             = azurerm_public_ip.application_gateway_vnet_public_ip.id
   }
   frontend_port {
     name                             = "AppGw-frontend-port"
     port                             = 80                          // TODO: SSL
   }
   backend_address_pool {
     name                             = "AppGw-backend-address-pool"
   }
   backend_http_settings {
     name                             = "AppGw-backend-http-setting"
     cookie_based_affinity            = "Disabled"
     path                             = "/path1/"
     port                             = 80
     protocol                         = "Http"
     request_timeout                  = 60
   
     connection_draining {
      enabled                         = true
      drain_timeout_sec               = 60                          // TODO: Maybe longer would be better
      }
   }
   http_listener {
     name                             = "AppGw-local-http-listner"
     frontend_ip_configuration_name   = "AppGw-frontend-ipconfig"
     frontend_port_name               = "AppGw-frontend-port"
     protocol                         = "Http"
   }
   request_routing_rule {
     name                             = "AppGw-request-routintg"
     rule_type                        = "Basic"
     http_listener_name               = "AppGw-local-http-listner"
     backend_address_pool_name        = "AppGw-backend-address-pool"
     backend_http_settings_name       = "AppGw-backend-http-setting"
   }
}