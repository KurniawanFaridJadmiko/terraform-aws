variable "environment" {
  description = "The environment name (e.g., production, staging)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the ALB will be placed"
  type        = list(string)
}

variable "eks_cluster" {
  description = "The EKS cluster ID to associate with the ALB"
  type        = string
}