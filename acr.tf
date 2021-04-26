resource "azurerm_container_registry" "acr" {
  name                     = "azurecicdapr242021"
  resource_group_name      = azurerm_resource_group.network-rg.name
  location                 = azurerm_resource_group.network-rg.location
  sku                      = "Basic"
  admin_enabled            = true
}

output "acr_admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  value = azurerm_container_registry.acr.admin_password
}