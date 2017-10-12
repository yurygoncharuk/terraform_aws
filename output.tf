/*
output "sum" {
  value = ["${formatlist("%s%s", "123", list("456", "789"))}"] 
}
*/

output "elb_dns_name" {
  value = "${module.ec2.elb_dns_name}"
}
