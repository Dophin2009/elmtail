variable "namespace" {
  type    = string
  default = "local-provision"
}

variable "hosts" {
  type = map(list(object({
    hostname = string
  })))
}
