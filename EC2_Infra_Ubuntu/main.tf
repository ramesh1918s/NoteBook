provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "RM_Vpc" {
  cidr_block = var.vcp_cidr
  tags = {
    Name = "RM_Vpc"
  }
}

resource "aws_subnet" "RM_Sub1a" {
  vpc_id                  = aws_vpc.RM_Vpc.id
  cidr_block              = var.subnet1a_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "RM_Sub1a"
  }
}

resource "aws_subnet" "RM_Sub2b" {
  vpc_id                  = aws_vpc.RM_Vpc.id
  cidr_block              = var.subnet2b_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "RM_Sub2b"
  }
}

resource "aws_subnet" "RM_Sub3c" {
  vpc_id                  = aws_vpc.RM_Vpc.id
  cidr_block              = var.subnet3c_cidr
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "RM_Sub3c"
  }
}

resource "aws_internet_gateway" "RM_INGW" {
  vpc_id = aws_vpc.RM_Vpc.id
  tags = {
    Name = "RM_INGW"
  }
}

resource "aws_route_table" "RM_RT" {
  vpc_id = aws_vpc.RM_Vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RM_INGW.id
  }
  tags = {
    Name = "RM_RT"
  }
}

resource "aws_route_table_association" "subnet1a" {
  subnet_id      = aws_subnet.RM_Sub1a.id
  route_table_id = aws_route_table.RM_RT.id
}

resource "aws_route_table_association" "subnet2b" {
  subnet_id      = aws_subnet.RM_Sub2b.id
  route_table_id = aws_route_table.RM_RT.id
}

resource "aws_route_table_association" "subnet3c" {
  subnet_id      = aws_subnet.RM_Sub3c.id
  route_table_id = aws_route_table.RM_RT.id
}

resource "aws_security_group" "RM_SG" {
  vpc_id = aws_vpc.RM_Vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RM_SG"
  }
}

resource "aws_instance" "My_Server" {
  count                     = 3
  ami                       = var.ami_id
  instance_type             = var.instance_type
  subnet_id                 = aws_subnet.RM_Sub1a.id
  vpc_security_group_ids    = [aws_security_group.RM_SG.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "My_Server-${count.index}"
  }
}
