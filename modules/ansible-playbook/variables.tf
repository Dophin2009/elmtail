variable "namespace" {
  description = "Namespace in which temporary files will be deposited."
  type        = string
}

variable "inventory" {
  description = "Inventory file contents."
  type = string 
}

variable "playbook" {
  description = "Ansible playbook file name."
  type        = string
}
