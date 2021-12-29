provider "azurerm" {
  features {
  }
  subscription_id = "94a17abb-3b06-4775-b208-c36b78db5987"
}

module "rg" {
  source   = "**/resource_group"
  rsg_name  = var.resource_group_name
  rsg_location = var.resource_group_location
  tags = var.tags
}

module "network" {
  source              = "**/vnet"
  resource_group_name = module.rg.rsg_name
  location            = module.rg.rsg_location
  vnet_name           = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_list         =  var.subnet_list
}

module "virtual_machine" {
  source              = "**/virtual_machine"
  resource_group_name = module.rg.rsg_name
  location            = module.rg.rsg_location
  vm_list             = var.vm_list
  nic_list            = var.nic_list
  subnet_map_ids      = module.network.subnet_map_ids
}
