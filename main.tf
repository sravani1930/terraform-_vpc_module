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
  count = length(var.public_subnet_cidr)
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

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
         var.common_tags,
         var.private_subnet_tags,
         {
            Name = "${local.name}-${local.az_names[count.index]}-private"
         }
  )
}

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
         var.common_tags,
         var.database_subnet_tags,
         {
            Name = "${local.name}-${local.az_names[count.index]}-database"
         }
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
         var.common_tags,
         var.gw_tags,
         {
            Name = local.name
         }
  
  )
}

resource "aws_eip" "eip" {
  domain           = "vpc"
  
}
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  tags =  merge(
         var.common_tags,
         var.nat_gateway_tags,
         {
            Name = local.name
         }
  )
  
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
   tags = merge(
         var.common_tags,
         var.public_route_table_tags,
         {
            Name = "${local.name}-public"
         }
   )
  }

  resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }
   tags = merge(
         var.common_tags,
         var.private_route_table_tags,
         {
            Name = "${local.name}-private"
         }
   )
  }

  resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }
   tags = merge(
         var.common_tags,
         var.database_route_table_tags,
         {
            Name = "${local.name}-database"
         }
   )
  }

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidr)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
}
