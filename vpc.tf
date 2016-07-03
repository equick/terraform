# VPC
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc-cidr}"
    enable_dns_hostnames = true
}

# Internet Gateway
resource "aws_internet_gateway" "default" {
        vpc_id = "${aws_vpc.default.id}"
}

# Public subnets
resource "aws_subnet" "eu-west-1a-public" {
        vpc_id = "${aws_vpc.default.id}"
        cidr_block = "${var.eu-west-1a-public-cidr}"
        availability_zone = "eu-west-1a"
}

resource "aws_subnet" "eu-west-1b-public" {
        vpc_id = "${aws_vpc.default.id}"
        cidr_block = "${var.eu-west-1b-public-cidr}"
        availability_zone = "eu-west-1b"
}

# Routing table for public subnets
resource "aws_route_table" "eu-west-1-public" {
        vpc_id = "${aws_vpc.default.id}"
        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = "${aws_internet_gateway.default.id}"
        }
}

resource "aws_route_table_association" "eu-west-1a-public" {
        subnet_id = "${aws_subnet.eu-west-1a-public.id}"
        route_table_id = "${aws_route_table.eu-west-1-public.id}"
}

resource "aws_route_table_association" "eu-west-1b-public" {
        subnet_id = "${aws_subnet.eu-west-1b-public.id}"
        route_table_id = "${aws_route_table.eu-west-1-public.id}"
}

