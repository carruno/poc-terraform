output "cloudwatch_name" {
    value = aws_cloudwatch_log_group.this.name
}

output "cluster_id" {
    value = aws_ecs_cluster.this.id
}

output "iam_role_arn" {
    value = aws_iam_role.ecs_execution_role.arn
}
