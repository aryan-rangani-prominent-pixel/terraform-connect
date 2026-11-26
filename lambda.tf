data "aws_connect_lambda_function_association" "demo_lambda" {
  function_arn = "arn:aws:lambda:us-east-1:501046919017:function:ar_connect_lambda"
  instance_id  = module.amazon_connect.connect_instance_id
}