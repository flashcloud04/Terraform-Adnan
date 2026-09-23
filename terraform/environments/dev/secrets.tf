module "secrets" {
  source = "../../modules/secrets"

  project_name = var.project_name
  environment  = var.environment

  database_host     = var.database_host
  database_name     = var.database_name
  database_user     = var.database_user
  database_password = var.database_password
  smtp_host         = var.smtp_host
  smtp_port         = var.smtp_port
  smtp_username     = var.smtp_username
  smtp_password     = var.smtp_password
}
