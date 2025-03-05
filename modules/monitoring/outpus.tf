output "elasticsearch_endpoint" {
  value = aws_elasticsearch_domain.elk.endpoint
}

output "guardduty_detector_id" {
  value = aws_guardduty_detector.main.id
}