variable "aws_region" {
  description = "AWS region to deploy the test environment into."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used across resources."
  type        = string
  default     = "aws-ecommerce"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "test"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC in the test environment."
  type        = string
  default     = "10.10.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for the test environment."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs for the test environment."
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "Private app subnet CIDRs for the test environment."
  type        = list(string)
  default     = ["10.10.11.0/24", "10.10.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "Private DB subnet CIDRs for the test environment."
  type        = list(string)
  default     = ["10.10.21.0/24", "10.10.22.0/24"]
}

variable "database_name" {
  type    = string
  default = "ecommerceapp"
}

variable "database_user" {
  type      = string
  default   = "admin"
  sensitive = true
}

variable "database_password" {
  type      = string
  default   = "CHANGE_ME"
  sensitive = true
}

variable "frontend_instance_type" {
  type    = string
  default = "t3.small"
}

variable "backend_instance_type" {
  type    = string
  default = "t3.small"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "rds_multi_az" {
  type    = bool
  default = true
}

variable "frontend_min_size" {
  type    = number
  default = 2
}

variable "frontend_desired_capacity" {
  type    = number
  default = 2
}

variable "frontend_max_size" {
  type    = number
  default = 4
}

variable "backend_min_size" {
  type    = number
  default = 2
}

variable "backend_desired_capacity" {
  type    = number
  default = 2
}

variable "backend_max_size" {
  type    = number
  default = 4
}
