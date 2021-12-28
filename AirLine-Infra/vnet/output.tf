output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
    value = [for i in azurerm_subnet.subnet: i.name]
}

output "subnet_ids" {
  value = [for i in azurerm_subnet.subnet: i.id]
}

output "subnet_map_ids" {
  value = {for i in azurerm_subnet.subnet: i.name => i.id }
}