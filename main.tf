# Define Terraform provider
terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}
#Configure the Azure Provider
provider "azurerm" {
  features {}
}
