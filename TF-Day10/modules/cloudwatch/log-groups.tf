resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/aws/ec2/${var.project_name}-${var.environment}/frontend"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.project_name}-${var.environment}-frontend-log-group"
  }
}

resource "aws_cloudwatch_log_group" "backend" {
  name              = "/aws/ec2/${var.project_name}-${var.environment}/backend"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.project_name}-${var.environment}-backend-log-group"
  }
}
