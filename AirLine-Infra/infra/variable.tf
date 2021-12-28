variable "resource_group_name" {
    type = string
}

variable "resource_group_location" {
    type = string
}

variable "tags" {
    type = map(string)
    default = {
    }
  
}

variable "subnet_list" {
    type = any
}

variable "vm_list" {
    type = any
}

variable "nic_list" {

}
