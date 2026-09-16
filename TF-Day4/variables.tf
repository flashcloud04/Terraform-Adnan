variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Base name used for all project resources"
  type        = string
  default     = "cloudapp-demo"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}