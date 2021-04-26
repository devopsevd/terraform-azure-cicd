# Get a Static Public IP
resource "azurerm_public_ip" "linux-vm-ip-stage" {
  //  depends_on = [
  //    azurerm_resource_group.network-rg]
  name = "linux-${random_string.random-linux-vm.result}-stage-ip"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method = "Static"

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Data template Bash bootstrapping file
data "template_file" "linux-vm-stage-cloud-init" {
  template = file("setup-stage-server.sh")
}

# create a module for Stage server

module "stage-server" {
  source = "./modules/ec2-instance"
  random_string = "${random_string.random-linux-vm.result}-stage"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  subnet_id = azurerm_subnet.network-pub-subnet.id
  public_ip_address_id = azurerm_public_ip.linux-vm-ip-stage.id
  private_ip_address_allocation = "Static"
  private_ip_address = "10.1.0.6"
  custom_data = base64encode(data.template_file.linux-vm-stage-cloud-init.rendered)
  app_name = var.app_name
  environment = var.environment
}