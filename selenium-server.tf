
# Data template Bash bootstrapping file
data "template_file" "linux-vm-selenium-cloud-init" {
  template = file("setup-selenium-server.sh")
}

# create a module for selenium server

module "selenium-server" {
  source = "./modules/ec2-instance"
  random_string = "${random_string.random-linux-vm.result}-selenium"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  subnet_id = azurerm_subnet.network-priv-subnet.id
  private_ip_address_allocation = "Static"
  private_ip_address = "10.1.1.4"
  custom_data = base64encode(data.template_file.linux-vm-selenium-cloud-init.rendered)
  app_name = var.app_name
  environment = var.environment
}