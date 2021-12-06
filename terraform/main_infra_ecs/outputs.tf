output "vpc_id" {
  value = "${aws_vpc.company.id}"
}

output "load_balancer_arn" {
  value = "${aws_lb.company.arn}"
}

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.company.id}"
}

output "privte_subnet_id" {
  value = "${aws_subnet.private.id}"
}
 
output "ecs_task_execution_role_arn" {
  value = "${aws_iam_role.ecs_task_execution_role.arn}"
} 
output "ecs_task_role_arn" {
  value = "${aws_iam_role.ecs_task_role.arn}"
} 
 
output "ecs_tasks_sg_id" {
  value = "${aws_security_group.ecs_tasks.id}"
}  

output "private_dns_namespace" {
  value = "${aws_service_discovery_private_dns_namespace.company.id}"
}  

