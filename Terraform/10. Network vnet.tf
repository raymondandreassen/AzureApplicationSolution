#
# VIRTUAL NETWORK
#

resource "azurerm_virtual_network" "vnet_app" {
  name                              = "${local.tag_appName}-vNet"
  resource_group_name               = azurerm_resource_group.Backend-Network.name
  address_space                     = local.vNet_AddressSpace
  location                          = local.resource_location
  depends_on                        = [ azurerm_resource_group.Backend-Network ]
  tags                               = { tfVer = "2023-05-27" }
}

# SUBNETS
resource "azurerm_subnet" "subnetBackendResources" {
  address_prefixes                  = local.vNet_SubnetBackend_Resources
  name                              = "SubnetBackendResources"
  resource_group_name               = azurerm_resource_group.Backend-Network.name
  service_endpoints                 = ["Microsoft.KeyVault", "Microsoft.Storage"]
  virtual_network_name              = azurerm_virtual_network.vnet_app.name  
  depends_on                        = [ azurerm_virtual_network.vnet_app ]
}

resource "azurerm_subnet" "subnetBackendApps" {
  address_prefixes                  = local.vNet_SubnetBackend_Apps
  name                              = "SubnetBackendApplications"
  resource_group_name               = azurerm_resource_group.Backend-Network.name
  virtual_network_name              = azurerm_virtual_network.vnet_app.name 
  depends_on                        = [ azurerm_virtual_network.vnet_app  ]
}

resource "azurerm_subnet" "subnetGateway" {
  address_prefixes                  = local.vNet_SubnetGateway
  name                              = "GatewaySubnet"
  resource_group_name               = azurerm_resource_group.Backend-Network.name
  // service_endpoints                 = ["Microsoft.KeyVault", "Microsoft.Storage"]
  virtual_network_name              = azurerm_virtual_network.vnet_app.name 
  depends_on                        = [ azurerm_virtual_network.vnet_app ]
}

resource "azurerm_subnet" "subnetAppGateway" {
  address_prefixes                  = local.vNet_SubnetAppGateway
  name                              = "AppGatewaySubnet"
  resource_group_name               = azurerm_resource_group.Backend-Network.name
  // service_endpoints                 = ["Microsoft.KeyVault", "Microsoft.Storage"]
  virtual_network_name              = azurerm_virtual_network.vnet_app.name 
  depends_on                        = [ azurerm_virtual_network.vnet_app ]
}

# Since Azure makes a network watcher, under resourcegroup NetworkWatcherRG. So let's make it before azure does, in the rg we want.
  resource "azurerm_network_watcher" "vnet_network_watcher" {
    name                          = "${local.tag_appName}-NetworkWatcher"
    location                      = local.resource_location
    resource_group_name           = azurerm_resource_group.Backend-Network.name
  }