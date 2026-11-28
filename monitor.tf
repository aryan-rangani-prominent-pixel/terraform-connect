data "aws_connect_instance" "monitor" {
    instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
}
resource "aws_cloudwatch_metric_alarm" "contact_flow_errors" {
  alarm_name = "ar_connect_contact_flow_errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "ContactFlowErrors"
  namespace = "AWS/Connect"
  period = 300
  statistic = "Sum"
  threshold = 1
  dimensions = {
    InstanceId = data.aws_connect_instance.monitor.id
  }
  treat_missing_data = "notBreaching"
}
resource "aws_cloudwatch_metric_alarm" "contact_flow_fatal_errors" {
    alarm_name = "ar_connect_contact_flow_fatal_errors"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = 1
    metric_name = "ContactFlowFatalError"
    namespace = "AWS/Connect"
    period = 300
    statistic = "Sum"
    threshold = 1
    dimensions = {
      InstanceId = data.aws_connect_instance.monitor.id
    }
    treat_missing_data = "notBreaching"
}
resource "aws_cloudwatch_metric_alarm" "calls_abandoned" {
  alarm_name = "ae_connect_calls_abandoned"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CallsAbandoned"
  namespace = "AWS/Connect"
  period = 300
  statistic = "Sum"
  threshold = 1
  dimensions = {
    InstanceId = data.aws_connect_instance.monitor.id
  }
  treat_missing_data = "notBreaching"
}