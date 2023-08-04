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

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --disabled-password --gecos '' ${var.atcomputing_user}",
      "sudo mkdir -p /home/${var.atcomputing_user}/.ssh",
      "sudo touch /home/${var.atcomputing_user}/.ssh/authorized_keys",
      "sudo echo '${file(var.public_key)}' > authorized_keys",
      "sudo mv authorized_keys /home/${var.atcomputing_user}/.ssh",
      "sudo chown -R ${var.atcomputing_user}:${var.atcomputing_user} /home/${var.atcomputing_user}/.ssh",
      "sudo chmod 700 /home/${var.atcomputing_user}/.ssh",
      "sudo chmod 600 /home/${var.atcomputing_user}/.ssh/authorized_keys",
      "sudo usermod -aG sudo ${var.atcomputing_user}",
      "sudo echo '${var.atcomputing_user} ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers.d/90-cloud-init-users",
      "sudo hostnamectl set-hostname ${self.tags.Name}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
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

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --disabled-password --gecos '' ${var.atcomputing_user}",
      "sudo mkdir -p /home/${var.atcomputing_user}/.ssh",
      "sudo touch /home/${var.atcomputing_user}/.ssh/authorized_keys",
      "sudo echo '${file(var.public_key)}' > authorized_keys",
      "sudo mv authorized_keys /home/${var.atcomputing_user}/.ssh",
      "sudo chown -R ${var.atcomputing_user}:${var.atcomputing_user} /home/${var.atcomputing_user}/.ssh",
      "sudo chmod 700 /home/${var.atcomputing_user}/.ssh",
      "sudo chmod 600 /home/${var.atcomputing_user}/.ssh/authorized_keys",
      "sudo usermod -aG sudo ${var.atcomputing_user}",
      "sudo echo '${var.atcomputing_user} ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers.d/90-cloud-init-users",
      "sudo hostnamectl set-hostname ${self.tags.Name}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
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
