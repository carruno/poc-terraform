variable "domain_names" {
    description = "Domain of the application"
    type        = list
}

variable "name" {
    description = "App name"
    type        = string
}

variable "type" {
    description = "Api or Static"
    type        = string
}
