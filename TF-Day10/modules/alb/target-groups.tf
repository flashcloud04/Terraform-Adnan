resource "aws_lb_target_group" "frontend" {
  name     = coalesce(var.frontend_target_group_name, "${var.project_name}-${var.environment}-frontend-tg")
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = var.frontend_health_check_path
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-frontend-tg"
  }
}

resource "aws_lb_target_group" "backend" {
  name        = coalesce(var.backend_target_group_name, "${var.project_name}-${var.environment}-backend-tg")
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = var.backend_health_check_path
    port                = 5000
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-backend-tg"
  }
}
