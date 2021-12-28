provider "azurerm" {
  features {
  }
  subscription_id = "ce9b0ee4-c92d-4f7d-b54f-c79a3f894fb3"
}

module "rg" {
  source   = "E:/979Notes/Project/AirLine-Infra/resource_group"
  rsg_name  = var.resource_group_name
  rsg_location = var.resource_group_location
  tags = var.tags
}

module "network" {
  source              = "E:/979Notes/Project/AirLine-Infra/vnet"
  resource_group_name = module.rg.rsg_name
  location            = module.rg.rsg_location
  vnet_name           = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_list         =  var.subnet_list
}

module "virtual_machine" {
  source              = "E:/979Notes/Project/AirLine-Infra/virtual_machine"
  resource_group_name = module.rg.rsg_name
  location            = module.rg.rsg_location
  vm_list             = var.vm_list
  nic_list            = var.nic_list
  subnet_map_ids      = module.network.subnet_map_ids
}