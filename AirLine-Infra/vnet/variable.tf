variable "vnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list
}
variable "bgp_community" {
  type = string
  default = null
}

variable "dns_servers" {
  type = list
  default = []
}

variable "flow_timeout_in_minutes" {
  type = string
  default = null
}

# variable "ddos_pp" {
#   type = object({
#     id = string
#     enable = bool
#   })
#   default = {
#     id = null
#     enable = false
#   }
# }

variable "subnet_list" {
  type = any
}

variable "tags" {
  type = map(string)
  default = {}
}