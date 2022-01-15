resource "azurerm_network_interface" "computer1" {
  name                = "nic-Computer1"
  location            = azurerm_resource_group.nunya.location
  resource_group_name = azurerm_resource_group.nunya.name

  ip_configuration {
    name                          = "ip-Computer1"
    subnet_id                     = azurerm_subnet.compute.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "example" {
  name                = "vm-Computer1"
  resource_group_name = azurerm_resource_group.nunya.name
  location            = azurerm_resource_group.nunya.location
  size                = "Standard_B2s"
  admin_username      = "bandarr"
  network_interface_ids = [
    azurerm_network_interface.computer1.id,
  ]

  admin_ssh_key {
    username   = "bandarr"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     =  "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}