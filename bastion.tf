# Deployes Azure Bastion host resources

# East US 2 Bastion
resource "azurerm_resource_group" "estus2bastionrg" {
  name     = "${var.prefix}-eu2-bastion-${module.naming.resource_group.name}" #"${var.prefix}-EastUS2Bastion-rg"
  location = "eastus2"
}

resource "azurerm_public_ip" "eastus2bastionpip" {
  name                = "${var.prefix}-eu2-bastion-${module.naming.public_ip.name}"
  location            = azurerm_resource_group.estus2bastionrg.location
  resource_group_name = azurerm_resource_group.estus2bastionrg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "eastus2bastion" {
  name                = "${var.prefix}-eu2-bastion-${module.naming.bastion_host.name}"
  location            = azurerm_resource_group.estus2bastionrg.location
  resource_group_name = azurerm_resource_group.estus2bastionrg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.eastus2bastion.id
    public_ip_address_id = azurerm_public_ip.eastus2bastionpip.id
  }
}