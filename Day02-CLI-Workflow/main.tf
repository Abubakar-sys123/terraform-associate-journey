provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  az                  = var.az
  vpc_name            = var.vpc_name
}

module "sg" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  sg_name       = var.sg_name
  allowed_ssh   = var.allowed_ssh
  allowed_http  = var.allowed_http
}

module "ec2" {
  source         = "./modules/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  subnet_id      = module.vpc.subnet_id
  sg_id          = module.sg.sg_id
  name           = var.instance_name
}

