# CloudWatch Log Group untuk EKS
resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/aws/eks/${var.eks_cluster}/cluster"
  retention_in_days = 30
}

# GuardDuty untuk keamanan
resource "aws_guardduty_detector" "main" {
  enable = true
}

# Contoh integrasi Prometheus (biasanya deploy via Helm di EKS, hanya IAM disini)
resource "aws_iam_role" "prometheus_role" {
  name = "${var.environment}-prometheus-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# ELK Stack (contoh Elasticsearch)
resource "aws_elasticsearch_domain" "elk" {
  domain_name           = "${var.environment}-elk"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type = "t3.small.elasticsearch"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  vpc_options {
    subnet_ids = [var.subnet_ids[0]]
    security_group_ids = [aws_security_group.elk_sg.id]
  }
}

resource "aws_security_group" "elk_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}