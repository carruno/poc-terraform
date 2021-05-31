variable "app_name" {
  description = "Application name with environment"
  type        = string
}

variable "cloudwatch_name" {
  description = "Cloudwatch log group name"
  type        = string
}

variable "desired_tasks" {
  description = "Number of tasks to run"
  default     = 1
}

variable "desired_task_cpu" {
  description = "Task CPU Limit"
  default     = 1024
}

variable "desired_task_memory" {
  description = "Task Memory Limit"
  default     = 2048
}

variable "domain" {
  description = "Product domain"
  type        = string
}

variable "image_url" {
  description = "Rabbit mq custom image url"
  default     = "rabbitmq:3-management"
  type        = string
}

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
  count = length(data.aws_subnet_ids.private.ids)
  id    = tolist(data.aws_subnet_ids.private.ids)[count.index]
}

data "aws_lb" "external" {
  name = "${var.app_name}-external-lb"
}

data "aws_security_group" "external" {
  name = "${var.app_name}-external-lb-sg"
}

data "aws_lb" "internal" {
  name = "${var.app_name}-internal-lb"
}

data "aws_security_group" "internal" {
  name = "${var.app_name}-internal-lb-sg"
}

locals {
  url          = "rabbit.${var.domain}"
  internal_url = "rabbit.internal.${var.domain}"
}

data "aws_lb_listener" "selected443" {
  load_balancer_arn = data.aws_lb.external.arn
  port              = 443
}

data "aws_ecs_cluster" "selected" {
  cluster_name = "${var.app_name}-ecs-cluster"
}

data "aws_iam_role" "selected" {
  name = "${var.app_name}-ecs-task-role"
}

data "aws_route53_zone" "selected" {
  name = var.domain
}
