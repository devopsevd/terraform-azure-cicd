
# Data template Bash bootstrapping file
data "template_file" "linux-vm-sonar-cloud-init" {
  template = file("setup-sonar-server.sh")
}

# create a module for sonar server

module "sonar-server" {
  source = "./modules/ec2-instance"
  random_string = "${random_string.random-linux-vm.result}-sonar"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  subnet_id = azurerm_subnet.network-priv-subnet.id
  private_ip_address_allocation = "Static"
  private_ip_address = "10.1.1.5"
  custom_data = base64encode(data.template_file.linux-vm-sonar-cloud-init.rendered)
  app_name = var.app_name
  environment = var.environment
}