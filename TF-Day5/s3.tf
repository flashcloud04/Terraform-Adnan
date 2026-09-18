# ============================================================
# S3
# ============================================================

resource "aws_s3_bucket" "project" {
  bucket_prefix = "${local.name_prefix}-artifacts-"

  tags = {
    Name = "${local.name_prefix}-artifacts"
  }
}