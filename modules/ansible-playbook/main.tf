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

module "inventory" {
  source = "../tmpfile"

  namespace       = var.namespace
  filename        = "inventory.yaml"
  file_permission = "0644"
  content         = yamlencode(local.children)
}

resource "null_resource" "playbooks" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${abspath(module.inventory.filename)} ${var.playbook}"
  }
}
