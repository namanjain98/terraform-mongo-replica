
variable "name" {
	type = string
}

variable "ami" {
	type = string
}

variable "instance_type" {
	type    = string
	default = "t2.micro"
}

variable "key_name"{
	type=string
}
variable "vpc_security_group_ids"{
	
}

