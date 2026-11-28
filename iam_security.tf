resource "aws_iam_role_policy" "lambda_logging" {
  name = "ar_connect_lambda_logging_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:us-east-1:501046919017:log-group:/aws/lambda/ar_connect_lambda_tf:*"
      }
    ]
  })
}