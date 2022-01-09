resource "azurerm_resource_group" "RSG" {
  name = var.rsg_name
  location = var.rsg_location
  tags = var.tags
}