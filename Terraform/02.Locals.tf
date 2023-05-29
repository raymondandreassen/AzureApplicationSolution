#
#
# Globale variabler
#
#
# 172.17.16.128/25  : vlan_AddressSpace 
# 172.17.16.192/26  : vlan_BackendSubnet
# 172.17.16.128/26  : vlan_FrontendSubnet
# 172.17.1.4        : firewall
# 172.17.8.0/26     : subnet til DC
# egen subID        : 43c28f9e-9606-4f3a-8c1f-d97b98a6642d¨



locals {
  tag_appName                     = "myDataCenter"
  # applicationID                   = "${local.tag_appName}"  
  resource_location               = "norwayeast"            // westeurope, northeurope, norwayeast
  tag_appEnviroment               = "t"                    // d = dev, t = test/staging, p = produksjon
  # tag_AddressSpace                = "172.17.16.128/26"

// For simplicity, we divede the network into /27, and hands out in chuncks of 32 addresses
// 0-31, 32-63, 64-95, 96-127, 128-159, 160-191, 192-223, 224-256
// Then we can easily add more subnets if needed, in later stages
  vNet_AddressSpace               = ["10.200.200.0/24"] 
  vNet_SubnetBackend_Apps         = ["10.200.200.0/27"]      // 0-31        32 addresses
  vNet_SubnetFree1                = ["10.200.200.32/27"]     // 32-63       32 addresses
  vNet_SubnetFree2                = ["10.200.200.64/27"]     // 64-95       32 addresses
  vNet_SubnetFree3                = ["10.200.200.96/27"]     // 96-127      32 addresses
  vNet_SubnetFree4                = ["10.200.200.128/27"]    // 128-159     32 addresses
  vNet_SubnetBackend_Resources    = ["10.200.200.160/27"]    // 160-191     32 addresses
  vNet_SubnetGateway              = ["10.200.200.224/28"]    // 224-239     16 addresses
  vNet_SubnetAppGateway           = ["10.200.200.240/28"]    // 240-256     16 addresses

  #privateLinkIp1                  = "10.200.200.160"
  #privateLinkIp2                  = "10.200.200.161"


  # network_firewall_ip             = "172.17.1.4"
  # network_dc_subnet               = "172.17.8.0/26"

  # logging_workspaceid             = "32290537-4df0-4f81-980f-0c53b75de9bf"
  # logging_workspace_id            = "/subscriptions/56ab4a17-1af9-4e69-b69b-81401df372cf/resourceGroups/p-mgt-mon/providers/Microsoft.OperationalInsights/workspaces/p-mgt-monmiiuduqfxo-ws"

  # waf_we1net_name                 = "p-we1net-network-vnet"
  # waf_we1net_id                   = "/subscriptions/92d8e42a-c3ea-498c-a59d-61731404c5ce/resourceGroups/p-we1net-network/providers/Microsoft.Network/virtualNetworks/p-we1net-network-vnet"
  # waf_we1waf_name                 = "p-we1waf-network-vnet"
  # waf_we1waf_id                   = "/subscriptions/946aa67c-c83d-4e4a-8ecc-772e5ba44ff3/resourceGroups/p-we1waf-network/providers/Microsoft.Network/virtualNetworks/p-we1waf-network-vnet"

  # eventgridId                     = "/subscriptions/f9d02df7-d106-49a0-867b-6e4f8f258a15/resourceGroups/p-gov-cng/providers/Microsoft.Web/sites/p-gov-cng75bg5lbco7-func/functions/event_AzureActivitiesSink"
  # eventgrid_resourceid            = "/subscriptions/43c28f9e-9606-4f3a-8c1f-d97b98a6642d"

  tags_global = { 
      App           = local.tag_appName
      Env           = local.tag_appEnviroment
    }
}

