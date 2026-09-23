resource "aws_lb" "backend" {
  name               = "${var.project_name}-${var.environment}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.backend_alb_security_group_id]
  subnets            = var.private_app_subnet_ids

  tags = {
    Name = "${var.project_name}-${var.environment}-backend-alb"
  }
}
