resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  
  tags = merge(
         var.common_tags,
         var.vpc_tags,
         {

           Name = local.tags
         }
  )
}

resource "aws_subnet" "public" {
  count = length(slice(output.azs,0,2))
  vpc_id     = output.vpc_id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}
