
# main.tf
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}_VPC"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_az
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}_Public_Subnet_1"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.private_az_1
  tags = {
    Name = "${var.project_name}_Private_Subnet_1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.private_az_2
  tags = {
    Name = "${var.project_name}_Private_Subnet_2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}_IGW"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}_Public_RT"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id
  tags = {
    Name = "${var.project_name}_NATGW"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}_Private_RT"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "all_allow" {
  name        = "${var.project_name}_SG"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id

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
}

resource "aws_instance" "public_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_1.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.all_allow.id]
  associate_public_ip_address = true

  user_data = <<-EOF
            #!/bin/bash
            sudo apt update
            sudo apt install -y nginx
            sudo systemctl start nginx
            sudo systemctl enable nginx
            EOF
 


  tags = {
    Name = "${var.project_name}_EC2_Public"
  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_1.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.all_allow.id]

  tags = {
    Name = "${var.project_name}_EC2_Private"
  }
}





















































































































# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_vpc" "main" {
#   cidr_block = "194.36.0.0/16"
#   tags = {
#     Name = "AWS_CLI_VPC"
#   }
# }

# resource "aws_subnet" "public_1" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "194.36.0.0/20"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "AWS_CLI_Public_Subnet_1"
#   }
# }

# resource "aws_subnet" "private_1" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "194.36.16.0/20"
#   availability_zone = "us-east-1b"
#   tags = {
#     Name = "AWS_CLI_Private_Subnet_1"
#   }
# }

# resource "aws_subnet" "private_2" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "194.36.32.0/20"
#   availability_zone = "us-east-1c"
#   tags = {
#     Name = "AWS_CLI_Private_Subnet_2"
#   }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "AWS_CLI_IGW"
#   }
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "AWS_CLI_Public_RT"
#   }
# }

# resource "aws_route" "public_internet_access" {
#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# resource "aws_route_table_association" "public_1" {
#   subnet_id      = aws_subnet.public_1.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_eip" "nat" {
#   domain = "vpc"
# }

# resource "aws_nat_gateway" "natgw" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public_1.id
#   tags = {
#     Name = "AWS_CLI_NATGW"
#   }
#   depends_on = [aws_internet_gateway.igw]
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "AWS_CLI_Private_RT"
#   }
# }

# resource "aws_route" "private_nat_route" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.natgw.id
# }

# resource "aws_route_table_association" "private_1" {
#   subnet_id      = aws_subnet.private_1.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_route_table_association" "private_2" {
#   subnet_id      = aws_subnet.private_2.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_security_group" "all_allow" {
#   name        = "AWS_CLI_SG"
#   description = "Allow all traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_instance" "public_instance" {
#   ami                         = "ami-084568db4383264d4"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.public_1.id
#   key_name                    = "Qalb_Key"
#   vpc_security_group_ids      = [aws_security_group.all_allow.id]
#   associate_public_ip_address = true

#   tags = {
#     Name = "AWS_CLI_EC2_Public"
#   }
# }

# resource "aws_instance" "private_instance" {
#   ami                         = "ami-084568db4383264d4"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.private_1.id
#   key_name                    = "Qalb_Key"
#   vpc_security_group_ids      = [aws_security_group.all_allow.id]

#   tags = {
#     Name = "AWS_CLI_EC2_Private"
#   }
# }
# #