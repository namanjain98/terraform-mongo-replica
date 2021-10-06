variable "replicas" {
	default=2
}
variable "AWS_REGION" {
	default="us-east-1"
}


variable "PATH_TO_PRIVATE_KEY" {
  default = "mongo"
}
variable "port" {
   default= 27017
}


variable "PATH_TO_PUBLIC_KEY" {
  default = "mongo.pub"
}

variable "ami" {
	default="ami-09e67e426f25ce0d7"
}