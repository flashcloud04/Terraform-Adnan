variable "project_name" {
  description = "Project name used for naming resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
}
variable "secret_arn" {
  description = "ARN of the application secret"
  type        = string
}

variable "application_bucket_arn" {
  description = "ARN of the application artifact S3 bucket"
  type        = string
}