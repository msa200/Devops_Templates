resource "aws_alb_target_group" "webapp" {
  name        = "webapp"
  port        = input
  protocol    = "HTTP"
  vpc_id      = "${data.aws_vpc.company.id}"
  target_type = "ip"
  
    health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "302"
    timeout = "15"
    path = "/"
    unhealthy_threshold = "2"
  }
}

 
resource "aws_alb_listener" "http" {
  load_balancer_arn = "${data.aws_lb.company.arn}"
  port              = 80
  protocol          = "HTTP"

 
  default_action {
    target_group_arn = "${aws_alb_target_group.webapp.arn}"
    type             = "forward"
  }
}
resource "aws_lb_listener" "https" {
  load_balancer_arn = "${data.aws_lb.company.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "input"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.webapp.arn}"
  }
}
