resource "aws_key_pair" "key" {
  key_name   = "${var.first_name}-hashi-key"
  public_key = file(var.public_key)
}

resource "aws_instance" "servers" {
  ami           = local.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name
  count         = var.server_count

  tags = {
    Name = "${var.first_name}-${var.server_name_prefix}${format("%02d", count.index + 1)}"
  }

}

resource "aws_instance" "clients" {
  ami           = local.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name
  count         = var.client_count

  tags = {
    Name = "${var.first_name}-${var.client_name_prefix}${format("%02d", count.index + 1)}"
  }

}
resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      servers = tomap({
        for instance in aws_instance.servers :
        instance.tags.Name => instance.public_ip
      })
      clients = tomap({
        for instance in aws_instance.clients :
        instance.tags.Name => instance.public_ip
      })
    }
  )
  filename = "../inventory"
}
