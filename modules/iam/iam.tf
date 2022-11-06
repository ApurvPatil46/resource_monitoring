resource "aws_iam_role" "lambda_monitor_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [{
      "Action" = "sts:AssumeRole"
      "Effect" = "Allow"
      "Principal" = {
        "Service" = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_monitor_policy" {
  name = var.iam_policy_name
  role = aws_iam_role.lambda_monitor_role.id
  policy = jsonencode({
    "Version" = "2012-10-17"
    "Statement" = [{
      "Sid"    = "lambdaaccesssns",
      "Effect" = "Allow",
      "Action" = [
        "sns:ListSubscriptionsByTopic",
        "sns:GetTopicAttributes",
        "sns:ListSMSSandboxPhoneNumbers",
        "sns:ListTopics",
        "sns:ListSubscriptions",
        "sns:ListOriginationNumbers",
        "sns:ListEndpointsByPlatformApplication",
        "sns:Publish",
        "sns:ListPlatformApplications",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams",
        "logs:DescribeLogGroups",
        "ec2:DescribeInstances",
        "ec2:DescribeTags",
        "ec2:DescribeInstanceTypes",
        "ec2:StopInstances",
        "ec2:TerminateInstances"
      ],
      "Resource" = "*"
    }]
  })
}
