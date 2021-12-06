variable image_tag{
  type="string"
  }

data "aws_ssm_parameter" "input" {
          name = "input"
          }                       
              
data "aws_ecr_repository" "input" {
  name = "input"
}

data "template_file" "ecs_task_container_definition_web" {
  template = "${file("webapp.json")}"

  vars {
    image_name = "${data.aws_ecr_repository.company.repository_url}:${var.image_tag}"
    input= "${data.aws_ssm_parameter.input.arn}"
  }
}


data "aws_vpc" "company" {
    tags = {
    Name = "company"
  } 
}

data "aws_lb" "company" {
  name = "company"
}


data "aws_subnet" "private" {
      tags = {
    Name = "company_private"
  } 
}
data "aws_subnet" "private2" {
      tags = {
    Name = "company_private2"
  } 
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "company"
}

data "aws_iam_role" "ecs_task_role" {
  name = "company-ecsTaskRole"
}

data "aws_security_group" "ecs_tasks_sg" {
  name = "ecs-security-group"
}

data "aws_route53_zone" "private_dns" {
  name         = "company."
  private_zone = true
}