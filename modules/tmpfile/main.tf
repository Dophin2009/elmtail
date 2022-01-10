variable "namespace" {
  type = string
}

variable "filename" {
  type = string
}

variable "file_permission" {
  type    = string
  default = "0744"
}

variable "directory_permission" {
  type    = string
  default = "0755"
}

variable "content" {
  type      = string
  sensitive = true
}

resource "local_file" "file" {
  filename             = "${path.root}/.terraform/tmp/${var.namespace}/${var.filename}"
  file_permission      = var.file_permission
  directory_permission = var.directory_permission
  content              = var.content
}

output "filename" {
  description = "The absolute path of the file."
  value       = local_file.file.filename
}
