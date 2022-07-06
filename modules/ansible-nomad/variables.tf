variable "namespace" {
  description = "Namespace in which temporary files will be deposited."
  type        = string
}

variable "hosts" {
  description = "Hosts to be used in the Nomad cluster."
  type = map(map(any))
}

variable "vars" {
  description = "Variables to be used in the inventory file."
  type        = map(any)
}
