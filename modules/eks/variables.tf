variable "environment" {
  description = "The environment name (e.g., production, staging)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS cluster will be placed"
  type        = list(string)
}