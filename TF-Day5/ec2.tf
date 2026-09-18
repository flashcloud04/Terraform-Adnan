# ============================================================
# Latest Amazon Linux 2023 AMI
# ============================================================

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# ============================================================
# EC2 Launch Template
# ============================================================

resource "aws_launch_template" "app" {
  name_prefix   = "${local.name_prefix}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2.name
  }

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  user_data = base64encode(<<-EOF
  #!/bin/bash

  set -e

  # Update packages
  dnf update -y

  # Install and start Apache HTTP Server
  dnf install -y httpd

  cat > /var/www/html/index.html <<'HTML'
  <!doctype html>
  <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>${local.name_prefix}</title>
    </head>
    <body>
      <h1>${local.name_prefix} is running</h1>
    </body>
  </html>
  HTML

  systemctl enable httpd
  systemctl restart httpd

EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.name_prefix}-app"
    }
  }

  tags = {
    Name = "${local.name_prefix}-launch-template"
  }
}