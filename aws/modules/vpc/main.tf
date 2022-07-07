locals {
  vpc_id = try(aws_vpc.main[0].id, "")
}

####################################
# VPC
####################################

resource "aws_vpc" "main" {
  count            = var.create_vpc ? 1 : 0
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  tags = merge(
    {"Name" = "${var.name}"},
    var.tags,
  )
}

####################################
# Subnet
####################################

resource "aws_subnet" "main_public" {
  count             = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets)  : 0
  vpc_id            = local.vpc_id
  cidr_block        = element(concat(var.public_subnets, [""]), count.index)
  availability_zone = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "${var.name}-public-%s",
        element(var.azs, count.index),
      )
    },
    var.tags,
  )
}

resource "aws_subnet" "main_private" {
  count             = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets)  : 0
  vpc_id            = local.vpc_id
  cidr_block        = element(concat(var.private_subnets, [""]), count.index)
  availability_zone = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  tags = merge(
    {
      "Name" = format(
        "${var.name}-private-%s",
        element(var.azs, count.index),
      )
    },
    var.tags,
  )
}

####################################
# Internet Gateway
####################################

resource "aws_internet_gateway" "main" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    { "Name" = var.name },
    var.tags,
  )
}

####################################
# Route Table
####################################

resource "aws_route_table" "main_public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    { "Name" = "${var.name}-public" },
    var.tags,
  )
}

resource "aws_route" "main_public" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.main_public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id

  timeouts {
    create = "5m"
  }
}