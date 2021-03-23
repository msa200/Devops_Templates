data "aws_iam_role" "scheduled_task_event_role" {
  name = "worker-task-event-role"
}

data "aws_ssm_parameter" "BACKUP_S3"{
        name= "BACKUP_S3"
}
data "aws_ssm_parameter" "S3_BACKUP_TARGETS"{
        name= "S3_BACKUP_TARGETS"
}
data "aws_ssm_parameter" "BACKUP_AWS_KEY" {
        name = "BACKUP_AWS_KEY"
}
data "aws_ssm_parameter" "BACKUP_AWS_SECRET" {
        name = "BACKUP_AWS_SECRET"
}

data "aws_ecs_cluster" "mycompany" {
        cluster_name="${var.cluster_name}"  
}
data "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.ecs_task_execution_role}"
}
data "aws_iam_role" "ecs_task_role" {
  name = "${var.ecs_task_role}"
}

data "template_file" "ecs_task_container_definition_backup" {
  template = "${file("backup.json")}"

  vars ={
    log_group= "${aws_cloudwatch_log_group.log_group_s3.name}"
    image_name = "${aws_ecr_repository.s3_backup.repository_url}:${var.image_tag}"
    BACKUP_S3= "${data.aws_ssm_parameter.BACKUP_S3.arn}"
    S3_BACKUP_TARGETS= "${data.aws_ssm_parameter.S3_BACKUP_TARGETS.arn}"
    BACKUP_AWS_KEY= "${data.aws_ssm_parameter.BACKUP_AWS_KEY.arn}"
    BACKUP_AWS_SECRET= "${data.aws_ssm_parameter.BACKUP_AWS_SECRET.arn}" 
  }
}
data "aws_vpc" "mycompany" {
    tags={
      Name="${var.vpc_name}"
    }  
}

data "aws_security_group" "ecs_tasks_sg" {
      tags ={
        Name="${var.ecs_tasks_sg}"
      }
}

data "aws_subnet" "private1" {
      tags= {
        Name="${var.private_subnet_1}"
      }
  
}


data "aws_subnet" "private2" {
      tags ={
        Name="${var.private_subnet_2}"
      }
} 

