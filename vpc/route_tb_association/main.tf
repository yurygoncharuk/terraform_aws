variable subnet {type = "list"}
variable route_table {}
variable count {}

resource "aws_route_table_association" "main" {
  count = "${var.count}"
  subnet_id = "${var.subnet[count.index]}"
  route_table_id = "${var.route_table}"
}
