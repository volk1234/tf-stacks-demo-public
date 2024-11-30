identity_token "aws" {
  audience = ["aws.workload.identity"]
}

identity_token "vault_secrets" {
  audience = ["hcp.workload.identity"]
}

deployment "development" {
  inputs = {
    regions             = {
      "us-east-1" : "use1",
      }
    env                 = "dev"
    role_arn            = "arn:aws:iam::056618128975:role/terraform-cloud-oidc-access-deployment-role"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags        = { deployment-name = "development"}
    cidr                = "10.1.0.0/16"
    workload_idp_name   = "iam/project/1a809607-5649-4d32-804b-c6d0b906122c/service-principal/vault-secrets/workload-identity-provider/my-workload-identity-provider"
    identity_token_file_vault = identity_token.vault_secrets.jwt_filename
  }
}

deployment "production" {
  inputs = {
    regions             = {
      "us-east-1" : "use1",
      "eu-west-1" : "euw1",
      }
    env                 = "prod"
    role_arn            = "arn:aws:iam::056618128975:role/terraform-cloud-oidc-access-deployment-role"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags        = { deployment-name = "production"}
    cidr                = "10.10.0.0/16"
    workload_idp_name         = "iam/project/1a809607-5649-4d32-804b-c6d0b906122c/service-principal/vault-secrets/workload-identity-provider/my-workload-identity-provider"
    identity_token_file_vault = identity_token.vault_secrets.jwt_filename
  }
}
