data "aws_iam_policy_document" "assume_role" {
  provider = aws.core

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "access_sqs" {
  provider = aws.core
  statement {
    sid    = "sqsWrite"
    effect = "Allow"
    actions = [
      "sqs:DeleteMessage",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:DeleteMessageBatch",
      "sqs:SendMessageBatch",
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
      "sqs:GetQueueAttributes",
      "sqs:ListQueueTags",
      "sqs:SetQueueAttributes"
    ]

    resources = [
      local.sqs_arn,

    ]
  }
}

data "aws_iam_policy_document" "access_sns" {
  provider = aws.core

  statement {
    sid    = "snsPublish"
    effect = "Allow"
    actions = [
      "sns:Publish",
      "sns:ListTopics"
    ]

    resources = [
      local.sns_arn,
    ]
  }
}
# sqs
resource "aws_iam_role" "default_sqs" {
  provider = aws.core

  name               = var.iam_role_sqs_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.tags
}

resource "aws_iam_policy" "default_sqs" {
  provider = aws.core

  name   = "${local.queue_name}-sqs-write"
  policy = data.aws_iam_policy_document.access_sqs.json
}

resource "aws_iam_role_policy_attachment" "sqs" {
  provider = aws.core

  role       = aws_iam_role.default_sqs.name
  policy_arn = aws_iam_policy.default_sqs.arn
}

#sns
resource "aws_iam_role" "default_sns" {
  provider = aws.core

  name               = var.iam_role_sns_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.tags
}

resource "aws_iam_policy" "default_sns" {
  provider = aws.core

  name   = "${local.queue_name}-sns-write"
  policy = data.aws_iam_policy_document.access_sns.json
}

resource "aws_iam_role_policy_attachment" "sns" {
  provider = aws.core
  
  role       = aws_iam_role.default_sns.name
  policy_arn = aws_iam_policy.default_sns.arn
}