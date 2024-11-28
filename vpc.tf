resource "aws_vpc" "terravpc" {
  cidr_block = var.block1
  tags = {
    Name = var.vpcname
  }
}

resource "aws_subnet" "pubsub01" {
  vpc_id                  = aws_vpc.terravpc.id
  cidr_block              = var.block2
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.pubsub01
  }
}

resource "aws_subnet" "pubsub02" {
  vpc_id                  = aws_vpc.terravpc.id
  cidr_block              = var.block3
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = var.pubsub02
  }
}

resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terravpc.id
  tags = {
    Name = "Terra_IGW"
  }
}

resource "aws_route_table" "terra_rt_1" {
  vpc_id = aws_vpc.terravpc.id

  route {
    cidr_block = var.block4
    gateway_id = aws_internet_gateway.terra_igw.id
  }
  tags = {
    Name = "Terra_RT"
  }
}

resource "aws_route_table_association" "routeassociate1" {
  route_table_id = aws_route_table.terra_rt_1.id
  subnet_id      = aws_subnet.pubsub01.id
}

resource "aws_route_table_association" "routeassociate2" {
  route_table_id = aws_route_table.terra_rt_1.id
  subnet_id      = aws_subnet.pubsub02.id
}