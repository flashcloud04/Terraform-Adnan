variable "project_name" {
  description = "Name of the project being deployed"
  type        = string
  default     = "cloud-platform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region for the S3 resources"
  type        = string
  default     = "us-east-1"
}
