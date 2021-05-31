resource "aws_ecs_cluster" "this" {
    name = "${var.name}-ecs-cluster"
    tags = {
      Product = var.name
    }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${var.name}-logs"

  tags = {
    Product = var.name
  }
}
