resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.domain_names[0]}"
  subject_alternative_names = "${slice(var.domain_names, 1, length(var.domain_names))}"
  validation_method = "DNS"

  tags = {
    Name = (var.type != "" ? "${var.name}-${var.type}" : var.name)
  }

  lifecycle {
    create_before_destroy = true
  }
}
