terraform {
  required_providers {
    azurerm ={
        source = "hashicorp/azurerm"
        version = "3.15.00"
    }
  }
  backend "azurerm" {
    resource_group_name = var.bckrg
    storage_account_name = var.bckstg
    container_name = var.bckcont
    key = var.backkey
  }
}
provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "vnet-rg11" {
   name= var.rg11
   location = var.location11
   tags = var.tags11
  
}
resource "azurerm_virtual_network" "vnet11" {
    name = var.vnetname
    location = azurerm_resource_group.vnet-rg11.location
    resource_group_name = azurerm_resource_group.vnet-rg11.name
    address_space = var.vnetaddress_space
    tags= var.tags11
  
}
resource "azurerm_subnet" "subnet" {
    for_each = var.subnets
    resource_group_name = azurerm_resource_group.vnet-rg11.name
    virtual_network_name = azurerm_virtual_network.vnet11.name
    name                 = each.value["name"]
    address_prefixes     = each.value["address_prefixes"]
  
}
resource "azurerm_public_ip" "bastion_pubip" {
  name                = "${var.bastionhost_name}PubIP"
  location            = azurerm_resource_group.vnet-rg11.location
  resource_group_name = azurerm_resource_group.vnet-rg11.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags11
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastionhost_name
  location            = azurerm_resource_group.vnet-rg11.location
  resource_group_name = azurerm_resource_group.vnet-rg11.name
  tags                = var.tags11

  ip_configuration {
    name                 = "bastion_config"
    subnet_id            = azurerm_subnet.subnet["bastion_subnet"].id
    public_ip_address_id = azurerm_public_ip.bastion_pubip.id
  }
}