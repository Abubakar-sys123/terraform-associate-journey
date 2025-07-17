resource "aws_s3_bucket" "guestbook_frontend" {
  bucket        = var.bucket_name
  force_destroy = true
}
