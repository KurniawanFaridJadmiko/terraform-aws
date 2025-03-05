variable "environment" {
  description = "The environment name (e.g., production, staging)"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the Cognito user pool (e.g., auth.example.com)"
  type        = string
}