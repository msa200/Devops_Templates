resource "aws_ecs_task_definition" "webapp" {
  network_mode             = "awsvpc"
  family = "api"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 2048
  memory                   = 4096
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
  task_role_arn            = "${data.aws_iam_role.ecs_task_role.arn}"
  container_definitions = "${data.template_file.ecs_task_container_definition_web.rendered}"
}

resource "aws_ecs_task_definition" "redishost" {
  network_mode             = "awsvpc"
  family = "redis"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 4096
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
  task_role_arn            = "${data.aws_iam_role.ecs_task_role.arn}"
  container_definitions = "${file("redishost.json")}"
    volume {
    name      = "efs"
    efs_volume_configuration {
      file_system_id = "${aws_efs_file_system.FS.id}"
      root_directory = "/"
    }
  }
}