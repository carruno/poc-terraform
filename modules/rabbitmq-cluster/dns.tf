# Management
resource "aws_route53_record" "this" {
  count   = var.setup_dns ? 1 : 0
  zone_id = data.aws_route53_zone.selected.id
  name    = local.url
  type    = "A"
  alias {
    name                   = data.aws_lb.external.dns_name
    zone_id                = data.aws_lb.external.zone_id
    evaluate_target_health = true
  }
}
# Prometheus
resource "aws_route53_record" "internal" {
  count   = var.setup_dns ? 1 : 0
  zone_id = data.aws_route53_zone.selected.id
  name    = local.internal
  type    = "A"
  alias {
    name                   = data.aws_lb.internal.dns_name
    zone_id                = data.aws_lb.internal.zone_id
    evaluate_target_health = true
  }
}
# AMQP
resource "aws_route53_record" "amqp" {
  count   = var.setup_dns ? 1 : 0
  zone_id = data.aws_route53_zone.selected.id
  name    = local.amqp
  type    = "A"
  alias {
    name                   = aws_lb.network.dns_name
    zone_id                = aws_lb.network.zone_id
    evaluate_target_health = true
  }
}
