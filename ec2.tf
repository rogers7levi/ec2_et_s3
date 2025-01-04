resource "aws_instance" "backend" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.backend.name]
  key_name        = var.pem

  tags = {
    Name = "backend"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_security_group" "backend" {
  name = "backend"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "86.156.185.83/32",
    "213.32.248.64/32"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

