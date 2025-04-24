# Creating VPC
resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.0.0.0/16" # Do i need this many IP addresses?

  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_subnet" "pub1-wordpress" {
  cidr_block        = "10.0.0.0/28"
  availability_zone = "eu-north-1a"
  vpc_id            = aws_vpc.wordpress-vpc.id
  
  tags = {
    Name = "pub1-wordpress"
  }
}

# Launch Ec2 Instance
resource "aws_instance" "wordpress" {
  ami           = "ami-08f78cb3cc8a4578e" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pub1-wordpress.id

  # user_data = file("userdata.sh")

  tags = {
    Name = "wordpress-instance"
  }
}
