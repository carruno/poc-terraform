variable "availability_zones" {
  description = "AWS AVailability Zones"
  type        = list(any)
}

variable "enable_dns_hostnames" {
  default     = false
  description = "Indicates whether instances with public IP addresses get corresponding public DNS hostnames."
  type        = bool
}

variable "enable_dns_support" {
  default     = true
  description = "Indicates whether the DNS resolution is supported."
  type        = bool
}

variable "name" {
  description = "Application Name"
  type        = string
}

variable "public_start_ip" {
  description = "Start ip of public subnets"
  type        = string
}

variable "private_start_ip" {
  description = "Start ip of private subnets"
  type        = string
}

variable "subnet_prefix" {
  description = "Prefix for setup of subnets"
  type        = string
}

variable "tags" {
  type        = map(any)
  description = "A map with the tags to apply"
}

variable "vpc_cidr" {
  description = "CIDR of the VPC"
  type        = string
}
