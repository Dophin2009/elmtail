module "inventory_file" {
  source = "../tmpfile"

  namespace       = var.namespace
  filename        = "inventory"
  file_permission = "0644"
  content = templatefile("${path.module}/inventory.tftpl", {
    hosts = var.hosts
  })
}
