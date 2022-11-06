terraform {
  required_version = "0.13.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.55"
    }
  }

  backend "s3" {
    region         = "<specify>"
    bucket         = "<specify>"
    key            = "<specify>"
    dynamodb_table = "<specify>"
  }
}

# Note: to support python 3.9 in lambda function, you will aws provider version at least 3.55. 
#In order to support aws provider 3.55, terraform version needed is .13.5.

module "resource_monitoring_iam" {
  source          = "../modules/iam"
  iam_role_name   = var.iam_role_name
  iam_policy_name = var.iam_policy_name
}

module "resource_monitoring_sns" {
  source                 = "../modules/sns"
  sns_topic_name         = var.sns_topic_name
  sns_topic_display_name = var.sns_topic_display_name
  endpoint_email         = var.endpoint_email
  protocol               = var.protocol
  sns_topic_arn          = module.resource_monitoring_sns.lambda_monitor_resource_sns_arn
}

module "resource_monitoring_lambda" {
  source               = "../modules/lambda"
  lambda_function_name = var.lambda_function_name
  lambda_handler_name  = var.lambda_handler_name
  lambda_role_arn      = module.resource_monitoring_iam.monitor_role_arn
  sns_topic_arn        = module.resource_monitoring_sns.lambda_monitor_resource_sns_arn
  instance_runtime     = var.instance_runtime
  timeout_secs         = var.timeout_secs
  depends_on = [
    module.resource_monitoring_sns
  ]
}

module "resource_monitoring_event" {
  source                    = "../modules/cloudwatch_events"
  event_rule_name           = var.event_rule_name
  event_rule_description    = var.event_rule_description
  event_expression          = var.event_expression
  lambda_function_arn       = module.resource_monitoring_lambda.resource_monitoring_lambda_arn
  lambda_function_name      = var.lambda_function_name
  cloudwatch_event_rule_arn = module.resource_monitoring_event.aws_cloudwatch_event_rule_arn
}
