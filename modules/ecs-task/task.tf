data "template_file" "this" {
  template = file("${path.module}/task-definitions/task.json")

  vars = {
    image                   = "${var.registry_url}/${var.container_name}:${var.container_tag}"
    container_name          = var.container_name
    container_port          = var.container_port
    log_group               = var.cloudwatch_name
    desired_task_cpu        = var.desired_task_cpu
    desired_task_memory     = var.desired_task_memory
  }
}

resource "aws_ecs_task_definition" "this" {
  family                    = var.container_name
  container_definitions     = data.template_file.this.rendered
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = var.desired_task_cpu
  memory                    = var.desired_task_memory
  execution_role_arn        = var.iam_role_arn
  task_role_arn             = var.iam_role_arn
}

resource "aws_ecs_service" "this" {
  name            = var.container_name
  task_definition = aws_ecs_task_definition.this.arn
  cluster         = var.cluster_id
  launch_type     = "FARGATE"
  desired_count   = var.desired_tasks

  network_configuration {
    security_groups  = [aws_security_group.this.id]
    subnets          = tolist(data.aws_subnet_ids.private.ids)
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  
  lifecycle {
    ignore_changes = [desired_count]
  }  

  depends_on = [aws_lb_target_group.this]
}
