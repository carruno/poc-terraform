variable "app_name" {
  description = "Application name with environment"
  type        = string
}

variable "cloudwatch_log_group" {
  description = "Cloudwatch log group name"
  type        = string
}

variable "container_name" {
  description = "Name of the docker image"
  type        = string
}

variable "container_tag" {
  description = "Tag of the docker image"
  type        = string
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
  description = "Application domain registered as zone on route53"
  default     = ""
  type        = string
}

variable "min_tasks" {
  description = "Number of tasks to run"
  default     = 1
}

variable "max_tasks" {
  description = "Number of tasks to run"
  default     = 2
}

variable "desired_tasks" {
  description = "Desired tasks"
  default     = 1
}

variable "setup_dns" {
  description = "Setup dns if domain is available"
  default     = false
  type        = bool
}

variable "setup_prometheus" {
  description = "Setup rules to prometheus access the metrics"
  default     = false
  type        = bool
}

variable "registry_url" {
  description = "Your docker registry url"
  type        = string
}
