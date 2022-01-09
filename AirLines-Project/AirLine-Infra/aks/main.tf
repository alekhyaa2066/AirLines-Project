resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname
  location            = var.location
  resource_group_name = var.rsgname
  dns_prefix          = var.dnsprefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

}