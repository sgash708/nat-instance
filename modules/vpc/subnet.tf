resource "aws_subnet" "publics" {
  count = var.num_subnet

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr, 8, count.index + 1)

  tags = {
    "Name" = "${var.application_name}-public-${reverse(split("-", data.aws_availability_zones.available.names[count.index]))[0]}"
  }
}

resource "aws_subnet" "privates" {
  count = var.num_subnet

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr, 8, (count.index + 1) * 10)

  tags = {
    "Name" = "${var.application_name}-private-${reverse(split("-", data.aws_availability_zones.available.names[count.index]))[0]}"
  }
}

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = local.internet_cidr
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    "Name" = "${var.application_name}-public-rt"
  }
}

resource "aws_route_table" "privates" {
  count = var.num_subnet

  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${var.application_name}-private-rt-${reverse(split("-", data.aws_availability_zones.available.names[count.index]))[0]}"
  }
}

resource "aws_route_table_association" "publics" {
  count = var.num_subnet

  subnet_id      = aws_subnet.publics[count.index].id
  route_table_id = aws_default_route_table.main.default_route_table_id
}

resource "aws_route_table_association" "privates" {
  count = var.num_subnet

  subnet_id      = aws_subnet.privates[count.index].id
  route_table_id = aws_route_table.privates[count.index].id
}

resource "aws_route" "privates" {
  count = var.num_subnet

  route_table_id         = aws_route_table.privates[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = var.nat_instance_id
}
