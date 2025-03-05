output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}

output "backup_vault_arn" {
  value = module.backup.backup_vault_arn
}

output "elasticsearch_endpoint" {
  value = module.monitoring.elasticsearch_endpoint
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "cloudfront_domain" {
  value = module.cloudfront.domain_name
}