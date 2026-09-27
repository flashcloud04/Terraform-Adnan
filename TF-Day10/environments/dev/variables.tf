variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "aws-ecommerce"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "public_subnet_cidrs" {
  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_app_subnet_cidrs" {
  type = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "private_db_subnet_cidrs" {
  type = list(string)

  default = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]
}

variable "database_name" {
  description = "Database name for the application."
  type        = string
  default     = "cloud"
}

variable "database_host" {
  description = "Database hostname placeholder; RDS will provide the actual value."
  type        = string
  default     = "placeholder.rds.amazonaws.com"
  sensitive   = true
}

variable "database_user" {
  description = "Database username."
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "database_password" {
  description = "Database password; provide via tfvars or environment variables and do not commit it."
  type        = string
  sensitive   = true
  default     = "CHANGE_ME"
}

variable "smtp_host" {
  description = "SMTP host used by the application."
  type        = string
  default     = "smtp.example.com"
  sensitive   = true
}

variable "smtp_port" {
  description = "SMTP port used by the application."
  type        = number
  default     = 587
  sensitive   = true
}

variable "smtp_username" {
  description = "SMTP username used by the application."
  type        = string
  default     = "smtp-user"
  sensitive   = true
}

variable "smtp_password" {
  description = "SMTP password; provide via tfvars or environment variables and do not commit it."
  type        = string
  default     = "CHANGE_ME"
  sensitive   = true
}

variable "app_repository" {
  description = "Repository or source path used to fetch the application code on each EC2 instance."
  type        = string
  default     = "https://github.com/your-org/your-app.git"
}

variable "key_name" {
  description = "Optional EC2 key pair name. Prefer Session Manager instead of SSH."
  type        = string
  default     = null
}

variable "frontend_ami_id" {
  description = "AMI ID for frontend EC2 instances. Defaults to the latest Amazon Linux 2023 AMI."
  type        = string
  default     = null
}

variable "backend_ami_id" {
  description = "AMI ID for backend EC2 instances. Defaults to the latest Amazon Linux 2023 AMI."
  type        = string
  default     = null
}

variable "frontend_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "backend_instance_type" {
  type    = string
  default = "t3.micro"
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

variable "rds_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_allocated_storage" {
  type    = number
  default = 20
}

variable "rds_max_allocated_storage" {
  type    = number
  default = 50
}

variable "rds_backup_retention_period" {
  type    = number
  default = 7
}

variable "rds_multi_az" {
  type    = bool
  default = false
}

variable "rds_deletion_protection" {
  type    = bool
  default = true
}

variable "rds_skip_final_snapshot" {
  type    = bool
  default = false
}

variable "rds_engine_version" {
  type    = string
  default = "8.0.36"
}

variable "rds_port" {
  type    = number
  default = 3306
}
variable "application_bucket_name" {
  description = "S3 bucket containing the application artifact"
  type        = string
}

variable "application_object_key" {
  description = "S3 object key for the application artifact"
  type        = string
}