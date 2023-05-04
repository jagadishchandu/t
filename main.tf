module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
}

# Obtain client configuration from the azurerm provider
data "azurerm_client_config" "core" {
  provider = azurerm
}

data "azurerm_virtual_network" "eastus2hubvnet" {
  name                = "PJTDEV-hub-eastus2"
  resource_group_name = "PJTDEV-connectivity-eastus2"
}

data "azurerm_virtual_network" "uksouthhubvnet" {
  name                = "PJTDEV-hub-uksouth"
  resource_group_name = "PJTDEV-connectivity-uksouth"
}

data "azurerm_subnet" "eastus2servers" {
  name                 = "Servers"
  virtual_network_name = data.azurerm_virtual_network.eastus2hubvnet.name
  resource_group_name  = data.azurerm_virtual_network.eastus2hubvnet.resource_group_name
}

data "azurerm_subnet" "uksouthservers" {
  name                 = "Servers"
  virtual_network_name = data.azurerm_virtual_network.uksouthhubvnet.name
  resource_group_name  = data.azurerm_virtual_network.uksouthhubvnet.resource_group_name
}

data "azurerm_subnet" "eastus2bastion" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = data.azurerm_virtual_network.eastus2hubvnet.name
  resource_group_name  = data.azurerm_virtual_network.eastus2hubvnet.resource_group_name
}