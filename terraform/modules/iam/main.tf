########################################
# ECS TASK EXECUTION ROLE
########################################

resource "aws_iam_role" "ecs_execution" {
  name = "ecsExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

########################################
# Attach AWS Managed Policy
########################################

resource "aws_iam_role_policy_attachment" "ecs_execution_managed" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

########################################
# Custom Secrets Access Policy (LEAST PRIVILEGE)
########################################

resource "aws_iam_policy" "secrets_policy" {
  name = "ecs-secrets-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          var.keystore_secret_arn,
          var.truststore_secret_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = aws_iam_policy.secrets_policy.arn
}

########################################
# ECS TASK ROLE (App permissions)
########################################

resource "aws_iam_role" "ecs_task" {
  name = "ecsTaskRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

########################################
# TERRAFORM BACKEND ACCESS POLICY
########################################

resource "aws_iam_policy" "terraform_backend_policy" {
  name = "terraform-backend-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      {
        Effect = "Allow"
        Action = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::your-tf-state-bucket"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::your-tf-state-bucket/*"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = "arn:aws:dynamodb:ap-south-1:*:table/terraform-locks"
      }
    ]
  })
}

resource "aws_iam_user" "gitlab" {
  name = "gitlab-ci-user"
}

resource "aws_iam_user_policy_attachment" "attach_tf_backend" {
  user       = aws_iam_user.gitlab.name
  policy_arn = aws_iam_policy.terraform_backend_policy.arn
}