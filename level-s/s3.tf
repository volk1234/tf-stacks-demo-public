resource "aws_s3_bucket" "core_storage" {
  bucket = local.bucket_name
  tags   = local.tags
}
