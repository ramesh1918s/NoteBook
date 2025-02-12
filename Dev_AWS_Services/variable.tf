variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true  # Mark as sensitive
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true  # Mark as sensitive
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "Public subnet 1 CIDR block"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "Public subnet 2 CIDR block"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "rds_username" {
  description = "RDS MySQL username"
  type        = string
}

variable "rds_password" {
  description = "RDS MySQL password"
  type        = string
}

variable "aws_region_a" {
  description = "AWS Availability Zone for the first subnet"
  type        = string
}

variable "aws_region_b" {
  description = "AWS Availability Zone for the second subnet"
  type        = string
}
