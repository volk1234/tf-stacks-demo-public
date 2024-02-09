component "storage" {
  for_each = toset(formatlist("%s", range(length(var.regions))))

  source = "./level-s"

  inputs = {
    region            = each.key
    environment_code  = "${var.env}-${var.regions[each.key]}"
    queue_name        = "core"
    iam_role_sqs_name = "core-receiver"
    iam_role_sns_name = "receiver-channel"
  }

  providers = {
    aws     = provider.aws.configurations[each.key]
  }
}
