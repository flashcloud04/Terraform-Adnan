data "aws_iam_policy_document" "ec2_secrets_read" {
  statement {
    sid    = "ReadSecretsFromSecretsManager"
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]

    resources = [var.secret_arn]
  }
}

data "aws_iam_policy_document" "ec2_cloudwatch_agent" {
  statement {
    sid    = "WriteCloudWatchLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "PutCloudWatchMetrics"
    effect = "Allow"

    actions = [
      "cloudwatch:PutMetricData"
    ]

    resources = ["*"]
  }
  statement {
  sid    = "ReadApplicationArtifact"
  effect = "Allow"

  actions = [
    "s3:GetObject"
  ]

  resources = [
    "${var.application_bucket_arn}/*"
  ]
}
}

resource "aws_iam_policy" "ec2_secrets_read" {
  name        = "${var.project_name}-${var.environment}-ec2-secrets-read"
  description = "Allow EC2 instances to retrieve application secrets from AWS Secrets Manager."
  policy      = data.aws_iam_policy_document.ec2_secrets_read.json
}

resource "aws_iam_policy" "ec2_cloudwatch_agent" {
  name        = "${var.project_name}-${var.environment}-ec2-cloudwatch-agent"
  description = "Allow EC2 instances to publish logs and metrics to CloudWatch."
  policy      = data.aws_iam_policy_document.ec2_cloudwatch_agent.json
}
