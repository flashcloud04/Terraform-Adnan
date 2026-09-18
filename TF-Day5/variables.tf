variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Short name used for AWS resource names"
  type        = string
  default     = "cloud-platform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the application VPC"
  type        = string
  default     = "10.42.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type used by the application Auto Scaling Group"
  type        = string
  default     = "t3.micro"
}

variable "database_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "platform"
}

variable "database_username" {
  description = "PostgreSQL master username"
  type        = string
  default     = "platformadmin"
}

variable "health_check_path" {
  description = "HTTP path used by the load balancer target health check"
  type        = string
  default     = "/"
}