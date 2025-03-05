resource "aws_backup_vault" "main" {
  name = "${var.environment}-backup-vault"
}

resource "aws_backup_plan" "rds_backup" {
  name = "${var.environment}-rds-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.main.name
    schedule          = "cron(0 0 * * ? *)"
    lifecycle {
      delete_after = 90 # Retain backups for 90 days
    }
  }
}

resource "aws_backup_selection" "rds" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "${var.environment}-rds-selection"
  plan_id      = aws_backup_plan.rds_backup.id
  resources    = [var.rds_arn]
}

resource "aws_iam_role" "backup_role" {
  name = "${var.environment}-backup-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}