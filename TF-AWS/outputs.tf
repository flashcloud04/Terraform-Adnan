output "instance_details" {
  value = {
    public_ip     = aws_instance.myWebServer.public_ip
    private_ip    = aws_instance.myWebServer.private_ip
    ami           = aws_instance.myWebServer.ami
    instance_type = aws_instance.myWebServer.instance_type
  }
}