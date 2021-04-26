# Create Network Card for web VM
resource "azurerm_network_interface" "linux-vm-nic" {
  //  depends_on = [
  //    azurerm_public_ip.web-linux-vm-ip]
  name = "linux-${var.random_string}-vm-nic"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation == "Static" ? "Static" : "Dynamic"
    private_ip_address = var.private_ip_address != "" && var.private_ip_address_allocation == "Static" ? var.private_ip_address : null
    public_ip_address_id = var.public_ip_address_id
  }
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create Linux VM with web server
resource "azurerm_linux_virtual_machine" "linux-vm" {
  //  depends_on = [
  //    azurerm_network_interface.web-linux-vm-nic]
  name = "linux-${var.random_string}-vm"
  location = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [
    azurerm_network_interface.linux-vm-nic.id]
  size = var.linux-vm-size
  source_image_reference {
    offer = lookup(var.linux-vm-image, "offer", null)
    publisher = lookup(var.linux-vm-image, "publisher", null)
    sku = lookup(var.linux-vm-image, "sku", null)
    version = lookup(var.linux-vm-image, "version", null)
  }
  os_disk {
    name = "linux-${var.random_string}-vm-os-disk"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
//  identity {
//    type = "SystemAssigned"
//  }
  computer_name = "linux-${var.random_string}-vm"
  //admin_username = var.web-linux-admin-username
  admin_username = "ubuntu"
  //admin_password = random_password.web-linux-vm-password.result
  admin_password = "Ubuntu@1234"
  custom_data = var.custom_data != "" ? var.custom_data : null
  disable_password_authentication = false
  tags = {
    application = var.app_name
    environment = var.environment
  }
}
