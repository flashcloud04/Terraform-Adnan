# ============================================================
# S3
# ============================================================

resource "aws_s3_bucket" "project" {
  bucket_prefix = "${var.project_name}-${var.environment}-artifacts-"
  force_destroy = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-artifacts"
    }
  )
}

resource "aws_s3_bucket_versioning" "project" {
  bucket = aws_s3_bucket.project.id

  versioning_configuration {
    status = "Enabled"
  }
}