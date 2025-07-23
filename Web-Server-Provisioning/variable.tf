variable "region" {
  default = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID to deploy resources into"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key name to use for EC2 login"
}

