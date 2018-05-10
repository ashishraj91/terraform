provider "aws" {
  region = "${var.aws_region}"
}


resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.stack_name}_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zone}"

  tags = {
    Name = "${var.stack_name}_public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${var.availability_zone}"

  tags = {
    Name = "${var.stack_name}_private"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.stack_name}_igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

resource "aws_security_group" "base_sg" {
  name        = "${var.stack_name}_base_sg"
  description = "Base security group"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.stack_name}_base_sg"
  }
}

resource "aws_security_group_rule" "allow_inbound_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "-1"
  cidr_blocks       = ["10.1.10.199/32"]
  security_group_id = "${aws_security_group.base_sg.id}"
}

resource "aws_security_group_rule" "allow_outbound_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.base_sg.id}"
}

resource "aws_instance" "ec2_instance" {
  subnet_id               = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids  = ["${aws_security_group.base_sg.id}"]
  key_name                = "${var.key_name}"
  count                   = 1
  source_dest_check       = "false"
  disable_api_termination = "true"

  root_block_device {
    volume_type           = "${var.test_server["type"]}"
    volume_size           = "${var.test_server["root_vol_size"]}"
    delete_on_termination = "true"
  }

  tags {
    Name = "${var.stack_name}"
  }

  instance_type = "${var.test_server["instance_type"]}"
  ami           = "${var.test_server["ami"]}"
}
