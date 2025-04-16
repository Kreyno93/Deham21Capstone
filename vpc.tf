# Creating VPC
resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.0.0.0/16" # Do i need this many IP addresses?

  tags = {
    Name = "wordpress-vpc"
  }
}



