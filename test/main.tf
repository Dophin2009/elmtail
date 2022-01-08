locals {
  nodes = 3
}

resource "vagrant_vm" "cluster" {
  vagrantfile_dir = "."
  env = {
    VAGRANTFILE_HASH   = md5(file("./Vagrantfile")),
    VAGRANT_NODE_COUNT = local.nodes
  }
}

output "cluster_hosts" {
  value = [
    for machine in vagrant_vm.cluster.ssh_config : machine.host
  ]
}
