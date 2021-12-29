resource_group_name = "Airlines-rsg"

resource_group_location = "centralus"

tags = {
    project="Airline"
    env = "production"
}
subnet_list = {
  subnet1 = {
    subnet_name      = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    subnet_name      = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
  }
}

nic_list = {
  nic1 = {
    nic_name = "subnet1-nic"
    ip_config = [{
      ip_config_name = "ipconfig1"
      subnet_name    = "subnet1"
      ip_name        = null
      ip_add_alloc   = "Dynamic"
    }]
  }
}

vm_list = {
  vm1 = {
    vm_name        = "agentvm1"
    nic_key        = "nic1"
    vm_size        = "Standard_DS2_v2"
    admin_username = "adminuser"
    //username       = "adminuser"
    admin_password = "AArunkumar@2066"
    os_disk = [{
      caching              = "None"
      storage_account_type = "Premium_LRS"
    }]
  }
}

