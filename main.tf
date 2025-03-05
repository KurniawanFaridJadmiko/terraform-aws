module "networking" {
  source = "./modules/networking"
  region = var.region
  environment = var.environment
}

module "eks" {
  source = "./modules/eks"
  environment = var.environment
  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.private_subnets
}

module "alb" {
  source = "/modules/alb"
  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.public_subnets
  eks_cluster = module.eks.cluster_id
}

module "cloudfront" {
  source = "./modules/cloudfront"
  alb_domain = module.alb.alb_dns_name
  domain_name = var.domain_name
}

module "waf" {
  source = "./modules/waf"
  environment = var.environment
  alb_arn = module.alb.alb_arn
}

module "s3" {
  source = "./modules/s3"
  environment = var.environment
  cloudfront_distribution_id = module.cloudfront.distribution_id
}

module "rds" {
  source = "./modules/rds"
  environment = var.environment
  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.private_subnets
}

module "cognito" {
  source = "./modules/cognito"
  environment = var.environment
  domain_name = var.domain_name
}

module "sns" {
  source            = "./modules/sns"
  environment       = var.environment
  notification_email = "admin@example.com"
  slack_webhook_url = "https://hooks.slack.com/services/indico-TSEL"
}

module "backup" {
  source      = "./modules/backup"
  environment = var.environment
  rds_arn     = module.rds.rds_arn
}

module "monitoring" {
  source      = "./modules/monitoring"
  eks_cluster = module.eks.cluster_id
  vpc_id      = module.networking.vpc_id
  subnet_ids  = module.networking.private_subnets
  environment = var.environment
}

resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  alias {
    name                   = module.cloudfront.domain_name
    zone_id                = module.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_iam_role" "admin_role" {
  name = "admin-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::ACCOUNT_ID:user/admin"
        }
      }
    ]
  })
}