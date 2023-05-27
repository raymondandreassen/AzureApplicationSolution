#
#
# Resource Groups
#
#

locals {
  rgname_backendnetwork     = "Backend-Network"
  rgname_backendlogging     = "Backend-Logging" 
  rgname_backenddatabase    = "Backend-Database" 

  tags_sectionRG = { tfVer = "2023-05-27" }
}


resource "azurerm_resource_group" "Backend-Network" {
  name            = local.rgname_backendnetwork
  location        = local.resource_location
  tags            = "${merge( local.tags_global, local.tags_sectionRG )}"
}
resource "azurerm_resource_group" "Backend-Logging" {
  name            = local.rgname_backendlogging
  location        = local.resource_location
  tags            = "${merge( local.tags_global, local.tags_sectionRG )}"
}
resource "azurerm_resource_group" "Backend-Database" {
  name            = local.rgname_backenddatabase
  location        = local.resource_location
  tags            = "${merge( local.tags_global, local.tags_sectionRG )}"
}

