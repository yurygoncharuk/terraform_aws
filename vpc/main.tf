resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "main gw"
  }
}

resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.0.id}"
  tags {
    Name = "main gw nat"
  }

  depends_on = ["aws_subnet.public", "aws_eip.nat"]
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"

  count = "${length(var.zone)}"
  cidr_block = "${lookup(var.public_subnet_cidr,var.zone[count.index])}"
  availability_zone = "${var.vpc_region}${var.zone[count.index]}"

  tags {
    Name = "Public Subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.main.id}"

  count = "${length(var.zone)}"
  cidr_block = "${lookup(var.private_subnet_cidr,var.zone[count.index])}"
  availability_zone = "${var.vpc_region}${var.zone[count.index]}"

  tags {
    Name = "Private Subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet"
  }
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags {
    Name = "Private Subnet"
  }
  depends_on = ["aws_nat_gateway.gw"]
}

module "route_tb_assoc_pub" {
  source = "./route_tb_association"

  count = "${aws_subnet.public.count}" 
  subnet = "${aws_subnet.public.*.id}"
  route_table = "${aws_route_table.public.id}"
}

module "route_tb_assoc_pr" {
  source = "./route_tb_association"

  count = "${aws_subnet.private.count}"
  subnet = "${aws_subnet.private.*.id}"
  route_table = "${aws_route_table.private.id}"
}
