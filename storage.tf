resource "azurerm_storage_account" "poc_storage" {
  name                     = "jengpocstorage"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account_network_rules" "poc_storage_rules" {
  storage_account_id = azurerm_storage_account.poc_storage.id
  default_action             = "Allow"
  ip_rules                   = ["127.0.0.1"]
  virtual_network_subnet_ids = [azurerm_subnet.SubnetA.id, azurerm_subnet.SubnetB.id, azurerm_subnet.SubnetC.id, azurerm_subnet.SubnetD.id]
  bypass                     = ["Metrics"]
}
