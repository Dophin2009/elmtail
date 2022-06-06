locals {
  lnamespace = "${var.namespace}/provision"

  ansible_hosts = [
    for host in local.hosts :
    {
      hostname = host.host
      options = {
        ansible_port                 = host.port
        ansible_user                 = host.user
        ansible_ssh_private_key_file = host.private_key_file
        ansible_ssh_extra_args       = "-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
      }
    }
  ]

  // TODO: RPC traffic encryption via TLS
  consul_hosts = [
    for i, host in local.ansible_hosts :
    {
      hostname = host.hostname
      options = merge(host.options, {
        consul_client_address   = "0.0.0.0"
        consul_node_role        = i == 0 ? "server" : "client"
        consul_bootstrap_expect = i == 0
        consul_connect_enabled  = true
      })
    }
  ]

  // TODO: Enable and install Docker via Ansible
  // TODO: Secure traffic with TLS
  nomad_hosts = [
    for i, host in local.ansible_hosts :
    {
      hostname = host.hostname
      options = merge(host.options, {
        nomad_node_role        = i == 0 ? "server" : "client"
        nomad_bootstrap_expect = 1
        nomad_use_consul       = true
      })
    }
  ]
}

module "provision_apt" {
  source = "../modules/ansible-apt-update"

  namespace = "${local.lnamespace}/apt"
  hosts     = local.ansible_hosts
  vars      = {}
}

module "provision_pip" {
  source     = "../modules/ansible-pip"
  depends_on = [module.provision_apt]

  namespace = "${local.lnamespace}/pip"
  hosts     = local.ansible_hosts
  vars      = {}
}

module "provision_consul" {
  source     = "../modules/ansible-consul"
  depends_on = [module.provision_pip]

  namespace = "${local.lnamespace}/consul"
  hosts     = local.consul_hosts
  vars      = {}
}

module "provision-nomad" {
  source     = "../modules/ansible-nomad"
  depends_on = [module.provision_consul]

  namespace = "${local.lnamespace}/nomad"
  hosts     = local.nomad_hosts
  vars      = {}
}
