resource "docker_image" "ubuntu" {
  name = "ubuntu:focal"
}

resource "docker_container" "servers" {
  image    = docker_image.ubuntu.latest
  name     = "${var.server_name_prefix}${format("%02d", count.index + 1)}"
  hostname = "${var.server_name_prefix}${format("%02d", count.index + 1)}"
  count    = var.server_count
}

resource "docker_container" "clients" {
  image    = docker_image.ubuntu.latest
  name     = "${var.client_name_prefix}${format("%02d", count.index + 1)}"
  hostname = "${var.client_name_prefix}${format("%02d", count.index + 1)}"
  count    = var.client_count
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      servers = tomap({
        for instance in docker_container.servers :
        instance.name => instance.ip
      })
      clients = tomap({
        for instance in docker_container.clients :
        instance.name => instance.ip
      })
    }
  )
  filename = "../inventory"
}
