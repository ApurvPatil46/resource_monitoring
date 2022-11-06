variable "lambda_function_name" {
  type = string
}
variable "lambda_handler_name" {
  type = string
}
variable "lambda_role_arn" {
  type = string
}
variable "sns_topic_arn" {
  type = string
}
variable "timeout_secs" {
  type = string
}
variable "ec2_instance_runtime" {
  type = string
}
