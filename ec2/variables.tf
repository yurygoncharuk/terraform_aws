variable "ec2_region" {}
variable "inst_type" {default = "t2.micro"}
variable "public_key" {default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCNXe8Y+yh6cc1lG2AYgkyam6xT1c62M0SgC91SgH4Gze3gY2zXxzhMLEA8aNAJXFjiaPSbUXirYlLCmgSWQbJd59GNUVaKhxypyliNskGQTBv7FCbLdpAbBI4mXn/D2RmPtxj4ZgMRxjn2+TF5t1YWS+eC6zzyeRQI7wizBbDTDzI4RcDDZATnnBIGE31uUrc7OedMcFZhu+xpWTilgzsmAHfDAMc4eu6QVkpVsDeF0v5mccPfettR+sVJzim4c+syr8Cov92PKxdrhAqmdlLbVz4op78ypYkbNZIM1zRsjymzeiqQNIZWrEmYUOqXDhBxDuydxfqW9eF5cQE1v89D yury_hancharuk_aws_epam"}
variable "count" {default = 2}
variable "vpc_id" {}
variable "subnet_id" { type = "list" }
variable "zone" {
  type = "list"
  description = "Availability zone for subnets"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-cd0f5cb6"
    "us-east-2" = "ami-10547475"
  }
}

variable "file_name" {
  default = "app_install.tpl"
}

variable "apps" {
  type = "map"
  default = {
    "production" = "apache2 htop"
  }
}

variable "bloc_device" {
  type = "map"
  default = {
    rbd = {
      volume_size = 10
      volume_type  = "standard"
    }
    ebd = {
      volume_size = 20
      volume_type  = "gp2"
    }
  }
}
