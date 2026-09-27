resource "aws_cloudwatch_metric_alarm" "frontend_asg_cpu_high" {
  alarm_name          = "${var.project_name}-${var.environment}-frontend-asg-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Frontend ASG average CPU above target threshold."
  dimensions = {
    AutoScalingGroupName = var.frontend_asg_name
  }
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "backend_asg_cpu_high" {
  alarm_name          = "${var.project_name}-${var.environment}-backend-asg-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Backend ASG average CPU above target threshold."
  dimensions = {
    AutoScalingGroupName = var.backend_asg_name
  }
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "frontend_alb_unhealthy_hosts" {
  alarm_name          = "${var.project_name}-${var.environment}-frontend-alb-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnhealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Average"
  threshold           = 0
  alarm_description   = "Frontend ALB has unhealthy targets."
  dimensions = {
    LoadBalancer = var.frontend_alb_arn_suffix
  }
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "backend_alb_unhealthy_hosts" {
  alarm_name          = "${var.project_name}-${var.environment}-backend-alb-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnhealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Average"
  threshold           = 0
  alarm_description   = "Backend ALB has unhealthy targets."
  dimensions = {
    LoadBalancer = var.backend_alb_arn_suffix
  }
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "${var.project_name}-${var.environment}-rds-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "RDS CPU utilization above 80%."
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_free_storage_low" {
  alarm_name          = "${var.project_name}-${var.environment}-rds-free-storage-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 5000000000
  alarm_description   = "RDS free storage is low."
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_connections_high" {
  alarm_name          = "${var.project_name}-${var.environment}-rds-connections-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 60
  alarm_description   = "RDS connection count is high."
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}
