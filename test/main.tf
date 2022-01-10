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

module "cluster_provision" {
  source    = "../provision"
  namespace = "provision"

  hosts = {
    for machine in vagrant_vm.cluster.ssh_config : "cluster" => [{
      hostname = machine.host
    }]
  }
}
