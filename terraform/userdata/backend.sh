#!/bin/bash
set -euxo pipefail

# Install dependencies
amazon-linux-extras enable python3.12
yum update -y
yum install -y python3 git awscli jq

# Create app directory
mkdir -p /opt/ecommerce/backend
cd /opt/ecommerce/backend

git clone ${app_repository} app-src || true
cd app-src || cd /opt/ecommerce/backend/app-src

python3 -m venv /opt/ecommerce/backend/venv
source /opt/ecommerce/backend/venv/bin/activate

pip install --upgrade pip
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

# Fetch readable app config from Secrets Manager
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id ${secret_arn} --query SecretString --output text)
export DATABASE_HOST="${database_host}"
export DATABASE_NAME="${database_name}"
export DATABASE_USER="${database_user}"
export DATABASE_PASSWORD="${database_password}"

# Create app environment file
cat > /opt/ecommerce/backend/.env <<EOF
DATABASE_HOST=${database_host}
DATABASE_NAME=${database_name}
DATABASE_USER=${database_user}
DATABASE_PASSWORD=${database_password}
APP_ENV=${app_environment}
FLASK_ENV=${app_environment}
EOF

# Create systemd unit
cat > /etc/systemd/system/ecommerce-backend.service <<EOF
[Unit]
Description=Ecommerce Flask Backend
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/ecommerce/backend/app-src
Environment=APP_ENV=${app_environment}
Environment=DATABASE_HOST=${database_host}
Environment=DATABASE_NAME=${database_name}
Environment=DATABASE_USER=${database_user}
Environment=DATABASE_PASSWORD=${database_password}
ExecStart=/opt/ecommerce/backend/venv/bin/gunicorn --bind 0.0.0.0:5000 app:app
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ecommerce-backend.service
systemctl start ecommerce-backend.service

# CloudWatch log setup
mkdir -p /var/log/ecommerce-app
cat > /opt/aws/amazon-cloudwatch-agent/bin/config.json <<EOF
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/ecommerce-app/*.log",
            "log_group_name": "${log_group_name}",
            "log_stream_name": "backend-app"
          }
        ]
      }
    }
  }
}
EOF

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json
