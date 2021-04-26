# Get a Static Public IP
resource "azurerm_public_ip" "linux-vm-ip-jenkins" {
  //  depends_on = [
  //    azurerm_resource_group.network-rg]
  name = "linux-${random_string.random-linux-vm.result}-jenkins-ip"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method = "Static"

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Data template Bash bootstrapping file
data "template_file" "linux-vm-jenkins-cloud-init" {
  template = file("setup-jenkins-server.sh")
}

# create a module for jenkins server
module "jenkins-server" {
  source = "./modules/ec2-instance"
  random_string = "${random_string.random-linux-vm.result}-jenkins"
  location = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  subnet_id = azurerm_subnet.network-pub-subnet.id
  public_ip_address_id = azurerm_public_ip.linux-vm-ip-jenkins.id
  private_ip_address_allocation = "Static"
  private_ip_address = "10.1.0.5"
  custom_data = base64encode(data.template_file.linux-vm-jenkins-cloud-init.rendered)
  app_name = var.app_name
  environment = var.environment
}