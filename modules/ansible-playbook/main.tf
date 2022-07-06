module "inventory" {
  source = "../tmpfile"

  namespace       = var.namespace
  filename        = "inventory.yaml"
  file_permission = "0644"
  content         = var.inventory
}

resource "null_resource" "playbooks" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${abspath(module.inventory.filename)} ${var.playbook}"
  }
}
