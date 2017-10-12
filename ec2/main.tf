resource "template_file" "user_data" {
  template = "${file("${var.file_name}")}"
  vars {
    application = "${lookup(var.apps,"production")}"
  }
}

resource "aws_key_pair" "example" {
  key_name   = "deployer-key"
  public_key = "${var.public_key}"
}

resource "aws_security_group" "example" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all"
  }
}

resource "aws_instance" "example" {
  count = "${var.count}"
  ami           = "${lookup(var.amis, var.ec2_region)}"
  instance_type = "${var.inst_type}"
  key_name = "${aws_key_pair.example.key_name}"
  subnet_id ="${element(var.subnet_id, count.index)}" 
  vpc_security_group_ids = ["${aws_security_group.example.id}"]
  root_block_device = ["${var.bloc_device["rbd"]}"]
  user_data = "${template_file.user_data.rendered}"

  depends_on = ["aws_security_group.example"]
}

resource "aws_eip" "ip" {
  vpc = true
#  count = "${length(aws_instance.example.*.id)}"
  count = "${var.count}"
  instance = "${element(aws_instance.example.*.id, count.index)}"
  depends_on = ["aws_instance.example"]
}

# Create a new load balancer
resource "aws_elb" "example" {
  name               = "terraform-elb"
#  availability_zones = ["${formatlist("%s%s", var.ec2_region, var.zone)}"]
  security_groups = ["${aws_security_group.example.id}"]
  subnets = ["${var.subnet_id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.example.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  depends_on = ["aws_instance.example"]

  tags {
    Name = "terraform-elb"
  }
}
/*
resource "aws_launch_configuration" "aws_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "${lookup(var.amis, var.ec2_region)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.example.key_name}"
  user_data = "${template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.aws_conf.name}"
  vpc_zone_identifier = ["${var.subnet_id}"]
  min_size             = 2
  max_size             = 2

  lifecycle {
    create_before_destroy = true
  }
}
*/
