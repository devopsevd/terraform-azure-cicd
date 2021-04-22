# Define Terraform provider
terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      //version = "~>2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}
#Configure the Azure Provider
provider "azurerm" {
  features {}
//  version         = ">= 2.0"
//  environment     = "public"
//  subscription_id = var.azure_subscription_id
//  client_id       = var.azure_client_id
//  client_secret   = var.azure_client_secret
//    tenant_id       = var.azure_tenant_id
}


//provider "kubernetes" {
//  host                   = azurerm_kubernetes_cluster.example.kube_config.0.host
//  username               = azurerm_kubernetes_cluster.example.kube_config.0.username
//  password               = azurerm_kubernetes_cluster.example.kube_config.0.password
//  client_certificate     = base64decode(azurerm_kubernetes_cluster.example.kube_config.0.client_certificate)
//  client_key             = base64decode(azurerm_kubernetes_cluster.example.kube_config.0.client_key)
//  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.example.kube_config.0.cluster_ca_certificate)
//
//  //load_config_file = "false"
//}