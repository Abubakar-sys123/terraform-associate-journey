module "vpc" {
  source = "./vpc-resource"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security_group" {
  source = "./sg-resource"
  vpc_id = module.vpc.vpc_id
}

module "s3_bucket" {
  source      = "./s3-bucket"
  bucket_name = var.bucket_name
}

module "ec2" {
  source = "./ec2-resource"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  sg_id             = module.security_group.sg_id
  instance_type     = var.instance_type
  ami_id            = var.ami_id
  key_name          = var.key_name
}

module "s3_endpoint" {
  source = "./s3-endpoint"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = [module.vpc.private_subnet_id]
  route_table_id = module.vpc.private_route_table_id
}
