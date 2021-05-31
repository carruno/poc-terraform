variable "internal" {
  description = "Set if load balancer is internal or external"
  default     = false
  type        = bool
}

variable "log_bucket_name" {
  description = "Name of the bucket to log elb events"
  type        = string
}

variable "name" {
  description = "Application name"
  type        = string
}

variable "domain" {
  description = "Domain/Url of the application"
  type        = string
  default     = ""
}

variable "from_port" {
  description = "Initial port to allow access"
  type        = string
  default     = 80
}

variable "to_port" {
  description = "End port to allow access"
  type        = string
  default     = 80
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "zone_id" {
  description = "Dns zone id"
  type        = string
  default     = ""
}

data "aws_subnet_ids" "this" {
  vpc_id = var.vpc_id

  tags = {
    Tier = var.internal ? "Private" : "Public"
  }
}

data "aws_subnet" "this" {
  count = length(data.aws_subnet_ids.this.ids)
  id    = tolist(data.aws_subnet_ids.this.ids)[count.index]
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}
