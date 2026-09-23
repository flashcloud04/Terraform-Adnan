variable "project_name" {
  description = "Project name used in naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALBs are created."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the internet-facing ALB."
  type        = list(string)
}

variable "private_app_subnet_ids" {
  description = "Private application subnet IDs for the internal ALB."
  type        = list(string)
}

variable "frontend_security_group_id" {
  description = "Security group ID for frontend EC2 instances."
  type        = string
}

variable "backend_security_group_id" {
  description = "Security group ID for backend EC2 instances."
  type        = string
}

variable "frontend_alb_security_group_id" {
  description = "Security group ID for the internet-facing frontend ALB."
  type        = string
}

variable "backend_alb_security_group_id" {
  description = "Security group ID for the internal backend ALB."
  type        = string
}

variable "frontend_target_group_name" {
  description = "Optional name override for the frontend target group."
  type        = string
  default     = null
}

variable "backend_target_group_name" {
  description = "Optional name override for the backend target group."
  type        = string
  default     = null
}

variable "frontend_health_check_path" {
  description = "Healthcare check path for the frontend ALB target group."
  type        = string
  default     = "/"
}

variable "backend_health_check_path" {
  description = "Health check path for the backend ALB target group."
  type        = string
  default     = "/health"
}
