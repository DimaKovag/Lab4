variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "key_name" {  
  default = "mykey"
}

variable "public_key_path" {
  default = "c:/Users/Дмитро/Desktop/IIT/lab4/mykey.pub"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  default = "ami-0c1ac8a41498c1a9c"
}