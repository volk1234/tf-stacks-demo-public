variable "regions" {
  type = map(string)
}

variable "identity_token_file" {
  type = string
}

variable "identity_token_file_vault" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "env" {
  type = string
}

variable "cidr" {
  type = string
}

variable "default_tags" {
  description = "A map of default tags to apply to all AWS resources"
  type        = map(string)
  default     = {}
}

variable "workload_idp_name" {
  description = "The name of the workload IDP configured in the HCP Platform for Terraform Cloud to use"
  type        = string
}
