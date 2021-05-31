resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "discovery.rabbitmq"
  description = "Rabbitmq dns"
  vpc         = data.aws_vpc.selected.id
}

resource "aws_service_discovery_service" "this" {
  name = "nodes"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id
    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
}
