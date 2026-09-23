resource "aws_autoscaling_policy" "frontend_scale_out" {
  name                   = "${var.project_name}-${var.environment}-frontend-scale-out"
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70
  }
}

resource "aws_autoscaling_policy" "frontend_scale_in" {
  name                   = "${var.project_name}-${var.environment}-frontend-scale-in"
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 35
  }
}

resource "aws_autoscaling_policy" "backend_scale_out" {
  name                   = "${var.project_name}-${var.environment}-backend-scale-out"
  autoscaling_group_name = aws_autoscaling_group.backend.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70
  }
}

resource "aws_autoscaling_policy" "backend_scale_in" {
  name                   = "${var.project_name}-${var.environment}-backend-scale-in"
  autoscaling_group_name = aws_autoscaling_group.backend.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 35
  }
}
