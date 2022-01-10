locals {
  lnamespace = "${var.namespace}/provision"

  consul_hosts = [
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
}

module "provision_consul" {
  source = "../modules/ansible-consul"

  namespace = "${local.lnamespace}/consul"
  hosts     = local.consul_hosts
  vars      = {}
}
