# ============================================================
# RDS Subnet Group
# ============================================================

resource "aws_db_subnet_group" "app" {
  name = "${local.name_prefix}-db-subnets"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "${local.name_prefix}-db-subnets"
  }
}


# ============================================================
# RDS PostgreSQL
# ============================================================

resource "aws_db_instance" "app" {
  identifier = "${local.name_prefix}-postgres"

  engine = "postgres"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.database_name
  username = var.database_username
  password = random_password.db.result

  port = 5432

  db_subnet_group_name = aws_db_subnet_group.app.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible = false

  backup_retention_period = 0

  deletion_protection = false

  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name = "${local.name_prefix}-postgres"
  }
}