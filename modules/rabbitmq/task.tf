locals {
  service_name = "rabbitmq"
}

data "template_file" "this" {
  template = file("${path.module}/task-definitions/task.json")

  vars = {
    image               = "${var.image_url}"
    log_group           = var.cloudwatch_name
    desired_task_cpu    = var.desired_task_cpu
    desired_task_memory = var.desired_task_memory
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}-${local.service_name}"
  container_definitions    = data.template_file.this.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_memory
  execution_role_arn       = data.aws_iam_role.selected.arn
  task_role_arn            = data.aws_iam_role.selected.arn
  tags = {
    Product = var.app_name
  }
}

resource "aws_ecs_service" "this" {
  name                    = local.service_name
  task_definition         = aws_ecs_task_definition.this.arn
  cluster                 = data.aws_ecs_cluster.selected.id
  launch_type             = "FARGATE"
  desired_count           = 1
  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"

  network_configuration {
    security_groups  = [aws_security_group.this.id]
    subnets          = tolist(data.aws_subnet_ids.private.ids)
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.management.arn
    container_name   = local.service_name
    container_port   = 15672
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.prometheus.arn
    container_name   = local.service_name
    container_port   = 15692
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.rabbit.arn
    container_name   = local.service_name
    container_port   = 5672
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = {
    Product = var.app_name
  }

  depends_on = [aws_lb_target_group.management, aws_lb_target_group.rabbit, aws_lb_target_group.prometheus]
}
