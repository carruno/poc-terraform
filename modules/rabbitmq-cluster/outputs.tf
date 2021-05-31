output "amqp_url" {
    value = aws_route53_record.amqp[0].name
}