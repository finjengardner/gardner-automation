resource "azurerm_public_ip" "poc_lb_pip" {
  name                = "POC-LB-pip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}

resource "azurerm_lb" "poc_lb" {
  name                = "POC-LoadBalancer"
  location            = var.location
  resource_group_name = var.resource_group

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.poc_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "poc_addresspool" {
  loadbalancer_id = azurerm_lb.poc_lb.id
  name            = "POC-BackEndAddressPool"
}