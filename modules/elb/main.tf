resource "aws_lb" "this" {
  #enable_deletion_protection = true
  internal                   = var.internal
  load_balancer_type         = "application"
  name                       = var.internal ? "${var.name}-internal-lb" : "${var.name}-external-lb"
  security_groups            = [aws_security_group.this.id]
  subnets                    = tolist(data.aws_subnet_ids.this.ids)
  #access_logs {
  #  bucket  = var.log_bucket_name
  #  enabled = true
  #  prefix  = "${var.name}-${var.internal ? "internal" : "external"}"
  #}
  tags = {
    Product = var.name
  }
}

resource "aws_lb_listener" "http" {
  count             = var.internal ? 0 : 1
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
