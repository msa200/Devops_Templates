resource "aws_lb" "company" {
  name               = "company"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb.id}"]
  subnets            = ["${aws_subnet.public.id}","${aws_subnet.public2.id}"]

 }
 
resource "aws_lb" "frontend" {
  name               = "front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb.id}"]
  subnets            = ["${aws_subnet.public.id}","${aws_subnet.public2.id}"]

 }
 

