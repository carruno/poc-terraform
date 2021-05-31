resource "aws_lb_target_group" "this" {
  name = "${var.app_name}-${var.container_name}-lb-tg"
  port = var.container_port
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"
  lifecycle {
    create_before_destroy = true
  }

 health_check {
    matcher             = "200"
    path                = var.health_check_url
    port                = var.container_port
    timeout             = 30
    interval            = 40
  }

  depends_on = [data.aws_lb.selected]


  tags = {
    Product = var.app_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = data.aws_lb.selected.arn
  port = var.container_port
  protocol = "HTTP"
  default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.this.arn
  }
}
