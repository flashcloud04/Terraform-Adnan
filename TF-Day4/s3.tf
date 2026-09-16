resource "aws_s3_bucket" "project" {
  bucket_prefix = "${var.project_name}-data-"

  tags = {
    Name        = "${var.project_name} data bucket"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}