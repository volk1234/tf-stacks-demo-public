locals {

  tags = {
    terraform_state     = "level-n"
    terraform_workspace = var.environment_code
  }

}
