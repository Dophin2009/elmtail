resource "null_resource" "install" {
  triggers = {
    file_changed = md5(file(var.requirements))
  }

  provisioner "local-exec" {
    command = "ansible-galaxy install -gfr ${var.requirements}"
  }
}
