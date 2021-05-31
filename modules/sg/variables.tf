#############################
# Global
#############################

variable "sg_name" {
  type        = string
  description = "Name of the AWS Security Group"
}

#############################
# Enabled
#############################

variable "enabled" {
  type        = bool
  description = "Enable the creation of the Security Group"
  default     = true
}

#############################
# Network
#############################

variable "vpc_id" {
  type        = string
  description = "ID of the AWS VPC to create the AWS Security Group"
}

variable "vpc_cidr" {
  type        = string
  description = "ID of the AWS VPC to create the AWS Security Group"
  default     = ""
}

#############################
# Ingress Traffic
#############################

variable "ingress_tcp_ports" {
  type        = string
  description = "List of Ingress TCP ports separated by comma (80,443) that will be set as from/to ports"
  default     = "default_null"
}

variable "ingress_tcp_range_from" {
  type        = string
  description = "Start of the Ingress TCP ports range"
  default     = "default_null"
}

variable "ingress_tcp_range_to" {
  type        = string
  description = "End of the Ingress TCP ports range"
  default     = "default_null"
}

variable "ingress_udp_ports" {
  type        = string
  description = "List of Ingress UDP ports separated by comma (80,443) that will be set as from/to ports"
  default     = "default_null"
}

variable "ingress_udp_range_from" {
  type        = string
  description = "Start of the Ingress UDP ports range"
  default     = "default_null"
}

variable "ingress_udp_range_to" {
  type        = string
  description = "End of the Ingress UDP ports range"
  default     = "default_null"
}

variable "ingress_cidrs" {
  type    = list
  default = []
}

#############################
# Egress Traffic
#############################

variable "egress_tcp_ports" {
  type        = string
  description = "List of Egress TCP ports separated by comma (80,443) that will be set as from/to ports"
  default     = "default_null"
}

variable "egress_tcp_range_from" {
  type        = string
  description = "Start of the Egress TCP ports range"
  default     = "default_null"
}

variable "egress_tcp_range_to" {
  type        = string
  description = "End of the Egress TCP ports range"
  default     = "default_null"
}

variable "egress_udp_ports" {
  type        = string
  description = "List of Egress UDP ports separated by comma (80,443) that will be set as from/to ports"
  default     = "default_null"
}

variable "egress_udp_range_from" {
  type        = string
  description = "Start of the Egress UDP ports range"
  default     = "default_null"
}

variable "egress_udp_range_to" {
  type        = string
  description = "End of the Egress UDP ports range"
  default     = "default_null"
}

variable "egress_cidrs" {
  type    = list
  default = ["0.0.0.0/0"]
}

#############################
# ICMP (ping))
#############################

variable "enable_icmp" {
  type    = bool
  default = false
}

#############################
# NAT Gateway (for private subnet)
#############################

variable "is_private_subnet" {
  type    = bool
  default = false
}

#############################
# Tags
#############################

variable "tags" {
  type        = map(string)
  description = "Defaut tags to associate to these resources"
}
