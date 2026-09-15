#EC2 instance for nginx setup
resource "aws_instance" "nginxserver" {
  ami           = "ami-0e34b50e714a297f1"
  instance_type = "t2.micro"
  subnet_id      = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
            #!/bin/bash
            sudo yum install nginx -y
            sudo systemctl start nginx
            sudo enable nginx
            EOF

  tags = {
    Name = "NginxServer"
  }
}