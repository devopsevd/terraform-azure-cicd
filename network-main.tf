# Create a resource group for network
resource "azurerm_resource_group" "network-rg" {
  name     = "${var.app_name}-${var.environment}-rg"
  location = var.location
  tags = {
    application = var.app_name
    environment = var.environment
  }
}
# Create the network VNET
resource "azurerm_virtual_network" "network-vnet" {
  name                = "${var.app_name}-${var.environment}-vnet"
  address_space       = [var.network-vnet-cidr]
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  tags = {
    application = var.app_name
    environment = var.environment
  }
}
# Create a private subnet for Network
resource "azurerm_subnet" "network-priv-subnet" {
  name                 = "${var.app_name}-${var.environment}-priv-subnet"
  //address_prefix       = var.network-subnet-cidr
  address_prefixes = [var.network-priv-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  resource_group_name  = azurerm_resource_group.network-rg.name
}
# Create a public subnet for Network
resource "azurerm_subnet" "network-pub-subnet" {
  name                 = "${var.app_name}-${var.environment}-pub-subnet"
  //address_prefix       = var.network-subnet-cidr
  address_prefixes = [var.network-pub-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  resource_group_name  = azurerm_resource_group.network-rg.name
}