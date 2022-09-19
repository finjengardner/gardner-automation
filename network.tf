resource "azurerm_virtual_network" "poc_network" {
  name                = "poc-network"
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "SubnetA" {
  name                 = "SubnetA"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.poc_network.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [
    azurerm_virtual_network.poc_network
  ]
}

resource "azurerm_subnet" "SubnetB" {
  name                 = "SubnetB"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.poc_network.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.poc_network
  ]
}

resource "azurerm_subnet" "SubnetC" {
  name                 = "SubnetC"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.poc_network.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [
    azurerm_virtual_network.poc_network
  ]
}

resource "azurerm_subnet" "SubnetD" {
  name                 = "SubnetD"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.poc_network.name
  address_prefixes     = ["10.0.3.0/24"]
  depends_on = [
    azurerm_virtual_network.poc_network
  ]
}

resource "azurerm_network_security_group" "pocsuba_nsg" {
  name                = "POCsubA-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "Allow_SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.SubnetA.id
  network_security_group_id = azurerm_network_security_group.pocsuba_nsg.id
  depends_on = [
    azurerm_network_security_group.pocsuba_nsg
  ]
}