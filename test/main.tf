locals {
  nodes = 1
}

resource "vagrant_vm" "cluster" {
  vagrantfile_dir = "."
  env = {
    VAGRANTFILE_HASH   = md5(file("./Vagrantfile")),
    VAGRANT_NODE_COUNT = local.nodes
  }
}

module "cluster_ssh_private_keys" {
  count     = local.nodes
  source    = "../modules/tmpfile"
  namespace = "local/cluster"

  filename        = "privkey${count.index}.rsa"
  file_permission = "0600"
  content         = vagrant_vm.cluster.ssh_config[count.index].private_key
}

locals {
  inventory = {
    cluster = {
      hosts = [
        for i, machine in vagrant_vm.cluster.ssh_config : { hostname = machine.host, options = {
          ansible_ssh_private_key_file = module.cluster_ssh_private_keys[i].filename
        } }
      ]
      vars = {}
    }
  }
}

module "cluster_provision" {
  source    = "../provision"
  namespace = "local/provision"

  inventory = local.inventory
  playbooks = ["consul"]
}
