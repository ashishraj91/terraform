variable "stack_name" {
  type        = "string"
  description = "Stack name"
  default     = "webserver"
}

variable "key_path" {
  type        = "string"
  description = "key for login"
  default     = "Terraform_test"
}

variable "chef_user" {
  type        = "string"
  description = "chef admin user"
  default     = "Terraform_test"
}

variable "key_name" {
  type        = "string"
  description = "key Name"
  default     = "ashish_test"
}

variable "aws_region" {
  type        = "string"
  description = "aws region"
  default     = "us-west-2"
}

variable "availability_zone" {
  type        = "string"
  description = "aws availability zone"
  default     = "us-west-2c"
}

variable "vpc_cidr" {
  type        = "string"
  description = "AWS cidr block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = "string"
  description = "AWS public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = "string"
  description = "AWS private subnet"
  default     = "10.0.2.0/24"
}

variable "test_server" {
  type        = "map"
  description = "AWS Nat server variables"

  default = {
    ami           = "ami-4e79ed36"
    instance_type = "t2.micro"
    type          = "gp2"
    root_vol_size = 8
  }
}

variable "instance_key" {
  type        = "map"
  description = "EC2 instance SSH key settings"

  default = {
    file = ""
    name = ""
  }
}

