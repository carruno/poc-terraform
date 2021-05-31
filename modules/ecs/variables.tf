variable "name" {
  description = "Application Name"
  type        = string
}

variable "region" {
  description = "Aws region for policies"
  type        = string
  default     = "us-east-1"
}

data "aws_caller_identity" "current" {}
