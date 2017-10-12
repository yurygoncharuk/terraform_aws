variable "vpc_region" {}

variable "count" {default = 2}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "20.0.0.0/16"
}

variable "zone" {
  type = "list"
  description = "Availability zone for subnets"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = {
    "a" = "20.0.0.0/24"
    "b" = "20.0.1.0/24"
  }
}

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = {
    "a" = "20.0.2.0/24"
    "b" = "20.0.3.0/24"
  }
}
