variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-2"
}

variable "av_zone" {
  description = "Availability zone for subnets"
  type = "list"
  default = ["a", "b"]
}
