resource "aws_s3_bucket" "ctr_archive" {
    bucket = "ar_bank_connect_ctr_archive"
}
resource "aws_s3_bucket_public_access_block" "ctr_archive" {
  bucket = aws_s3_bucket.ctr_archive.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_server_side_encryption_configuration" "ctr_archive" {
    bucket = aws_s3_bucket.ctr_archive.id
    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
          kms_master_key_id = aws_kms_key.bank_connect_key.arn
        }
        bucket_key_enabled = true
    }
}
resource "aws_s3_bucket_lifecycle_configuration" "ctr_archive" {
  bucket = aws_s3_bucket.ctr_archive.id
  rule {
    id = "ctr-retention"
    status = "Enabled"
    filter {}
    expiration {
        days = 365
    }
  }
}
resource "aws_kinesis_stream" "ctr_stream" {
    name = "ar_bank_connect_ctr_stream"
    retention_period = 24
    stream_mode_details {
      stream_mode = "ON_DEMAND"
    }
    encryption_type = "KMS"
    #key_id = "alias/aws/kinesis"
    kms_key_id = aws_kms_key.bank_connect_key.arn
}