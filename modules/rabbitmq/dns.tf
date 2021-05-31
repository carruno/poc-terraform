resource "aws_route53_record" "this" {
    zone_id = data.aws_route53_zone.selected.id
    name= local.url
    type = "A"
    alias {
        name = data.aws_lb.external.dns_name
        zone_id = data.aws_lb.external.zone_id
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "internal" {
    zone_id = data.aws_route53_zone.selected.id
    name= local.internal_url
    type = "A"
    alias {
        name = aws_lb.network.dns_name
        zone_id = aws_lb.network.zone_id
        evaluate_target_health = true
    }
}