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