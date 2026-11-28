resource "aws_secretsmanager_secret" "bank_app_secret" {
  name = "ar_bank_connect/application-secret"
  kms_key_id = aws_kms_key.bank_connect_key.arn
}
resource "aws_iam_role_policy" "lambda_read_bank_secret" {
    name = "ar_lambda_read_bank_secret_policy"
    role = aws_iam_role.lambda_role.id
    policy = jsonencode({
        Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = aws_secretsmanager_secret.bank_app_secret.arn
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = aws_kms_key.bank_connect_key.arn
      }
    ]
    })
}