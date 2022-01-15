resource "azurerm_virtual_network" "nunya" {
  name                = "vnet-NunyaBusiness"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.nunya.location
  resource_group_name = azurerm_resource_group.nunya.name
}

resource "azurerm_subnet" "compute" {
  name                 = "snet-Computers"
  resource_group_name  = azurerm_resource_group.nunya.name
  virtual_network_name = azurerm_virtual_network.nunya.name
  address_prefixes     = ["10.0.0.0/24"]
}