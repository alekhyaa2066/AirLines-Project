variable "rsg_name" {
  type = string
  description = "Specify rg name"
}

variable "rsg_location" {
  type = string
  description = "Specify location of rg"
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Specify tags of rg"
}