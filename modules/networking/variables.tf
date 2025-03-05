variable "region" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., production, staging)"
  type        = string
}