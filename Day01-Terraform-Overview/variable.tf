variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
  defult = "my-modular-tf-bucket-00123"
}
