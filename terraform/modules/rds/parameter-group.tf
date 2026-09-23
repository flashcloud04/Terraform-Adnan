resource "aws_db_parameter_group" "mysql" {
  name   = "${var.project_name}-${var.environment}-mysql-params"
  family = "mysql8.0"

  parameter {
    name  = "sql_mode"
    value = "STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-mysql-params"
  }
}
