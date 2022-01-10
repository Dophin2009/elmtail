variable "namespace" {
  description = "Namespace in which temporary files will be deposited."
  type        = string
}

variable "inventory" {
  description = "Inventory file to use."
  type = map(object({
    hosts = list(object({
      hostname = string
      options  = map(any)
    }))
    vars = map(any)
  }))
}

variable "playbook" {
  description = "Ansible playbook to play."
  type        = string
}
