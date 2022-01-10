resource "null_resource" "install" {
  provisioner "local-exec" {
    command     = "ansible-galaxy install -gfr ${var.requirements}"
  }
}
