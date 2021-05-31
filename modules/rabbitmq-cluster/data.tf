data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["VPC_${upper(replace(var.app_name, "-", "_"))}"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Tier = "Private"
  }
}

data "aws_subnet" "private" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value
}

data "aws_lb" "external" {
  name = "${var.app_name}-external-lb"
}

data "aws_lb" "internal" {
  name = "${var.app_name}-internal-lb"
}

data "aws_security_group" "external" {
  name = "${var.app_name}-external-lb-sg"
}

data "aws_security_group" "internal" {
  name = "${var.app_name}-internal-lb-sg"
}

# data "aws_security_group" "prometheus" {
#     name = "${var.app_name}-prometheus-sg"
# }

data "aws_ecs_cluster" "selected" {
  cluster_name = "${var.app_name}-ecs-cluster"
}

data "aws_iam_role" "selected" {
  name = "${var.app_name}-ecs-task-role"
}

data "aws_region" "selected" {}

data "aws_lb_listener" "selected443" {
  load_balancer_arn = data.aws_lb.external.arn
  port              = 443
}

data "aws_route53_zone" "selected" {
  name = var.domain
}