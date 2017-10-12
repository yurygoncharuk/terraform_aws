output "module_vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "module_vpc_subnet" {
  value = ["${aws_subnet.public.*.id}"]
}


