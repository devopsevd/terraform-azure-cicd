# Generate random password
resource "random_password" "linux-vm-password" {
  length = 16
  min_upper = 2
  min_lower = 2
  min_special = 2
  number = true
  special = true
  override_special = "!@#$%&"
}
# Generate randon name for virtual machine
resource "random_string" "random-linux-vm" {
  length = 8
  special = false
  lower = true
  upper = false
  number = true
}

# Create Security Group to public subnet
resource "azurerm_network_security_group" "linux-vm-public-nsg" {
  //  depends_on = [
  //    azurerm_resource_group.network-rg]
  name = "${var.app_name}-${var.environment}-linux-vm-public-nsg"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create Security Group to public bastion subnet
resource "azurerm_network_security_group" "linux-vm-public-bastion-nsg" {
  //  depends_on = [
  //    azurerm_resource_group.network-rg]
  name = "${var.app_name}-${var.environment}-linux-vm-public-bastion-nsg"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create Security Group to public bastion subnet
resource "azurerm_network_security_group" "linux-vm-public-prod-nsg" {
  //  depends_on = [
  //    azurerm_resource_group.network-rg]
  name = "${var.app_name}-${var.environment}-linux-vm-public-prod-nsg"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create Security Group to private subnet
resource "azurerm_network_security_group" "linux-vm-private-nsg" {
  //  depends_on = [
  //    azurerm_resource_group.network-rg]
  name = "${var.app_name}-${var.environment}-linux-vm-private-nsg"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Associate the public NSG with the public subnet
resource "azurerm_subnet_network_security_group_association" "linux-vm-public-nsg-association" {
  //  depends_on = [
  //    azurerm_network_security_group.web-linux-vm-nsg]
  subnet_id = azurerm_subnet.network-pub-subnet.id
  network_security_group_id = azurerm_network_security_group.linux-vm-public-nsg.id
}

# Associate the public bastion NSG with the public bastion subnet
resource "azurerm_subnet_network_security_group_association" "linux-vm-public-bastion-nsg-association" {
  //  depends_on = [
  //    azurerm_network_security_group.web-linux-vm-nsg]
  subnet_id = azurerm_subnet.network-pub-bastion-subnet.id
  network_security_group_id = azurerm_network_security_group.linux-vm-public-bastion-nsg.id
}

# Associate the public PROD NSG with the public prod subnet
resource "azurerm_subnet_network_security_group_association" "linux-vm-public-prod-nsg-association" {
  //  depends_on = [
  //    azurerm_network_security_group.web-linux-vm-nsg]
  subnet_id = azurerm_subnet.network-pub-prod-subnet.id
  network_security_group_id = azurerm_network_security_group.linux-vm-public-prod-nsg.id
}

# Associate the private NSG with the private subnet
resource "azurerm_subnet_network_security_group_association" "linux-vm-private-nsg-association" {
  //  depends_on = [
  //    azurerm_network_security_group.web-linux-vm-nsg]
  subnet_id = azurerm_subnet.network-priv-subnet.id
  network_security_group_id = azurerm_network_security_group.linux-vm-private-nsg.id
}

# Network security rules for public subnet
resource "azurerm_network_security_rule" "public-ssh" {
  access = "Allow"
  direction = "Inbound"
  name = "allow-ssh"
  priority = 100
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "Internet"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.network-rg.name
  network_security_group_name = azurerm_network_security_group.linux-vm-public-nsg.name
}

resource "azurerm_network_security_rule" "public-http" {
  access = "Allow"
  direction = "Inbound"
  name = "allow-http"
  priority = 110
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "8080"
  source_address_prefix = "Internet"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.network-rg.name
  network_security_group_name = azurerm_network_security_group.linux-vm-public-nsg.name
}

resource "azurerm_network_security_rule" "public-test-app" {
  access = "Allow"
  direction = "Inbound"
  name = "allow-test-app"
  priority = 120
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "10000"
  source_address_prefix = "Internet"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.network-rg.name
  network_security_group_name = azurerm_network_security_group.linux-vm-public-nsg.name
}



# Network security rules for public bastion subnet
resource "azurerm_network_security_rule" "public-bastion-ssh" {
  access = "Allow"
  direction = "Inbound"
  name = "allow-ssh"
  priority = 100
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "Internet"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.network-rg.name
  network_security_group_name = azurerm_network_security_group.linux-vm-public-bastion-nsg.name
}

# Network security rules for public prod subnet
resource "azurerm_network_security_rule" "public-prod-app" {
  access = "Allow"
  direction = "Inbound"
  name = "allow-application"
  priority = 100
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "10000"
  source_address_prefix = "Internet"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.network-rg.name
  network_security_group_name = azurerm_network_security_group.linux-vm-public-prod-nsg.name
}


# Network security rules for private subnet
resource "azurerm_network_security_rule" "private-ssh" {
  access = "Allow"
  direction = "Inbound"
  name = "allow-ssh"
  priority = 100
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "VirtualNetwork"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.network-rg.name
  network_security_group_name = azurerm_network_security_group.linux-vm-private-nsg.name
}

resource "azurerm_network_security_rule" "private-selenium" {
  access = "Allow"
  direction = "Inbound"
  name = "allow-selenium"
  priority = 110
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "4444"
  source_address_prefix = "VirtualNetwork"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.network-rg.name
  network_security_group_name = azurerm_network_security_group.linux-vm-private-nsg.name
}
