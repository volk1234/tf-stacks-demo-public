component "storage" {
  for_each = var.regions

  source = "./level-s"

  inputs = {
    region            = each.key
    env2              = ${var.env}
    environment_code  = "${var.env}-${each.value}"
    queue_name        = "core"
    iam_role_sqs_name = "core-receiver"
    iam_role_sns_name = "receiver-channel"
  }

  providers = {
    aws     = provider.aws.configurations[each.key]
  }
}
