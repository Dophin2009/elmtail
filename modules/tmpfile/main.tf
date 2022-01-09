variable "namespace" {
  type = string
}

variable "filename" {
  type = string
}

variable "file_permission" {
  type = string
  default = "0777"
}

variable "directory_permission" {
  type = string
  default = "0777"
}

variable "content" {
  type = string
}

resource "local_file" "file" {
  filename             = "${path.root}/.terraform/tmp/${var.namespace}/${var.filename}"
  file_permission      = var.file_permission
  directory_permission = var.directory_permission
  content              = var.content
}

output "filename" {
  value = local_file.file.filename
}
