# Cluster Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.name}-ecs-task-role"
  assume_role_policy = file("${path.module}/policies/ecs-task-execution-role.json")
}

# Cluster Execution Policy
resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "${var.name}-role-policy"
  policy = file("${path.module}/policies/ecs-execution-role-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}

