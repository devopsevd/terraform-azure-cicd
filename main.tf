# Define Terraform provider
terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  backend "azurerm" {
    resource_group_name   = "backend"
    storage_account_name  = "tfnbkndacc"
    container_name        = "tfs"
    key                   = "terraform.tfstate"
  }
}
#Configure the Azure Provider
provider "azurerm" {
  features {}
}
