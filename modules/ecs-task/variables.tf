variable "allow_public_access" {
  description = "Allow public access on resource"
  default     = false
}

variable "app_name" {
  description = "Application name with environment"
  type        = string
}

variable "cloudwatch_name" {
  description = "Cloudwatch log group name"
  type        = string
}

variable "cluster_id" {
  description = "Cluster id"
  type        = string
}

variable "container_name" {
  description = "Name of the docker image"
  type        = string
}

variable "container_tag" {
  description = "ECR Registry for application image"
  type        = string
}

variable "container_port" {
  description = "ALB target port"
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

variable "health_check_url" {
  description = "Health check"
  type        = string
}

variable "iam_role_arn" {
  description = "Iam role arn for cluster"
  type        = string
}

variable "registry_url" {
  description = "Your docker registry url"
  type        = string
}

variable "vpc_id" {
  description = "Id of VPC"
  type        = string
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    Tier = "Private"
  }
}

data "aws_subnet" "private" {
  count = length(data.aws_subnet_ids.private.ids)
  id    = tolist(data.aws_subnet_ids.private.ids)[count.index]
}

data "aws_lb" "selected" {
  name = "${var.app_name}-${var.allow_public_access ? "external" : "internal"}-lb"
}

data "aws_security_group" "selected" {
  name = "${var.app_name}-${var.allow_public_access ? "external" : "internal"}-lb-sg"
}