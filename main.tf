resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  
  tags = merge(
         var.common_tags,
         var.vpc_tags,
         {

           Name = local.name
         }
  )
}

resource "aws_subnet" "public" {
  count = var.public_subnet_cidr
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
         var.common_tags,
         var.public_subnet_tags,
         {
            Name = "${local.name}-${local.az_names[count.index]}-public"
         }
  )
}