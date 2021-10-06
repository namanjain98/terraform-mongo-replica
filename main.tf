resource "tls_private_key" "mongo" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "mongo" {
  key_name   = "mongo-key"
  public_key = tls_private_key.mongo.public_key_openssh
}

resource "local_file" "local_ssh_private_key" {
  content         = tls_private_key.mongo.private_key_pem
  filename        = "mongo"
  file_permission = "644"
}

resource "local_file" "local_ssh_public_key" {
  content         = tls_private_key.mongo.public_key_openssh
  filename        = "mongo.pub"
  file_permission = "600"
} 
resource "aws_security_group" "SG" {
  name        = "ES-SG"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ES-SG"
  }
}



module "webserver" {
    count         = var.replicas
	source        = "./modules/"
	name          = "mongo-server-${count.index}"
	ami           = "ami-09e67e426f25ce0d7"
	instance_type = "t2.micro"
    key_name     = aws_key_pair.mongo.key_name
    vpc_security_group_ids = [aws_security_group.SG.id]
}
