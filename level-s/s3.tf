resource "aws_s3_bucket" "core_storage" {
  provider = aws.core

  bucket = local.bucket_name
  tags   = local.tags
}
