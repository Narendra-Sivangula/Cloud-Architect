# create ec2 instance


resource "aws_instance" "Ubuntu" {
  ami           = "ami-0f5ee92e2d63afc18"    # Ubuntu-Linux-ami
  instance_type = "t2.micro"

  tags = {
    Name = "UbuntuLinuxServer"
  }
}

/*resource "github_repository" "challenge" {
  name        = "Private_Repo_Challenge"
  description = "This repo is created using terraform as a challenge"
  visibility = "private"
}*/


output "IPaddress" {
  value = aws_instance.Ubuntu.public_ip
}

output "DNS" {
  value = aws_instance.Ubuntu.public_dns
}