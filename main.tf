provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "vpc" {
  source = "./vpc"
  vpc_region = "${var.region}"
  zone = "${var.av_zone}"
}

module "ec2" {
  source = "./ec2"
  ec2_region = "${var.region}"
  zone = "${var.av_zone}"
  vpc_id = "${module.vpc.module_vpc_id}"
  subnet_id = ["${module.vpc.module_vpc_subnet}"]
}
