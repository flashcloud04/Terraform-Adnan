resource "aws_security_group" "backend_alb" {
  name        = "${var.project_name}-${var.environment}-backend-alb-sg"
  description = "Allow backend traffic from frontend EC2 instances to the internal backend ALB."
  vpc_id      = var.vpc_id

  ingress {
    description     = "Flask traffic from frontend EC2"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    description = "Allow egress for health checks and upstream access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-backend-alb-sg"
  }
}
