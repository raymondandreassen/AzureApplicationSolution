



resource "azurerm_service_plan" "appserviceplan_dev" {
  name                = "AppServiceplan-Dev"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.Backend-Resources.name
  os_type             = "Linux"
  sku_name            = "SHARED"
}

resource "azurerm_service_plan" "appserviceplan_basic_1" {
  name                = "AppServiceplan-Basic"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.Backend-Resources.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_service_plan" "appserviceplan_standard_1" {
  name                = "AppServiceplan-Standard"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.Backend-Resources.name
  os_type             = "Linux"
  sku_name            = "S1"
}

# sku_name - (Required) The SKU for the plan. Possible values include 
# SHARED, 
# B1, B2, B3, 
# S1, S2, S3,  
# D1, 
# F1, 
# I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, 
# P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, 
# EP1, EP2, EP3, WS1, WS2, WS3, and Y1.

# Only Basic, all premium and isolated tiers supports vnet networking.

# https://azure.microsoft.com/en-us/pricing/details/app-service/windows/

# Free, F1
# Shared, D1
# Basic, B1, B2, B3
# Standard, S1, S2, S3
# Premium, P1v2, P2v2, P3v2
# PremiumV2, P1v3, P2v3, P3v3, P4v3, P5v3
# PremiumV3, P1v3, P2v3, P3v3, P4v3, P5v3
# Isolated, I1, I2, I3


# App Service Free and Shared (preview) service plans 
# are base tiers that run on the same Azure virtual machines as other App Service apps. 
# Some apps might belong to other customers. 
# These tiers are intended to be used only for development and testing purposes.

# PremiumV3
# P0v3    (1 vCPU, 4 GiB of memory)
# P1v3    (2 vCPU, 8 GiB of memory)
# P1mv3 (2 vCPU, 16 GiB of memory)
# P2v3    (4 vCPU, 16 GiB of memory)
# P2mv3 (4 vCPU, 32 GiB of memory)
# P3v3    (8 vCPU, 32 GiB of memory) 
# P3mv3 (8 vCPU, 64 GiB of memory)
# P4mv3 (16 vCPU, 128 GiB of memory)
# P5mv3 (32 vCPU, 256 GiB of memory)

# App Service Plan SKU	Max Apps
# B1, S1, P1v2, I1v1	8
# B2, S2, P2v2, I2v1	16
# B3, S3, P3v2, I3v1	32
# P0v3	8
# P1v3, I1v2	16
# P2v3, I2v2, P1mv3	32
# P3v3, I3v2, P2mv3	64
# I4v2, I5v2, I6v2	Max density bounded by vCPU usage
# P3mv3, P4mv3, P5mv3	Max density bounded by vCPU usage