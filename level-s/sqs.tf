resource "aws_sqs_queue" "deadletter_queue" {
  provider = aws.core

  name                      = local.deadletter_queue_name
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 1209600
  receive_wait_time_seconds = 0
  tags                      = local.tags
}

resource "aws_sqs_queue" "core" {
  provider = aws.core

  name                       = local.queue_name
  delay_seconds              = 0
  visibility_timeout_seconds = 60
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 15
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.deadletter_queue.arn}\",\"maxReceiveCount\":3}"
  tags                       = local.tags
}

resource "aws_sqs_queue_policy" "write_queue" {
  provider = aws.core

  queue_url = local.queue_url

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "SqsPolicy",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "SQS:SendMessage",
        "SQS:GetQueueUrl",
        "SQS:DeleteMessage",
        "SQS:GetQueueAttributes"
      ],
      "Resource": "${aws_sqs_queue.core.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:${var.queue_name}-${local.env}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sns_topic" "core_topic" {
  provider = aws.core

  name = local.queue_name
  tags = local.tags
}

resource "aws_sns_topic_subscription" "sns_target" {
  provider = aws.core

  topic_arn            = aws_sns_topic.core_topic.arn
  protocol             = "sqs"
  endpoint             = local.sqs_arn
  raw_message_delivery = true
}

