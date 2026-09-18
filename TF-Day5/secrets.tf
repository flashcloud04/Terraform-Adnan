# ============================================================
# Database Password
# ============================================================

resource "random_password" "db" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}:?,."
}


# ============================================================
# Secrets Manager
# ============================================================

resource "aws_secretsmanager_secret" "db" {
  name = "${local.name_prefix}/database"

  description = "Credentials for the AWS Cloud DevOps PostgreSQL database"

  tags = {
    Name = "${local.name_prefix}-database-secret"
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = var.database_username
    password = random_password.db.result
  })
}