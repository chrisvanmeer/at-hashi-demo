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
