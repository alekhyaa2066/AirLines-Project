provider "azurerm" {
  features {
  }
  subscription_id = "94a17abb-3b06-4775-b208-c36b78db5987"
}

module "rg" {
  source   = "./resource_group"
  rsg_name  = var.resource_group_name
  rsg_location = var.resource_group_location
  tags = var.tags
}



module "acr" {
  source = "./acr"
  acr_name = var.acrname
  rgname = module.rg.rsg_name
  location=module.rg.rsg_location
  skutype=var.skutype
  isAdminEnabled=var.adminenabled
  
}

module "aks" {
  source = "./aks"
  aksname = var.aksname
  location = module.rg.rsg_location
  rsgname = module.rg.rsg_name
  dnsprefix = var.aksname
}
