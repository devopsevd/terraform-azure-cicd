# Get a Static Public IP
resource "azurerm_public_ip" "linux-vm-ip-bastion" {
  //  depends_on = [
  //    azurerm_resource_group.network-rg]
  name = "linux-${random_string.random-linux-vm.result}-bastion-ip"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method = "Static"
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# create a module for bastion host
module "bastion-host" {
  source = "./modules/ec2-instance"
  random_string = "${random_string.random-linux-vm.result}-bastion"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  subnet_id = azurerm_subnet.network-pub-bastion-subnet.id
  public_ip_address_id = azurerm_public_ip.linux-vm-ip-bastion.id
  app_name = var.app_name
  environment = var.environment
}