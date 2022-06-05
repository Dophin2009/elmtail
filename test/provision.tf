locals {
  lnamespace = "${var.namespace}/provision"

  consul_hosts = [
    for i, host in local.hosts :
    {
      hostname = host.host
      options = {
        ansible_port                 = host.port
        ansible_user                 = host.user
        ansible_ssh_private_key_file = host.private_key_file
        ansible_ssh_extra_args       = "-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
        consul_client_address        = "0.0.0.0"
        consul_node_role             = i == 0 ? "server" : "client"
        consul_bootstrap_expect      = true
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
