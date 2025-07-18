provider "aws" {
  region = var.region
}
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source           = "./modules/ec2"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_id        = module.vpc.public_subnet_id
  sg_id            = module.sg.sg_id
  key_name         = var.key_name
  ec2_name         = var.ec2_name
}


