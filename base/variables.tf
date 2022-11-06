variable "iam_role_name" {
  type = string
}

variable "iam_policy_name" {
  type = string
}

variable "sns_topic_name" {
  type = string
}

variable "sns_topic_display_name" {
  type = string
}

variable "endpoint_email" {
  type = string
}

variable "protocol" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "lambda_handler_name" {
  type = string
}

variable "instance_runtime" {
  type = string
}

variable "timeout_secs" {
  type = string
}

variable "event_rule_name" {
  type = string
}

variable "event_rule_description" {
  type = string
}

variable "event_expression" {
  type = string
}
