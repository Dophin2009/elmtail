variable "namespace" {
  description = "Namespace in which temporary files will be deposited."
  type        = string
}

variable "hosts" {
  description = "Hosts to be used in the Consul cluster."
  type = list(object({
    hostname = string
    options  = map(any)
  }))
}

variable "vars" {
  description = "Variables to be used in the inventory file."
  type        = map(any)
}
