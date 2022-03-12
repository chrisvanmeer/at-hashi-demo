resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}

resource "aws_instance" "servers" {
  ami           = local.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name
  count         = var.server_count

  tags = {
    Name = "${var.server_name_prefix}${format("%02d", count.index + 1)}"
  }

}

resource "aws_instance" "clients" {
  ami           = local.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name
  count         = var.client_count

  tags = {
    Name = "${var.client_name_prefix}${format("%02d", count.index + 1)}"
  }

}

output "server_details" {
  value = zipmap(aws_instance.servers.*.tags.Name, aws_instance.servers.*.public_ip)
}

output "client_details" {
  value = zipmap(aws_instance.clients.*.tags.Name, aws_instance.clients.*.public_ip)
}
