resource "azurerm_container_registry" "acr" {

  name                = var.acr_name
  resource_group_name = var.rgname
  location            = var.location
  sku                 = var.skutype
  admin_enabled       = var.isAdminEnabled
  
}