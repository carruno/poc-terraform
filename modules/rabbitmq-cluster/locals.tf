locals {
  url          = "rabbit.${var.domain}"
  amqp         = "rabbit.amqp.${var.domain}"
  internal = "rabbit.internal.${var.domain}"
}
