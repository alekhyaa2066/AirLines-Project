variable "tags" {
  type = map(string)
  default = {}
}

variable "nic_list" {
  type = any
}

variable "vm_list" {
 type = any 
}

variable "subnet_map_ids" {
  type = any
}

variable "public_ip_map_ids" {
  type = any
  default = {}
}


variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}
