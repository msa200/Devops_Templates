resource "aws_ecs_task_definition" "backup" {
  network_mode             = "awsvpc"
  family = "backup"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
  task_role_arn            = "${data.aws_iam_role.ecs_task_role.arn}"
  container_definitions = "${data.template_file.ecs_task_container_definition_backup.rendered}"
  volume {
    name      = "efs"
    efs_volume_configuration {
      file_system_id = "${aws_efs_file_system.FS.id}"
      root_directory = "/"
    }
  }
}
