variable "first_name" {
  type        = string
  description = "Please enter your first name. This will be used in several components."
}

variable "public_key" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "server_count" {
  type    = number
  default = 3
}

variable "server_name_prefix" {
  type    = string
  default = "server"
}

variable "client_count" {
  type    = number
  default = 4
}

variable "client_name_prefix" {
  type    = string
  default = "client"
}

locals {
  instance_ami = data.aws_ami.ubuntu.id
}
