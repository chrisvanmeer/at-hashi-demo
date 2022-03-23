variable "public_key" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
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
