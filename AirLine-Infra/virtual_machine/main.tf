resource "azurerm_network_interface" "example" {
  for_each = var.nic_list
  name                = each.value["nic_name"]
  location            = var.location
  resource_group_name = var.resource_group_name
  enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", null)
  tags = var.tags
  dynamic "ip_configuration" {
    for_each = each.value["ip_config"]
    content  {
      name                          = ip_configuration.value["ip_config_name"]
      subnet_id                     = lookup(var.subnet_map_ids, ip_configuration.value["subnet_name"])
      //private_ip_address_allocation = lookup(ip_configuration.value, "ip_config_name", "Dynamic")
      private_ip_address_allocation = ip_configuration.value["ip_add_alloc"]
      gateway_load_balancer_frontend_ip_configuration_id  = lookup(ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      private_ip_address_version = lookup(ip_configuration.value, "private_ip_address_version", "IPv4")
      //public_ip_address_id = lookup(var.public_ip_map_ids, lookup(ip_configuration.value, "ip_name", null), null)["id"]
    }
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  for_each = var.vm_list
  name                = each.value["vm_name"]
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = each.value["vm_size"]
  admin_username      = each.value["admin_username"]
  admin_password      = each.value["admin_password"]
  network_interface_ids = [
    lookup(azurerm_network_interface.example, each.value["nic_key"]).id,
  ]

  # admin_ssh_key {
  #   username   = each.value["username"]
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  dynamic "os_disk" {
      for_each = each.value["os_disk"]
      content  {
        caching              = os_disk.value["caching"]
        storage_account_type = os_disk.value["storage_account_type"]
        disk_size_gb = lookup(os_disk.value, "disk_size_gb", null)
        name = lookup(os_disk.value, "os_disk_name", "${each.value["vm_name"]}-osdisk")
      }
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}