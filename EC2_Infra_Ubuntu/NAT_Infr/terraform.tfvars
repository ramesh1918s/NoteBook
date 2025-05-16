aws_region             = "us-east-1"
aws_access_key         = "xxxxxxxxxxxxxxxxx"
aws_secret_key         = "xxxxxxxxxxxxxxxxxxxxxxxxx"
project_name           = "NAT_Insta_Public_Private"
vpc_cidr               = "194.36.0.0/16"
public_subnet_cidr     = "194.36.0.0/20"
private_subnet_1_cidr  = "194.36.16.0/20"
private_subnet_2_cidr  = "194.36.32.0/20"
public_az              = "us-east-1a"
private_az_1           = "us-east-1b"
private_az_2           = "us-east-1c"
ami_id                 = "ami-084568db4383264d4"
instance_type          = "t2.micro"
key_name               = "Qalb_Key"


# vim Private_key
# ubuntu@ip-194-36-13-155:~$ chmod 400 Private_key
# ubuntu@ip-194-36-13-155:~$ ssh -i Private_key ubuntu@194.36.18.202
