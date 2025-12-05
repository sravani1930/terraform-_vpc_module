output "vpc_id" {
    value = aws_vpc.main.id
}

output "azs" {
    value = data.aws_availability_zones.azs.names
}

output "default" {
    value = data.aws_vpc.default.id
}