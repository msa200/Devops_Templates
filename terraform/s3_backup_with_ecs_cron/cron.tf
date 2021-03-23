resource "aws_cloudwatch_event_rule" "cron_each_week" {
  name                = "run_each_week"
  description         = "Schedule trigger for run every week at midnight"
  schedule_expression = "rate(7 days)"
  is_enabled          = true
}

resource "aws_cloudwatch_event_target" "main" {
  target_id = "backup"
  arn       = "${data.aws_ecs_cluster.mycompany.arn}"
  rule      = "${aws_cloudwatch_event_rule.cron_each_week.name}"
  role_arn  = "${data.aws_iam_role.scheduled_task_event_role.arn}"

  ecs_target {
    task_count          = 1
    task_definition_arn = "${aws_ecs_task_definition.backup.arn}"
    launch_type         = "FARGATE"
    platform_version    = "1.4.0"

    network_configuration {
      security_groups  = ["${data.aws_security_group.ecs_tasks_sg.id}"]
      subnets          = ["${data.aws_subnet.private1.id}","${data.aws_subnet.private2.id}"]
      assign_public_ip = false
    }
  }

  depends_on = [
    aws_ecs_task_definition.backup
  ]
}
