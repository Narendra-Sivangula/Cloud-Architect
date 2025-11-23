resource "aws_instance" "web" {
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = "t2.micro"

  tags = {
    Name = "Hello Narendra"
  }
}