##################################################################################
# DATA
##################################################################################

#data "aws_ssm_parameter" "ubuntu_noble" {
#  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
#}

# data "http" "myip" {
#   url = "http://api.ipify.org"
# }

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "myapp" {
  cidr_block           = "10.255.0.0/16"
  enable_dns_hostnames = true

  tags = local.vpc_tags

}

resource "aws_internet_gateway" "myapp" {
  vpc_id = aws_vpc.myapp.id

  tags = local.igw_tags

}

resource "aws_subnet" "front_sub1" {
  cidr_block              = "10.255.1.0/24"
  vpc_id                  = aws_vpc.myapp.id
  map_public_ip_on_launch = true
  availability_zone = "ap-southeast-1a"

  tags = local.front_sub1_tags

}

# resource "aws_subnet" "front_sub2" {
#   cidr_block              = "10.255.2.0/24"
#   vpc_id                  = aws_vpc.myapp.id
#   map_public_ip_on_launch = true
#   availability_zone = "ap-southeast-1b"

#   tags = local.front_sub2_tags

# }

# resource "aws_subnet" "app_sub1" {
#   cidr_block              = "10.255.3.0/24"
#   vpc_id                  = aws_vpc.myapp.id
#   map_public_ip_on_launch = false
#   availability_zone = "ap-southeast-1a"

#   tags = local.app_sub1_tags

# }

# resource "aws_subnet" "app_sub2" {
#   cidr_block              = "10.255.4.0/24"
#   vpc_id                  = aws_vpc.myapp.id
#   map_public_ip_on_launch = false
#   availability_zone = "ap-southeast-1b"

#   tags = local.app_sub2_tags

# }

# resource "aws_subnet" "db_sub1" {
#   cidr_block              = "10.255.5.0/24"
#   vpc_id                  = aws_vpc.myapp.id
#   map_public_ip_on_launch = false
#   availability_zone = "ap-southeast-1a"

#   tags = local.db_sub1_tags

# }

# resource "aws_subnet" "db_sub2" {
#   cidr_block              = "10.255.6.0/24"
#   vpc_id                  = aws_vpc.myapp.id
#   map_public_ip_on_launch = false
#   availability_zone = "ap-southeast-1b"

#   tags = local.db_sub2_tags

# }

# ROUTING #
resource "aws_route_table" "myapp" {
  vpc_id = aws_vpc.myapp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp.id
  }

  tags = local.igw_rt_tags

}

# resource "aws_route_table" "natgw1" {
#   vpc_id = aws_vpc.myapp.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.app_nat1.id
#   }

#   tags = local.natgw1_rt_tags

# }

# resource "aws_route_table" "natgw2" {
#   vpc_id = aws_vpc.myapp.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.app_nat2.id
#   }

#   tags = local.natgw2_rt_tags

# }

resource "aws_route_table_association" "front_sub1" {
  subnet_id      = aws_subnet.front_sub1.id
  route_table_id = aws_route_table.myapp.id
}

# resource "aws_route_table_association" "front_sub2" {
#   subnet_id      = aws_subnet.front_sub2.id
#   route_table_id = aws_route_table.myapp.id
# }

# resource "aws_route_table_association" "app_sub1" {
#   subnet_id      = aws_subnet.app_sub1.id
#   route_table_id = aws_route_table.natgw1.id
# }

# resource "aws_route_table_association" "app_sub2" {
#   subnet_id      = aws_subnet.app_sub2.id
#   route_table_id = aws_route_table.natgw2.id
# }

# resource "aws_eip" "nat_gw1" {
#     domain = "vpc"
#     tags = local.eip1_tags
# }

# resource "aws_eip" "nat_gw2" {
#     domain = "vpc"
#     tags = local.eip2_tags
# }

# NAT GW
# resource "aws_nat_gateway" "app_nat1" {
#     subnet_id = aws_subnet.app_sub1.id
#     allocation_id = aws_eip.nat_gw1.id
#     tags = local.natgw1_tags
# }

# resource "aws_nat_gateway" "app_nat2" {
#     subnet_id = aws_subnet.app_sub2.id
#     allocation_id = aws_eip.nat_gw2.id
#     tags = local.natgw2_tags
# }

# SECURITY GROUPS #
# Nginx security group
resource "aws_security_group" "web_server_sg" {
  name   = "web_server_sg"
  vpc_id = aws_vpc.myapp.id

  # HTTP access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.response_body}/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags

}