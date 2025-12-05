variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "project_name" {
    default = ""
}

variable "environment" {
    default= ""
}

variable "enable_dns_hostnames" {
    default = true
}

variable "common_tags" {
    type = map
    default = {}
}

variable "vpc_tags" {
    type = map
    default = {}
}
