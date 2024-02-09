locals {
  env                   = split("-", var.environment_code)[0]
  bucket_name           = "core-storage-${var.environment_code}"
  queue_name            = "${var.queue_name}-${var.environment_code}"
  deadletter_queue_name = "${var.queue_name}-deadletter-${var.environment_code}"
  queue_url             = "https://sqs.${var.region}.amazonaws.com/${data.aws_caller_identity.current.account_id}/${local.queue_name}"
  sqs_arn               = "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${local.queue_name}"
  sns_arn               = "arn:aws:sns:${var.region}:${data.aws_caller_identity.current.account_id}:*"


  tags = {
    terraform_state     = "level-s"
    terraform_workspace = var.environment_code
  }

}
