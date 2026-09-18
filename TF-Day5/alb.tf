# ============================================================
# Application Load Balancer
# ============================================================

resource "aws_lb" "app" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name = "${local.name_prefix}-alb"
  }
}


# ============================================================
# Target Group
# ============================================================

resource "aws_lb_target_group" "app" {
  name_prefix = "tg-"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = var.health_check_path
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name = "${local.name_prefix}-target-group"
  }
}


# ============================================================
# HTTP Listener
# ============================================================

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}