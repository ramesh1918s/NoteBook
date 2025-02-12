# Provider Configuration
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key  # Avoid hardcoding; consider using environment variables or the AWS credentials file
  secret_key = var.aws_secret_key
}

# VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Dev_VPC"
  }
}

# Public Subnets
resource "aws_subnet" "dev_public_sub_1" {
  vpc_id                 = aws_vpc.dev_vpc.id
  cidr_block             = var.public_subnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone      = var.aws_region_a
  tags = {
    Name = "Dev_Public_Sub_1"
  }
}

resource "aws_subnet" "dev_public_sub_2" {  # Second public subnet in a different AZ
  vpc_id                 = aws_vpc.dev_vpc.id
  cidr_block             = var.public_subnet_2_cidr
  map_public_ip_on_launch = true
  availability_zone      = var.aws_region_b
  tags = {
    Name = "Dev_Public_Sub_2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "Dev_IGW"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }
  tags = {
    Name = "Dev_Public_RT"
  }
}

resource "aws_route_table_association" "dev_public_rt_association" {
  subnet_id      = aws_subnet.dev_public_sub_1.id
  route_table_id = aws_route_table.dev_public_rt.id
}

# S3 Bucket
resource "aws_s3_bucket" "dev_bucket" {
  bucket = "dev-s3-bucket-${var.aws_region}"
  tags = {
    Name = "Dev_S3_Bucket"
  }
}

# ECR Repository
resource "aws_ecr_repository" "dev_ecr" {
  name = "dev-ecr-repository"
  tags = {
    Name = "Dev_ECR"
  }
}

# ECS Cluster
resource "aws_ecs_cluster" "dev_ecs" {
  name = "Dev_ECS_Cluster"
}

# IAM Role for EKS Cluster
resource "aws_iam_role" "dev_eks_role" {
  name = "dev_eks_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "Dev_EKS_Role"
  }
}

# EKS Cluster
resource "aws_eks_cluster" "dev_eks" {
  name     = "Dev_EKS_Cluster"
  role_arn = aws_iam_role.dev_eks_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.dev_public_sub_1.id,
      aws_subnet.dev_public_sub_2.id
    ]
  }

  tags = {
    Name = "Dev_EKS_Cluster"
  }
}

# Elastic IP
resource "aws_eip" "dev_eip" {
  tags = {
    Name = "Dev_EIP"
  }
}

# RDS MySQL
resource "aws_db_instance" "dev_rds_mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.rds_username
  password             = var.rds_password
  publicly_accessible  = false  # If you want internal access, leave this false
  vpc_security_group_ids = [aws_security_group.dev_rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.dev_db_subnet_group.name

  tags = {
    Name = "Dev_RDS_MySQL"
  }
}

resource "aws_db_subnet_group" "dev_db_subnet_group" {
  name       = "dev-db-subnet-group"
  subnet_ids = [aws_subnet.dev_public_sub_1.id, aws_subnet.dev_public_sub_2.id]
  tags = {
    Name = "Dev_DB_Subnet_Group"
  }
}

# Security Group for RDS
resource "aws_security_group" "dev_rds_sg" {
  vpc_id = aws_vpc.dev_vpc.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Internal VPC range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dev_RDS_SG"
  }
}

# Security Group for EC2
resource "aws_security_group" "dev_ec2_sg" {
  vpc_id = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dev_EC2_SG"
  }
}

# EC2 Instance
resource "aws_instance" "dev_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.dev_public_sub_1.id
  key_name      = var.key_name  # Ensure this references an existing key pair

  vpc_security_group_ids = [aws_security_group.dev_ec2_sg.id]

  # User Data to run commands on instance launch
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Dev_Server"
  }
}

# Elastic IP Association
resource "aws_eip_association" "dev_eip_association" {
  instance_id = aws_instance.dev_server.id
  allocation_id = aws_eip.dev_eip.id
}
