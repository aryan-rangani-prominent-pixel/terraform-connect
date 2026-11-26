# IAM role assumed by AWS Lambda
resource "aws_iam_role" "lambda_role" {
  name = "ar_connect_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# CloudWatch logging permissions
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
# Terraform-managed Lambda function
resource "aws_lambda_function" "connect_lambda" {
  function_name = "ar_connect_lambda_tf"
  role          = aws_iam_role.lambda_role.arn

  runtime = "python3.15"
  handler = "lambda_function.lambda_handler"

  filename         = "${path.module}/ar_connect_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/ar_connect_lambda.zip")

  timeout     = 3
  memory_size = 128

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution
  ]
}
# Allow Amazon Connect to invoke the Lambda
resource "aws_lambda_permission" "connect_invoke" {
  statement_id  = "AllowAmazonConnectInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.connect_lambda.function_name
  principal     = "connect.amazonaws.com"
  source_arn    = data.aws_connect_instance.existing.arn
}
# Associate Terraform-managed Lambda with Amazon Connect
resource "aws_connect_lambda_function_association" "connect_lambda_association" {
  instance_id  = data.aws_connect_instance.existing.id
  function_arn = aws_lambda_function.connect_lambda.arn

  depends_on = [
    aws_lambda_permission.connect_invoke
  ]
}
# Customer lookup Lambda
resource "aws_lambda_function" "customer_lookup" {
  function_name = "ar_customer_lookup_lambda"
  role          = aws_iam_role.lambda_role.arn

  runtime = "python3.15"
  handler = "lambda_function.lambda_handler"

  filename         = "${path.module}/ar_customer_lookup_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/ar_customer_lookup_lambda.zip")

  timeout     = 5
  memory_size = 128

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution
  ]
}

# Allow Amazon Connect to invoke customer lookup Lambda
resource "aws_lambda_permission" "customer_lookup_invoke" {
  statement_id  = "AllowAmazonConnectCustomerLookup"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.customer_lookup.function_name
  principal     = "connect.amazonaws.com"
  source_arn    = data.aws_connect_instance.existing.arn
}

# Associate customer lookup Lambda with Connect
resource "aws_connect_lambda_function_association" "customer_lookup_association" {
  instance_id  = data.aws_connect_instance.existing.id
  function_arn = aws_lambda_function.customer_lookup.arn

  depends_on = [
    aws_lambda_permission.customer_lookup_invoke
  ]
}