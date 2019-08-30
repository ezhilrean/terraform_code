# Define our VPC
resource "aws_vpc" "infra_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_classiclink = "false"
  tags = {
  Name = "test-vpc"
}
}

# Define the public subnet1
resource "aws_subnet" "public-subnet1" {
  vpc_id = "${aws_vpc.infra_vpc.id}"
  cidr_block = "${var.public1_subnet_cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2a"

  tags = {
  Name = "Web Public Subnet1"
  }
}


# Define the public subnet2
resource "aws_subnet" "public-subnet2" {
  vpc_id = "${aws_vpc.infra_vpc.id}"
  map_public_ip_on_launch = "true"
  cidr_block = "${var.public2_subnet_cidr}"
  availability_zone = "us-west-2b"

  tags = {
  Name = "Web Public Subnet2"
  }
}

# Define the private subnet1
resource "aws_subnet" "private-subnet1" {
  vpc_id = "${aws_vpc.infra_vpc.id}"
  cidr_block = "${var.db_subnet1_cidr}"
  availability_zone = "us-west-2a"

  tags = {
  Name = "Database Private Subnet1"
  }
}


# Define the private subnet2
resource "aws_subnet" "private-subnet2" {
  vpc_id = "${aws_vpc.infra_vpc.id}"
  cidr_block = "${var.db_subnet2_cidr}"
  availability_zone = "us-west-2c"

  tags = {
  Name = "Database Private Subnet2"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.infra_vpc.id}"

  tags = {
  Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.infra_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
  Name = "Public Subnet RT"
  }
}

resource "aws_route_table_association" "web-public-rt-1a" {
    subnet_id = "${aws_subnet.public-subnet1.id}"
    route_table_id = "${aws_route_table.web-public-rt.id}"
}

resource "aws_route_table_association" "web-public-rt-1b" {
    subnet_id = "${aws_subnet.public-subnet2.id}"
    route_table_id = "${aws_route_table.web-public-rt.id}"
}



