resource "aws_db_instance" "this" {
  identifier                          = "${var.project_name}-${var.environment}-mysql"
  engine                              = "mysql"
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  storage_type                        = "gp2"
  storage_encrypted                   = var.storage_encrypted
  db_name                             = var.database_name
  username                            = var.database_username
  password                            = var.database_password
  port                                = var.db_port
  db_subnet_group_name                = aws_db_subnet_group.this.name
  vpc_security_group_ids              = [var.db_security_group_id]
  parameter_group_name                = aws_db_parameter_group.mysql.name
  publicly_accessible                 = var.publicly_accessible
  multi_az                            = var.multi_az
  backup_retention_period             = var.backup_retention_period
  deletion_protection                 = var.deletion_protection
  skip_final_snapshot                 = var.skip_final_snapshot
  apply_immediately                   = true
  auto_minor_version_upgrade          = true
  performance_insights_enabled        = false
  copy_tags_to_snapshot               = true
  final_snapshot_identifier           = var.skip_final_snapshot ? null : "${var.project_name}-${var.environment}-mysql-final"
  maintenance_window                  = "sun:03:00-sun:04:00"
  backup_window                      = "02:00-03:00"
  enabled_cloudwatch_logs_exports    = ["error", "general", "slowquery"]

  tags = {
    Name = "${var.project_name}-${var.environment}-mysql"
  }
}
