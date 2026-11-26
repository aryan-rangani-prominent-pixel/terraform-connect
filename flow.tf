resource "aws_connect_contact_flow" "demo_with_tf" {
  instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
  name = "ar_demo_tf"
  description = "for demo only with terraform"
  type = "CONTACT_FLOW"
    content = templatefile(
  "${path.module}/ar_practice.json.tftpl",
  {
    cards_queue_arn = module.amazon_connect.cards_queue_arn
    fraud_queue_arn = module.amazon_connect.fraud_queue_arn
  }
)
    tags = {
        "Name" = "Test contact flow"
        "Application" = "Terraform"
        "Method" = "Create"
        "user" = "aryan_rangani"
    }
}