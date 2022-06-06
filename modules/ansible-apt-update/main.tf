locals {
  playbook = "${path.module}/apt.yaml"

  inventory = {
    instances = {
      hosts = var.hosts
      vars  = var.vars
    }
  }
}

module "install" {
  source     = "../ansible-playbook"

  namespace = var.namespace
  inventory = local.inventory
  playbook  = local.playbook
}
