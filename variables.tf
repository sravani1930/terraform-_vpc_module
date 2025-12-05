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

variable "public_subnet_cidr" {
    type = list 
    validation {
    condition     = length(var.public_subnet_cidr) == 2
    error_message = "The list must contain exactly 2 elements."
  }

   
}

