provider "azurerm" {
  features {}
}

#Creation of the Resource Group
resource "azurerm_resource_group" "POC-network" {
  name     = var.resource_group
  location = var.location
}
