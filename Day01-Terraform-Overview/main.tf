module "s3_bucket" {
  source      = "./Module-directory"
  aws_region  = var.aws_region
  bucket_name = var.bucket_name
}
