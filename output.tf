
output "user_id" {
  value = module.amazon_connect.user_id
}

output "routing_profile_id" {
  value = module.amazon_connect.routing_profile_id
}

output "security_profile_id" {
  value = module.amazon_connect.security_profile_id
}

output "quick_connect_id" {
  value = module.amazon_connect.quick_connect_id
}
output "lex_bot_alias_arn" {
  value = aws_cloudformation_stack.lex_connect_integration.outputs["LexBotAliasArn"]
}
output "lex_connect_association_id" {
  value = aws_cloudformation_stack.lex_connect_integration.outputs["ConnectAssociationId"]
}
output "connect_monitor_instance_id" {
  value = data.aws_connect_instance.monitor.id
}
output "ctr_archive_bucket_name" {
  value = aws_s3_bucket.ctr_archive.bucket
}
output "ctr_kinesis_stream_name" {
  value = aws_kinesis_stream.ctr_stream.name
} 
output "contact_flow_errors_alarm_name" {
  value = aws_cloudwatch_metric_alarm.contact_flow_errors.alarm_name
}
output "contact_flow_fatal_alarm_name" {
  value = aws_cloudwatch_metric_alarm.contact_flow_fatal_errors.alarm_name
}
output "calls_abandoned_alarm_name" {
  value = aws_cloudwatch_metric_alarm.calls_abandoned.alarm_name
}