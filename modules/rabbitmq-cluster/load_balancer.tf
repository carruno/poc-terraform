# Rabbit Management
resource "aws_lb_target_group" "management" {
  name        = "${var.app_name}-rabbitmq-mg-lb-tg"
  port        = 15672
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.selected.id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    matcher  = "200"
    path     = "/"
    port     = 15672
    timeout  = 30
    interval = 40
  }

  tags = {
    Product = var.app_name
  }

  depends_on = [data.aws_lb.external]
}

resource "aws_lb_listener" "management" {
  load_balancer_arn = data.aws_lb.external.arn
  port              = 15672
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.management.arn
  }
}

resource "aws_lb_listener_rule" "http" {
  listener_arn = aws_lb_listener.management.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.management.arn
  }
  condition {
    host_header {
      values = [local.url]
    }
  }
}

# Management access on HTTPS
# resource "aws_lb_listener_rule" "https" {
#   listener_arn = data.aws_lb_listener.selected443.arn

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.management.arn
#   }

#   condition {
#     host_header {
#       values = [local.url]
#     }
#   }
# }

# Rabbit Prometheus metrics
resource "aws_lb_target_group" "prometheus" {
  count       = var.setup_prometheus ? 1 : 0
  name        = "${var.app_name}-rabbit-pro-lb-tg"
  port        = 15692
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.selected.id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    matcher  = "200"
    path     = "/metrics"
    port     = 15692
    timeout  = 30
    interval = 40
  }

  tags = {
    Product = var.app_name
  }

  depends_on = [data.aws_lb.internal]
}


resource "aws_lb_listener" "prometheus" {
  count             = var.setup_prometheus ? 1 : 0
  load_balancer_arn = data.aws_lb.internal.arn
  port              = 15692
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prometheus[0].arn
  }
}
