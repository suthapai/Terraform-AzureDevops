variable "bckrg"{
    type = string
    description = "backend resource group"
    default = "bckrg"
  
}
variable "bckstg" {
    type = string
    description = "backend storage account name "
    default = "bckstg11"
}
variable "bckcont" {
    type = string
    description = "backend container name"
    default = "bckcont"
}
variable "backkey" {
    type = string
    description = "backend state key "
    default = "net.terraform.tfstate"
}
variable "rg11" {
    type        = string
    description = "The name of the resource group"
    default     = "rg11"
  
}
variable "location11" {
    type        = string
    description = "location"
    default     = "canadaeast"
}
variable "tags11" {
    type = map(string)
    description = "tags"
    default = {
      "env" = "lab"
       "owner"= "suj"
    }
  
}
variable "vnetname" {
  type = string
  description = "virtual network name"
  default = "vnet11"
}
variable "vnetaddress_space" {
  type = list(any)
  description = "Vnet address space"
  default = ["10.13.0.0/16"]
}
variable "subnets" {
  type = map(any)
  default = {
    subnet_1 = {
      name             = "subnet_1"
      address_prefixes = ["10.13.1.0/24"]
    }
    subnet_2 = {
      name             = "subnet_2"
      address_prefixes = ["10.13.2.0/24"]
    }
    subnet_3 = {
      name             = "subnet_3"
      address_prefixes = ["10.13.3.0/24"]
    }
    # The name must be AzureBastionSubnet
    bastion_subnet = {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.13.250.0/24"]
    }
  }
}
variable "bastionhost_name" {
  type        = string
  description = "The name of the basion host"
  default     = "bastian-vent11"
}