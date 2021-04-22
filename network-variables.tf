variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
  default = "10.1.0.0/16"
}
variable "network-priv-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
  default = "10.1.0.0/24"
}

variable "network-pub-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
  default = "10.1.1.0/24"
}