locals {
  namespace = "local/cluster"
  nodes     = 1
}

resource "vagrant_vm" "cluster" {
  vagrantfile_dir = "."
  env = {
    VAGRANTFILE_HASH   = md5(file("./Vagrantfile")),
    VAGRANT_NODE_COUNT = local.nodes
  }
}

module "cluster_ssh_keys" {
  count     = local.nodes
  source    = "../modules/tmpfile"
  namespace = local.namespace

  filename             = "privkey${count.index}.rsa"
  file_permission      = "0600"
  directory_permission = "0600"
  content              = vagrant_vm.cluster.ssh_config[count.index].private_key
}

locals {
  hosts = [
    for i, machine in vagrant_vm.cluster.ssh_config :
    {
      host             = machine.host
      port             = machine.port
      user             = machine.user
      private_key_file = module.cluster_ssh_keys[i].filename
    }
  ]
}
