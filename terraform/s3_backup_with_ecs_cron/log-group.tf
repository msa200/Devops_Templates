resource "aws_cloudwatch_log_group" "log_group_s3" {
  name = "/fargate/s3-backup"
  retention_in_days = 30
}