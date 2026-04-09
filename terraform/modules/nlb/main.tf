resource "aws_lb" "this" {
  name               = "tomcat-nlb"
  load_balancer_type = "network"
  subnets            = var.public_subnets
}

resource "aws_lb_target_group" "this" {
  name        = "tomcat-tg"
  port        = 8443
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

