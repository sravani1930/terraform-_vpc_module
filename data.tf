data "aws_availability_zones" "azs" {
  #all_availability_zones = true
  state = "available"
}

data "aws_vpc" "default" {
   default = true
}

# data "aws_vpc" "main" {
#   value = aws_vpc.main.id
# }