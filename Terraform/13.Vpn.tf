
# # VPN
# #

# locals {
#     clientaddressspace      = "10.100.0.0/24"
#     public_rootcert_name    = "CasperRootCert"
#     public_cert_data        = "MIIC7TCCAdWgAwIBAgIQPOIau0HHN6NINnkmbnGj3jANBgkqhkiG9w0BAQsFADAZ\nMRcwFQYDVQQDDA5DYXNwZXJSb290Q2VydDAeFw0yMzAzMTAxMzQ4MDFaFw0yNDAz\nMTAxNDA4MDFaMBkxFzAVBgNVBAMMDkNhc3BlclJvb3RDZXJ0MIIBIjANBgkqhkiG\n9w0BAQEFAAOCAQ8AMIIBCgKCAQEAy15piLjyiHqCkpm+WBXZ0/0fDmu5lCpXwDOU\nVnQAnxOfxnD8AYF2Mn90IzAjXxrXK2JDmcXL5I61zUR8kdzDf5hePjBO1Tdw+fcR\nORHPfHP7lC+CIW56oBBlrlMONQdpEHwC5DcU6NfpWIgscRF8eGAkGjUSAv+JAZjU\nxxTslsglh0QLwHIKkV3L2QXrl6+pCq9uxju7lll+xzFmJnXsLRkW09dsdaYjAx1Q\nNgjOFaoWRA1Te61TTjA7GFXK41k4b7qQommK/nG5IpPSuii5ihwt7s/nOzFtUb/q\nu1Jl/689nevjVb9KprNwLquFlAslGnIrAY51GoINY+rqCmsecQIDAQABozEwLzAO\nBgNVHQ8BAf8EBAMCAgQwHQYDVR0OBBYEFCdDIWdYTlXRMIK9oc0NWDkopCxuMA0G\nCSqGSIb3DQEBCwUAA4IBAQB7D5RQvb/9PXu4mm1THCH193mB4mvmSxp1cQBX6kY2\n/NKKm+2riN+Cwl4mdJO520We5Y4WE2VsFFnA2JPOsqBYWdrEsYutD+fGWiDiCZvR\nnK0OzbcM6H9gRFe4yNgnI3a9e9Md2AFiP77fhR4JusZJhEIMImGIEYJ8em6a06+9\nGlB4MxMW6itofjMOUcH97FZS5CieqW5BwtzmC/YJxKXAepU/nOJgoYfvQc+M3Ml4\nIINUrb0D3i3saSswbLyEe4C8fQmZ/9vviqepGsgb0GtWaBLMQLQRkLp9+qxVoKG8\nEF0WW1VI7/rHFUQtaUqH+nlNeUGqUWcaRqxzprlOQunn"
#     tags_section12 = { 
#       tfVersion             = "2023-05-08"
#     }
# }


# resource "azurerm_public_ip" "vnet_gateway_public_ip" {
#   name                            = "vnet-VPN-public_ip-${local.tag_appName}-${local.tag_appEnviroment}"
#   location                        = local.resource_location
#   resource_group_name             = azurerm_resource_group.Backend-Network.name
#   allocation_method               = "Dynamic"
  
#   tags = "${merge( 
#     local.tags_global, 
#     local.tags_section12
#     )}"  
# }

# resource "azurerm_virtual_network_gateway" "vnet_gateway_vite_app" {
#   name                            = "vnet-VPN-${local.tag_appName}-${local.tag_appEnviroment}"
#   location                        = local.resource_location
#   resource_group_name             = azurerm_resource_group.Backend-Network.name

#   type                            = "Vpn"
#   vpn_type                        = "RouteBased"

#   active_active                   = false
#   enable_bgp                      = false
#   sku                             = "Basic"

#   ip_configuration {
#     name                          = "vnetGatewayConfig"
#     public_ip_address_id          = azurerm_public_ip.vnet_gateway_public_ip.id
#     private_ip_address_allocation = "Dynamic"
#     subnet_id                     = azurerm_subnet.vite_app_subnetGateway.id  
#   }

#   vpn_client_configuration {
#     address_space = [local.clientaddressspace]
#     root_certificate {
#       name                        = local.public_rootcert_name
#       public_cert_data = <<EOF
# ${local.public_cert_data}
# EOF
#     }
#   }
# }

