resource "docker_image" "ubuntu" {
  name = "at"
  build {
    path = "."
    tag  = ["at:latest"]

    build_arg = {
      ssh_prv_key : file("~/.ssh/id_rsa")
      ssh_pub_key : file("~/.ssh/id_rsa.pub")
    }
    label = {
      author : "CvM"
    }
  }
}

resource "docker_container" "servers" {
  image             = docker_image.ubuntu.latest
  name              = "${var.server_name_prefix}${format("%02d", count.index + 1)}"
  hostname          = "${var.server_name_prefix}${format("%02d", count.index + 1)}"
  count             = var.server_count
  publish_all_ports = true
  command = [
    "tail",
    "-f",
    "/dev/null"
  ]
}

resource "docker_container" "clients" {
  image             = docker_image.ubuntu.latest
  name              = "${var.client_name_prefix}${format("%02d", count.index + 1)}"
  hostname          = "${var.client_name_prefix}${format("%02d", count.index + 1)}"
  count             = var.client_count
  publish_all_ports = true
  command = [
    "tail",
    "-f",
    "/dev/null"
  ]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      servers = tomap({
        for instance in docker_container.servers :
        instance.name => instance.ip_address
      })
      clients = tomap({
        for instance in docker_container.clients :
        instance.name => instance.ip_address
      })
    }
  )
  filename = "../inventory"
}
