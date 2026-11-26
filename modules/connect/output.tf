
output "connect_instance_id" {
  value = data.aws_connect_instance.existing.id
}

output "user_id" {
  value = aws_connect_user.demo_user.id
}

output "routing_profile_id" {
  value = aws_connect_routing_profile.new_routing.id
}

output "security_profile_id" {
  value = aws_connect_security_profile.new_sp_demo.id
}

output "quick_connect_id" {
  value = aws_connect_quick_connect.demo_quick.id
}

output "cards_queue_id" {
  value = data.aws_connect_queue.cards_queues.id
}

output "fraud_queue_id" {
  value = data.aws_connect_queue.fraud_queues.id
}


output "cards_queue_arn" {
  value = data.aws_connect_queue.cards_queues.arn
}

output "fraud_queue_arn" {
  value = data.aws_connect_queue.fraud_queues.arn
}