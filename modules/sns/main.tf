resource "aws_sns_topic" "notifications" {
  name = "${var.environment}-notifications"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_sns_topic_subscription" "slack" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "https"
  endpoint  = var.slack_webhook_url
}