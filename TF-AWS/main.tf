terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.64.0"
    }
  }
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_instance" "myWebServer" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "MyWebServerVPC"
  }

}
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
}
