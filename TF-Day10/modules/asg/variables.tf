variable "project_name" {
  description = "Project name used for naming resources."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ASGs will be placed."
  type        = string
}

variable "private_app_subnet_ids" {
  description = "Private application subnet IDs for instances."
  type        = list(string)
}

variable "frontend_security_group_id" {
  description = "Security group ID for frontend instances."
  type        = string
}

variable "backend_security_group_id" {
  description = "Security group ID for backend instances."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name used by EC2s."
  type        = string
}

variable "frontend_target_group_arn" {
  description = "Frontend ALB target group ARN."
  type        = string
}

variable "backend_target_group_arn" {
  description = "Backend ALB target group ARN."
  type        = string
}

variable "frontend_ami_id" {
  description = "AMI ID for frontend EC2 instances."
  type        = string
}

variable "backend_ami_id" {
  description = "AMI ID for backend EC2 instances."
  type        = string
}

variable "frontend_instance_type" {
  description = "Frontend EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "backend_instance_type" {
  description = "Backend EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Optional EC2 key pair name. Prefer SSM Session Manager over SSH."
  type        = string
  default     = null
}

variable "frontend_min_size" {
  description = "Minimum number of frontend instances."
  type        = number
  default     = 2
}

variable "frontend_desired_capacity" {
  description = "Desired number of frontend instances."
  type        = number
  default     = 2
}

variable "frontend_max_size" {
  description = "Maximum number of frontend instances."
  type        = number
  default     = 4
}

variable "backend_min_size" {
  description = "Minimum number of backend instances."
  type        = number
  default     = 2
}

variable "backend_desired_capacity" {
  description = "Desired number of backend instances."
  type        = number
  default     = 2
}

variable "backend_max_size" {
  description = "Maximum number of backend instances."
  type        = number
  default     = 4
}

variable "frontend_health_check_grace_period" {
  description = "Grace period before ELB health checks."
  type        = number
  default     = 300
}

variable "backend_health_check_grace_period" {
  description = "Grace period before ELB health checks."
  type        = number
  default     = 300
}

variable "backend_alb_dns_name" {
  description = "Internal ALB DNS name passed to frontend Nginx for API proxying."
  type        = string
}

variable "database_host" {
  description = "RDS hostname for the backend application."
  type        = string
}

variable "database_name" {
  description = "Database name used by the backend app."
  type        = string
}

variable "database_user" {
  description = "Database username used by the backend app."
  type        = string
}

variable "database_password" {
  description = "Database password used by the backend app."
  type        = string
  sensitive   = true
}

variable "secret_arn" {
  description = "Secrets Manager ARN used by backend and frontend application templates."
  type        = string
}

variable "app_repository" {
  description = "Repository or source location for the application code."
  type        = string
}

variable "app_environment" {
  description = "Application environment value, e.g. dev or prod."
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch log group name prefix for EC2 app logs."
  type        = string
}
