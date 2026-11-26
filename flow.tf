resource "aws_connect_contact_flow" "demo_with_tf" {
  instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
  name        = "ar_demo_tf"
  description = "for demo only with terraform"
  type        = "CONTACT_FLOW"
  content = templatefile(
    "${path.module}/ar_practice.json.tftpl",
    {
      cards_queue_arn = module.amazon_connect.cards_queue_arn
      fraud_queue_arn = module.amazon_connect.fraud_queue_arn
    }
  )
  tags = {
    "Name"        = "Test contact flow"
    "Application" = "Terraform"
    "Method"      = "Create"
    "user"        = "aryan_rangani"
  }
}
# Customer verification flow using Lambda
resource "aws_connect_contact_flow" "customer_verification" {
  instance_id = data.aws_connect_instance.existing.id
  name        = "ar_customer_verification_tf"
  description = "Customer ID verification through Lambda"
  type        = "CONTACT_FLOW"

  content = templatefile("${path.module}/ar_customer_verification.json.tftpl", {
    customer_lambda_arn = aws_lambda_function.customer_lookup.arn
  })

  tags = {
    Name        = "Customer Verification Flow"
    Application = "Terraform"
    Method      = "Lambda"
    user        = "aryan_rangani"
  }

  depends_on = [
    aws_connect_lambda_function_association.customer_lookup_association
  ]
}
