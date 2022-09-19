#Virtual Machine 1 on SubnetA

resource "tls_private_key" "poclinux1_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "poclinux1" {
  filename="poclinux1.pem"  
  content=tls_private_key.poclinux1_key.private_key_pem 
}

resource "azurerm_network_interface" "poclinux1_interface" {
  name                = "poclinux1-interface"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
      }

  depends_on = [
    azurerm_virtual_network.poc_network,
  ]
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "poclinux1"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = "linuxusr"  
  network_interface_ids = [
    azurerm_network_interface.poclinux1_interface.id,
  ]
  admin_ssh_key {
    username   = "linuxusr"
    public_key = tls_private_key.poclinux1_key.public_key_openssh
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = "256"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7-LVM"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.poclinux1_interface,
    tls_private_key.poclinux1_key
  ]
}

#Virtual Machine 2 on SubnetA

resource "tls_private_key" "poclinux2_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "poclinux2" {
  filename="poclinux2.pem"  
  content=tls_private_key.poclinux2_key.private_key_pem 
}

resource "azurerm_network_interface" "poclinux2_interface" {
  name                = "poclinux2-interface"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
      }

  depends_on = [
    azurerm_virtual_network.poc_network,
  ]
}

resource "azurerm_linux_virtual_machine" "linux2_vm" {
  name                = "poclinux2"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = "linuxusr"  
  network_interface_ids = [
    azurerm_network_interface.poclinux2_interface.id,
  ]
  admin_ssh_key {
    username   = "linuxusr"
    public_key = tls_private_key.poclinux2_key.public_key_openssh
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = "256"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7-LVM"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.poclinux2_interface,
    tls_private_key.poclinux2_key
  ]
}

#Virtual Machine 3 on SubnetC

resource "tls_private_key" "poclinux3_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "poclinux3" {
  filename="poclinux3.pem"  
  content=tls_private_key.poclinux3_key.private_key_pem 
}

resource "azurerm_network_interface" "poclinux3_interface" {
  name                = "poclinux3-interface"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetC.id
    private_ip_address_allocation = "Dynamic"
      }

  depends_on = [
    azurerm_virtual_network.poc_network,
  ]
}

resource "azurerm_linux_virtual_machine" "linux3_vm" {
  name                = "poclinux3"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = "linuxusr"  
  network_interface_ids = [
    azurerm_network_interface.poclinux3_interface.id,
  ]
  admin_ssh_key {
    username   = "linuxusr"
    public_key = tls_private_key.poclinux3_key.public_key_openssh
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = "256"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7-LVM"
    version   = "latest"
  }
   provisioner "remote-exec" {
      inline = [
        "sudo yum -y install httpd && sudo systemctl start httpd",
      ]
    }

  connection {
   host        = "linux3_vm"
   agent       = true
   type        = "ssh"
   user        = "linuxuser"
   private_key = tls_private_key.poclinux3_key
  }

  depends_on = [
    azurerm_network_interface.poclinux3_interface,
    tls_private_key.poclinux3_key
  ]
}