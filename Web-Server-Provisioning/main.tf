provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = var.vpc_id
}

module "sg" {
  source = "../modules/sg"
  vpc_id = var.vpc_id
}

module "ec2" {
  source         = "../modules/ec2"
  ami_id         = data.aws_ami.amazon_linux.id
  instance_type  = var.instance_type
  subnet_id      = data.aws_subnet_ids.default.ids[0]
  sg_id          = module.sg.sg_id
  key_name       = var.key_name
  instance_name  = "ModularWebServer"
}

