resource "aws_route53_zone" "main" {
  name = var.root_domain_name
}

resource "aws_route53_zone" "dev" {
  name = "dev.${var.root_domain_name}"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.dev.name
  type    = "NS"
  ttl     = "30"

  records = [
    aws_route53_zone.dev.name_servers.0,
    aws_route53_zone.dev.name_servers.1,
    aws_route53_zone.dev.name_servers.2,
    aws_route53_zone.dev.name_servers.3,
  ]
}

resource "aws_route53_zone" "stg" {
  name = "stg.${var.root_domain_name}"

  tags = {
    Environment = "stg"
  }
}

resource "aws_route53_record" "stg-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.stg.name
  type    = "NS"
  ttl     = "30"

  records = [
    aws_route53_zone.stg.name_servers.0,
    aws_route53_zone.stg.name_servers.1,
    aws_route53_zone.stg.name_servers.2,
    aws_route53_zone.stg.name_servers.3,
  ]
}
