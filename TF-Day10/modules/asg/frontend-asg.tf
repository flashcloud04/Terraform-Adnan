resource "aws_autoscaling_group" "frontend" {
  name                = "${var.project_name}-${var.environment}-frontend-asg"
  min_size            = var.frontend_min_size
  desired_capacity    = var.frontend_desired_capacity
  max_size            = var.frontend_max_size
  vpc_zone_identifier = var.private_app_subnet_ids
  target_group_arns   = [var.frontend_target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = var.frontend_health_check_grace_period
  default_cooldown          = 60

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-frontend-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}
