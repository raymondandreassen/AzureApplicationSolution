#
# NETWORK PRIVATE DNS
#



resource "azurerm_private_dns_zone" "mydatacenterprivatednszone" {
  name                        = var.privatednszone
  resource_group_name         = azurerm_resource_group.Backend-Network.name
  tags                        = { tfVer = "2023-05-29" }
}

resource "azurerm_private_dns_zone_virtual_network_link" "mydatacenterprivatednszone" {
  name                        = "mydatacenterprivatednszone-vnet-link"
  resource_group_name         = azurerm_resource_group.Backend-Network.name
  private_dns_zone_name       = azurerm_private_dns_zone.mydatacenterprivatednszone.name
  virtual_network_id          = azurerm_virtual_network.vnet_app.id
  registration_enabled        = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelinkvaultcore" {
  name                        = "mydatacenterprivatednszone-vnet-link"
  resource_group_name         = azurerm_resource_group.Backend-Network.name
  private_dns_zone_name       = "privatelink.vaultcore.azure.net"
  virtual_network_id          = azurerm_virtual_network.vnet_app.id
  registration_enabled        = true
}
resource "azurerm_private_dns_zone_virtual_network_link" "privatelinkdatabase" {
  name                        = "mydatacenterprivatednszone-vnet-link"
  resource_group_name         = azurerm_resource_group.Backend-Network.name
  private_dns_zone_name       = "privatelink.database.windows.net"
  virtual_network_id          = azurerm_virtual_network.vnet_app.id
  registration_enabled        = true
}

  # Key Vault:      privatelink.vaultcore.azure.net

  # Storage:    	  privatelink.database.windows.net        
  # Storage:    	  privatelink.blob.core.windows.net
  # Storage:    	  privatelink.table.core.windows.net  
  # Storage:    	  privatelink.queue.core.windows.net
  # Storage:    	  privatelink.file.core.windows.net
  # Storage:    	  privatelink.web.core.windows.net