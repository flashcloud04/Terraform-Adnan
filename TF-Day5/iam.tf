resource "aws_iam_role" "ec2" {
  name = "${local.name_prefix}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${local.name_prefix}-ec2-profile"
  role = aws_iam_role.ec2.name
}
resource "aws_iam_policy" "ec2_database_secret" {
  name        = "${local.name_prefix}-database-secret-read"
  description = "Allow EC2 application instances to read the database credentials secret"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue"
        ]

        Resource = aws_secretsmanager_secret.db.arn
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-database-secret-read"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_database_secret" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ec2_database_secret.arn
}
