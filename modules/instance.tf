resource "aws_instance" "webserver" {
    ami           = var.ami
	  instance_type = var.instance_type
    user_data="${file("./install-mongo.sh")}"
    key_name     = var.key_name
    vpc_security_group_ids = var.vpc_security_group_ids
  }