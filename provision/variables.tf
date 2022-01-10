variable "namespace" {
  type    = string
  default = "local/provision"
}

variable "inventory" {
  type = map(object({
    hosts = list(object({
      hostname = string
      options  = map(any)
    }))
    vars = map(any)
  }))
}

variable "playbooks" {
  type = list(string)

  validation {
    condition     = alltrue([for book in var.playbooks : can(regex("^consul$|^nomad$|^glusterfs$", book))])
    error_message = "Valid playbooks are [consul, nomad, glusterfs]."
  }
}
