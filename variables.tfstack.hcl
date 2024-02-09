variable "regions" {
  type = set(string)
}

variable "identity_token_file" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "env" {
  type = string
}

variable "default_tags" {
  description = "A map of default tags to apply to all AWS resources"
  type        = map(string)
  default     = {}
}
