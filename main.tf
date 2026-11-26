
module "amazon_connect" {
  source = "./modules/connect"

  instance_id = data.aws_connect_instance.existing.id

  user_name     = var.user_name
  user_password = var.user_password

  first_name = var.first_name
  last_name  = var.last_name

  routing_profile_name  = var.routing_profile_name
  security_profile_name = var.security_profile_name

  default_outbound_queue_id = data.aws_connect_queue.fraud_queues.queue_id
  fraud_queue_id            = data.aws_connect_queue.fraud_queues.queue_id
  cards_queue_id            = data.aws_connect_queue.cards_queues.queue_id

  contact_flow_id = var.contact_flow_id

  quick_connect_name = var.quick_connect_name
}
