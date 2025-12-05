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
variable "public_subnet_tags" {
    type = map 
    default = {}
}

variable "private_subnet_cidr" {
    type = list 
    validation {
    condition     = length(var.private_subnet_cidr) == 2
    error_message = "The list must contain exactly 2 elements."
  }

   
}
variable "private_subnet_tags" {
    type = map 
    default = {}
}

variable "database_subnet_cidr" {
    type = list 
    validation {
    condition     = length(var.database_subnet_cidr) == 2
    error_message = "The list must contain exactly 2 elements."
  }

   
}
variable "database_subnet_tags" {
    type = map 
    default = {}
}

variable "gw_tags" {
    type = map 
    default = {}

}
variable "nat_gateway_tags" {
  type = map 
  default = {}

}

         
variable "public_route_table_tags" {
    type = map 
    default = {}
}

variable "private_route_table_tags" {
    type = map 
    default = {}
}

variable "database_route_table_tags" {
    type = map 
    default = {}
}

variable "is_peering_required" {
    type = bool
    default = false
}


variable "acceptor_vpc_id" {
    default = ""
}

variable "peering_tags" {
    default = ""
}