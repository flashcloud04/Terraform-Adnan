 resource "aws_security_group" "nginx_sg" {
   vpc_id = aws_vpc.my_vpc.id

   #inbound rule for HTTP
   ingress {
             from_port = 80
              to_port = 80
              protocol = "tcp"
              cidr_blocks = ["0.0.0.0/0"]
   }

   #output rule 
   egress {
            from_port = 0 #enable for all 
            to_port = 0
            protocol = "-1" # applicable for all protocol
            cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
     Name = "nginx-sg"
   }
 }