

resource "aws_ecs_service" "webapp" {
 name                               = "webapp"
 cluster                            = "company"
 task_definition                    = "${aws_ecs_task_definition.webapp.arn}"
 desired_count                      = 1
 launch_type                        = "FARGATE"
#  scheduling_strategy                = "REPLICA"
 network_configuration {
   security_groups  = ["${data.aws_security_group.ecs_tasks_sg.id}"]
   subnets          = ["${data.aws_subnet.private.id}"]
  #  assign_public_ip = true
 }
 
 load_balancer {
   target_group_arn = "${aws_alb_target_group.webapp.arn}"
   container_name   = "webapp"
   container_port   = 9009
 }
}

resource "aws_ecs_service" "redishost" {
 name                               = "redishost"
 cluster                            = "company"
 platform_version = "1.4.0"
 task_definition                    = "${aws_ecs_task_definition.redishost.arn}"
 desired_count                      = 1
 launch_type                        = "FARGATE"
 service_registries = {
   registry_arn = "${aws_service_discovery_service.redishost.arn}"

 }
#  scheduling_strategy                = "REPLICA"
 network_configuration {
   security_groups  = ["${data.aws_security_group.ecs_tasks_sg.id}"]
   subnets          = ["${data.aws_subnet.private.id}"]
  #  assign_public_ip = true
 }
 
}


