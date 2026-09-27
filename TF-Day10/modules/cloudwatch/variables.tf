variable "project_name" {
  description = "Project name used for CloudWatch resources."
  type        = string
}

variable "environment" {
  description = "Environment value."
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 14
}

variable "sns_topic_arn" {
  description = "Optional SNS topic ARN for alarm notifications."
  type        = string
  default     = null
}

variable "frontend_asg_name" {
  description = "Frontend Auto Scaling Group name."
  type        = string
}

variable "backend_asg_name" {
  description = "Backend Auto Scaling Group name."
  type        = string
}

variable "frontend_alb_arn_suffix" {
  description = "Frontend ALB ARN suffix used for unhealthy host count metric."
  type        = string
}

variable "backend_alb_arn_suffix" {
  description = "Backend ALB ARN suffix used for unhealthy host count metric."
  type        = string
}

variable "rds_instance_identifier" {
  description = "RDS instance identifier used for database metrics."
  type        = string
}
