# Azure virtual machine settings #
variable "linux-vm-size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
  default = "Standard_A1_v2"
}
variable "linux-license-type" {
  type        = string
  description = "Specifies the BYOL type for the virtual machine."
  default     = null
}
# Azure virtual machine storage settings #
variable "linux-delete-os-disk-on-termination" {
  type        = string
  description = "Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed?"
  default     = "true"  # Update for your environment
}
variable "linux-delete-data-disks-on-termination" {
  description = "Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed?"
  type        = string
  default     = "true" # Update for your environment
}
variable "linux-vm-image" {
  type        = map(string)
  description = "Virtual machine source image information"
  default     = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
# Azure virtual machine OS profile #
variable "linux-admin-username" {
  type        = string
  description = "Username for Virtual Machine administrator account"
  default     = "admin"
}
variable "linux-admin-password" {
  type        = string
  description = "Password for Virtual Machine administrator account"
  default     = ""
}

# Random string for network interface name and vm name
variable "random_string" {
  type        = string
  description = "Network interface name and vm name"
}

# application name
variable "app_name" {
  type        = string
  description = "The application name used to build resources"
  default = "tf"
}

# environment
variable "environment" {
  type        = string
  description = "The environment to be built"
  default = "dev"
}
# azure region
variable "location" {
  type        = string
  description = "Azure region where the resources will be created"
}
# resource group
variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "subnet id"
}

variable "public_ip_address_id" {
  type        = string
  description = "Public ip address id"
  default = ""
}

variable "custom_data" {
  type        = string
  description = "Custom data"
  default = ""
}

variable "private_ip_address_allocation" {
  type        = string
  description = "private_ip_address_allocation"
  default = "Dynamic"
}

variable "private_ip_address" {
  type        = string
  description = "private_ip_address"
  default = ""
}