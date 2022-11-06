resource "aws_cloudwatch_event_rule" "resource_monitor_event_rule" {
  name                = var.event_rule_name
  description         = var.event_rule_description
  schedule_expression = var.event_expression
}

resource "aws_cloudwatch_event_target" "resource_monitor_lambda_target" {
  rule = aws_cloudwatch_event_rule.resource_monitor_event_rule.name
  arn  = var.lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_resource_monitor_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.aws_cloudwatch_event_rule
}
