resource "aws_security_group" "rds" {
  name   = "rds-sg"
  vpc_id = "${aws_vpc.company.id}"
 
  ingress {
   protocol         = "tcp"
   from_port        = 5432
   to_port          = 5432
   cidr_blocks      = ["10.1.1.0/24"]
  }

 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["10.1.1.0/24"]
  }
}