provider "aws" {
  region = "ap-south-1" # Mumbai region (change if needed)
}

resource "aws_security_group" "sg" {
  name        = "allow_custom_port"
  description = "Allow traffic on custom port"

  ingress {
    from_port   = 1234        # Replace with last 4 digits of your roll number
    to_port     = 1234
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 LTS (valid as of now)
  instance_type = "t2.micro"
  key_name      = "your-key-name"         # Replace with your actual EC2 key pair name
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "WebServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              systemctl enable docker
              EOF
}
