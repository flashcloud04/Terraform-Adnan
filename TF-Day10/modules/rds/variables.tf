variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "db_subnet_ids" {
  description = "Private DB subnet IDs for the RDS subnet group."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID used to associate the database security group."
  type        = string
}

variable "db_security_group_id" {
  description = "Security group ID for RDS access."
  type        = string
}

variable "database_name" {
  description = "Initial MySQL database name."
  type        = string
}

variable "database_username" {
  description = "Master username for the MySQL instance."
  type        = string
}

variable "database_password" {
  description = "Master password for the MySQL instance. This must not be committed to source control."
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "RDS instance size."
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GiB."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage for autoscaling in GiB."
  type        = number
  default     = 50
}

variable "backup_retention_period" {
  description = "Number of days to retain automatic backups."
  type        = number
  default     = 7
}

variable "storage_encrypted" {
  description = "Enable encryption at rest."
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment for higher availability."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Protect the database from deletion."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when deleting the database."
  type        = bool
  default     = false
}

variable "engine_version" {
  description = "MySQL engine version."
  type        = string
  default     = "8.0.36"
}

variable "db_port" {
  description = "Database port."
  type        = number
  default     = 3306
}

variable "publicly_accessible" {
  description = "Controls whether the database is publicly accessible. Must remain false for this architecture."
  type        = bool
  default     = false
}
