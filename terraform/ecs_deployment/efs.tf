resource "aws_efs_file_system" "FS" {
  creation_token = "redis"
  tags = {
    Name = "redis"
  }
}

resource "aws_efs_file_system" "FS_elastic" {
  creation_token = "elastic"
  tags = {
    Name = "elastic"
  }
}

resource "aws_security_group" "EFS_SG" {
    vpc_id = "${data.aws_vpc.company.id}"

    tags ={
    Name = "EFS_SG"
 }
}

resource "aws_security_group_rule" "EFS_SG_INGRESS" {
  security_group_id = "${aws_security_group.EFS_SG.id}"
  description = "Allow Traffic From VPC Instances"
  type = "ingress"
  protocol = "tcp"
  to_port = "2049"
  from_port = "2049"
  source_security_group_id = "${data.aws_security_group.ecs_tasks_sg.id}"
}

resource "aws_security_group" "EFS_SG_new" {
  name   = "EFS_SG_new"
  vpc_id = "${data.aws_vpc.company.id}"
 
  ingress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_efs_mount_target" "FS_MOUNT" {
  file_system_id = "${aws_efs_file_system.FS.id}"
  subnet_id      ="${data.aws_subnet.private.id}"
  security_groups = ["${aws_security_group.EFS_SG_new.id}"]
}

resource "aws_efs_mount_target" "FS_MOUNT_ELASTIC" {
  file_system_id = "${aws_efs_file_system.FS_elastic.id}"
  subnet_id      ="${data.aws_subnet.private.id}"
  security_groups = ["${aws_security_group.EFS_SG_new.id}"]
}