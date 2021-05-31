resource "aws_ecs_service" "this" {
  cluster                 = data.aws_ecs_cluster.selected.id
  desired_count           = var.desired_tasks
  launch_type             = "FARGATE"
  name                    = var.container_name
  task_definition         = aws_ecs_task_definition.this.arn
  enable_ecs_managed_tags = true

  lifecycle {
    ignore_changes = [desired_count]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.management.arn
    container_name   = var.container_name
    container_port   = 15672
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.rabbit.arn
    container_name   = var.container_name
    container_port   = 5672
  }

  #   load_balancer {
  #     target_group_arn = aws_lb_target_group.prometheus[0].arn
  #     container_name   = var.container_name
  #     container_port   = 15692
  #   }

  service_registries {
    registry_arn = aws_service_discovery_service.this.arn
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.this.id]
    subnets          = tolist(data.aws_subnet_ids.private.ids)
  }

  tags = {
    Product = var.app_name
  }

  depends_on = [aws_lb_target_group.management, aws_lb_target_group.rabbit]
}
