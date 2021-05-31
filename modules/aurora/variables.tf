variable "app_name" {
  description = "Product Name"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "backup_retention_period" {
  description = "Backup retention period"
  type        = number
}

variable "db_port" {
  description = "Database port"
  type        = number
}

variable "engine_type" {
  # aurora | aurora-mysql | aurora-postgres
  description = "RDS Aurora serverless engine type"
  type        = string
}

variable "engine_version" {
  description = "RDS Aurora engine version"
  type        = string
}

variable "instance_class" {
  description = "RDS Aurora instance class"
  type        = string
}

variable "instances_amount" {
  description = "Amound of instances for aurora serverless cluster"
  type        = number
}

variable "master_db_user" {
  description = "Master db user name"
  type        = string
}

variable "scaling_max_capacity" {
  description = "Maximum value for auto scaling of aurora"
  type        = number
  default     = 4
}

variable "scaling_min_capacity" {
  description = "Minimum value for auto scaling of aurora"
  type        = number
  default     = 2
}
