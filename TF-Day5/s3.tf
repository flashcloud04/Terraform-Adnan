# ============================================================
# S3
# ============================================================

resource "aws_s3_bucket" "project" {
  bucket = "cloud-platform-dev-artifacts-f3011686ca55be26854f0c1a54"

  tags = {
    Name = "${local.name_prefix}-artifacts"
  }
}

resource "aws_s3_bucket_versioning" "project" {
  bucket = aws_s3_bucket.project.id

  versioning_configuration {
    status = "Enabled"
  }
}