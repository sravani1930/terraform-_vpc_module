variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "vpc_tags" {
    default = {
        Name = "roboshop-dev"
    }
}