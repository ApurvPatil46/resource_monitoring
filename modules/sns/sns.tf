resource "aws_sns_topic" "lambda_monitor_topic" {
  name         = var.sns_topic_name
  display_name = var.sns_topic_display_name
}

resource "aws_sns_topic_subscription" "lambda_monitor_topic_subscription" {
  topic_arn = var.sns_topic_arn
  protocol  = var.protocol
  endpoint  = var.endpoint_email
}
