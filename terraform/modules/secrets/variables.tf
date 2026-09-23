variable "project_name" {
  description = "Project name used for naming the secret."
  type        = string
}

variable "environment" {
  description = "Environment name used in the secret path."
  type        = string
}

variable "database_host" {
  description = "Database hostname. This should be passed via tfvars or environment variables and is not stored in source control."
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Database name."
  type        = string
  sensitive   = true
}

variable "database_user" {
  description = "Database user name."
  type        = string
  sensitive   = true
}

variable "database_password" {
  description = "Database password."
  type        = string
  sensitive   = true
}

variable "smtp_host" {
  description = "SMTP server hostname."
  type        = string
  sensitive   = true
}

variable "smtp_port" {
  description = "SMTP server port."
  type        = number
  sensitive   = true
}

variable "smtp_username" {
  description = "SMTP username."
  type        = string
  sensitive   = true
}

variable "smtp_password" {
  description = "SMTP password."
  type        = string
  sensitive   = true
}

variable "recovery_window_in_days" {
  description = "Recovery window for Secrets Manager. Set to 0 only if you explicitly want immediate deletion."
  type        = number
  default     = 7
}
