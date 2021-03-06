
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
  default     = "East US"
}