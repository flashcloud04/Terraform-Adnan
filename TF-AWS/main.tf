terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.64.0"
    }
  }
}

# Use the already-created VPC
data "aws_vpc" "existing" {
  id = "vpc-098884ed175c0a912"
}

# Create a subnet inside the existing VPC
resource "aws_subnet" "public" {
  vpc_id     = data.aws_vpc.existing.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "my-public-subnet"
  }
}

# Create EC2 instance inside the new subnet
resource "aws_instance" "myWebServer" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public.id

  tags = {
    Name = "MyWebServerVPC"
  }
}