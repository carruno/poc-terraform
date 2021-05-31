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

# Setup load balancer for prometheus metrics
resource "aws_lb_target_group" "prometheus" {
  name        = "${var.app_name}-rabbitmq-prom-lb-tg"
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

  depends_on = [data.aws_lb.external]
}

resource "aws_lb_listener_rule" "prometheus" {
  listener_arn = data.aws_lb_listener.selected443.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prometheus.arn
  }

  condition {
    host_header {
      values = [local.url]
    }
  }

  condition {
    path_pattern {
      values = ["/metrics"]
    }
  }
}

resource "aws_lb_listener_rule" "management" {
  listener_arn = data.aws_lb_listener.selected443.arn

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
