locals {
  bucket_name           = "core-storage-${local.env}"
  queue_name            = "${var.queue_name}-${local.env}"
  deadletter_queue_name = "${var.queue_name}-deadletter-${local.env}"
  queue_url             = "https://sqs.${var.region}.amazonaws.com/${data.aws_caller_identity.current.account_id}/${local.queue_name}"
  sqs_arn               = "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${local.queue_name}"
  sns_arn               = "arn:aws:sns:${var.region}:${data.aws_caller_identity.current.account_id}:*"


  tags = {
    terraform_state     = "level-s"
    terraform_workspace = var.environment_code
  }

}
