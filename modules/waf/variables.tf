variable "environment" {
  description = "The environment name (e.g., production, staging)"
  type        = string
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer to associate with the WAF"
  type        = string
}