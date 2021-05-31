resource "aws_lb" "network" {
  name               = "${var.app_name}-network-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = tolist(data.aws_subnet_ids.private.ids)

  enable_deletion_protection = false

  tags = {
    Product = var.app_name
  }
}

resource "aws_lb_target_group" "rabbit" {
  name        = "${var.app_name}-rabbitmq-lb-tg"
  port        = 5672
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.selected.id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }

  depends_on = [aws_lb.network]
}

resource "aws_lb_listener" "rabbit" {
  load_balancer_arn = aws_lb.network.arn
  port              = 5672
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rabbit.arn
  }
}
