variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
  default = "10.1.0.0/16"
}

variable "network-pub-subnet-cidr" {
  type        = string
  description = "The CIDR for the public subnet"
  default = "10.1.0.0/24"
}

variable "network-pub-bastion-subnet-cidr" {
  type        = string
  description = "The CIDR for the public bastion subnet"
  default = "10.1.2.0/28"
}

variable "network-pub-prod-subnet-cidr" {
  type        = string
  description = "The CIDR for the public prod subnet"
  default = "10.1.2.16/28"
}

variable "network-priv-subnet-cidr" {
  type        = string
  description = "The CIDR for the private subnet"
  default = "10.1.1.0/24"
}
