data "archive_file" "monitor_script" {
  type        = "zip"
  source_file = "../modules/lambda/script/resource_monitor_script.py"
  output_path = "resource_monitor_script.zip"
}

resource "aws_lambda_function" "resource_monitor" {
  filename      = "resource_monitor_script.zip"
  function_name = var.lambda_function_name
  role          = var.lambda_role_arn
  handler       = var.lambda_handler_name
  runtime       = "python3.9"
  timeout       = var.timeout_secs
  environment {
    variables = {
      sns_topic_arn_value  = var.sns_topic_arn
      ec2_instance_runtime = var.instance_runtime
    }
  }
  depends_on = [
    data.archive_file.monitor_script
  ]
  source_code_hash = data.archive_file.monitor_script.output_base64sha256
}
