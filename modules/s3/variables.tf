variable "environment" {
  description = "The environment name (e.g., production, staging)"
  type        = string
}

variable "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution that will access the S3 bucket"
  type        = string
}