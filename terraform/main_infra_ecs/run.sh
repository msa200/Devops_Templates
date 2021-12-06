#!/bin/bash
terraform apply -auto-approve
vpc_id=`terraform output vpc_id`
load_balancer_arn=`terraform output load_balancer_arn`
privte_subnet_id=`terraform output privte_subnet_id`
ecs_task_execution_role_arn=`terraform output ecs_task_execution_role_arn` >> dev.tfvars 
ecs_task_role_arn=`terraform output ecs_task_role_arn`
ecs_tasks_sg_id=`terraform output ecs_tasks_sg_id` 
echo "vpc_id= \"${vpc_id}\""   >> dev.tfvars
echo "load_balancer_arn= \"$load_balancer_arn\""   >> dev.tfvars
echo "privte_subnet_id= \"$privte_subnet_id\""   >> dev.tfvars
echo "ecs_task_execution_role_arn= \"$ecs_task_execution_role_arn\""   >> dev.tfvars
echo "ecs_task_role_arn= \"$ecs_task_role_arn\""   >> dev.tfvars
echo "ecs_tasks_sg_id= \"$ecs_tasks_sg_id\""   >> dev.tfvars
echo "private_dns_namespace= \"$private_dns_namespace\""   >> dev.tfvars
cp dev.tfvars ../myshop/terraform
rm dev.tfvars
