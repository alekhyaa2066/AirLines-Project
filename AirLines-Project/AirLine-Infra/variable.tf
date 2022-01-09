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



variable "acrname" {
  type = string
}

variable "skutype" {
  type = string
}

variable "adminenabled" {
  type = bool
}

variable "aksname" {
  type = string
}

