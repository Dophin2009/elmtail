locals {
  children = {
    for groupname, group in var.inventory : groupname => {
      hosts = {
        for host in group.hosts : host.hostname => host.options
      }
      vars = group.vars
    }
  }
}

module "inventory_file" {
  source = "../modules/tmpfile"

  namespace       = var.namespace
  filename        = "inventory.yaml"
  file_permission = "0644"
  content = yamlencode({
    all = {
      children = local.children
    }
  })
}

# resource "null_resource" "playbook" {
# provisioner "local-exec" {
# command = "ansible -i ${module.inventory_file.filename}"
# }
# }
