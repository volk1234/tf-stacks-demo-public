identity_token "aws" {
  audience = ["<Set to your AWS IAM assume-role audience>"]
}

deployment "development" {
  variables = {
    regions             = ["us-east-1"]
    env                 = "dev"
    role_arn            = "arn:aws:iam::056618128975:role/terraform-cloud-oidc-access-deployment-role"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags        = { deployment-name = "development"}
  }
}