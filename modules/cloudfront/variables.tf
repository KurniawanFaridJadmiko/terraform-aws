variable "alb_domain" {
  description = "The domain name of the Application Load Balancer to be used as the CloudFront origin"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the CloudFront distribution (e.g., example.com)"
  type        = string
}