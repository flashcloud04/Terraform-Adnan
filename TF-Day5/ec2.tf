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

  depends_on = [aws_secretsmanager_secret_version.db]

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

  # Install Docker
  dnf install -y docker

  # Start Docker
  systemctl enable docker
  systemctl start docker

  # Wait for Docker to be ready
  until docker info >/dev/null 2>&1; do
    sleep 2
  done

  # AWS region
  AWS_REGION="${var.aws_region}"

  # Pull the configured container image
  APP_IMAGE="${var.container_image}"
  docker pull "$APP_IMAGE"

  # Retrieve database credentials from Secrets Manager
  SECRET_JSON=$(aws secretsmanager get-secret-value \
    --secret-id "${aws_secretsmanager_secret.db.id}" \
    --region "$AWS_REGION" \
    --query SecretString \
    --output text)

  DB_USERNAME=$(echo "$SECRET_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["username"])')
  DB_PASSWORD=$(echo "$SECRET_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["password"])')

  # RDS endpoint
 DB_HOST="${aws_db_instance.app.address}"

  # Remove old container if it exists
  docker rm -f ${local.name_prefix}-backend 2>/dev/null || true

  # Start FastAPI application
  docker run -d \
    --name ${local.name_prefix}-backend \
    --restart unless-stopped \
    -p 8000:8000 \
    -e DATABASE_URL="postgresql+psycopg://$DB_USERNAME:$DB_PASSWORD@$DB_HOST:5432:${var.database_name}" \
    "$APP_IMAGE"

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