data "template_file" "this" {
  template = file("${path.module}/task-definitions/task.json")

  vars = {
    image          = "${var.registry_url}/${var.container_name}:${var.container_tag}"
    container_name = var.container_name
    log_group      = var.cloudwatch_log_group
    region         = data.aws_region.selected.name
  }
}

resource "aws_ecs_task_definition" "this" {
  container_definitions    = data.template_file.this.rendered
  cpu                      = var.desired_task_cpu
  execution_role_arn       = data.aws_iam_role.selected.arn
  family                   = "${var.app_name}-${var.container_name}"
  memory                   = var.desired_task_memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = data.aws_iam_role.selected.arn
  tags = {
    Product = var.app_name
  }
}
