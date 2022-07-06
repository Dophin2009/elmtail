locals {
  requirements = "${path.module}/roles/requirements.yaml"
  playbook     = "${path.module}/glusterfs.yaml"

  # Open necessary firewall ports.
  tcp_ports = [for i in range(length(var.hosts)) : 49152 + i]
  vars = merge(var.vars, {
    firewall_allowed_tcp_ports = concat([22, 111, 2049, 24007, 24008, 38465, 38466], local.tcp_ports)
    firewall_allowed_udp_ports = [111]
  })

  inventory = yamlencode({
    glusterfs = {
      hosts = var.hosts
      vars  = local.vars
    }
  })
}

module "roles" {
  source = "../ansible-role-install"

  requirements = local.requirements
}

module "install" {
  source     = "../ansible-playbook"
  depends_on = [module.roles]

  namespace = var.namespace
  inventory = local.inventory
  playbook  = local.playbook
}
