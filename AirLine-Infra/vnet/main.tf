resource "azurerm_virtual_network" "vnet" {
    name = var.vnet_name
    resource_group_name = var.resource_group_name
    location = var.location
    address_space = var.address_space
    bgp_community = var.bgp_community
    dns_servers = var.dns_servers
    tags = var.tags
    flow_timeout_in_minutes  = var.flow_timeout_in_minutes 
    # ddos_protection_plan {
    #   id = var.ddos_pp.enable ? var.ddos_pp.id : null
    #   enable = var.ddos_pp.enable
    # }
}

resource "azurerm_subnet" "subnet" {
    for_each = var.subnet_list
      name = each.value["subnet_name"]
      resource_group_name = var.resource_group_name
      virtual_network_name = azurerm_virtual_network.vnet.name
      address_prefixes = each.value["address_prefixes"]
      enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
      enforce_private_link_service_network_policies = lookup(each.value, "enforce_private_link_service_network_policies", false)
      service_endpoints = lookup(each.value,"service_endpoints", [])
}