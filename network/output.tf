
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "security_group_id" {
  value = "${aws_security_group.base_sg.id}"
}

output "ec2_instance_id" {
  value = "${aws_instance.ec2_instance.id}"
}

