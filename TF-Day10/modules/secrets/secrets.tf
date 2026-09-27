resource "aws_secretsmanager_secret" "app" {
  name                    = "${var.project_name}/${var.environment}/app"
  description             = "Application configuration secrets for the ${var.environment} environment."
  recovery_window_in_days = var.recovery_window_in_days

  tags = {
    Name = "${var.project_name}-${var.environment}-app-secrets"
  }
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id = aws_secretsmanager_secret.app.id

  secret_string = jsonencode({
  DB_HOST       = var.database_host
  DB_NAME       = var.database_name
  DB_USER       = var.database_user
  DB_PASSWORD   = var.database_password
  MAIL_SERVER   = var.smtp_host
  MAIL_PORT     = tostring(var.smtp_port)
  MAIL_USERNAME = var.smtp_username
  MAIL_PASSWORD = var.smtp_password
})
}