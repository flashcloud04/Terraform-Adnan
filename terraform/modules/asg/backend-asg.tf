resource "aws_autoscaling_group" "backend" {
  name                = "${var.project_name}-${var.environment}-backend-asg"
  min_size            = var.backend_min_size
  desired_capacity    = var.backend_desired_capacity
  max_size            = var.backend_max_size
  vpc_zone_identifier = var.private_app_subnet_ids
  target_group_arns   = [var.backend_target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = var.backend_health_check_grace_period
  default_cooldown          = 60

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-backend-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}
