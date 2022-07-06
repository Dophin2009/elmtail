variable "namespace" {
  description = "Namespace in which temporary files will be deposited."
  type        = string
}

variable "hosts" {
  description = "Hosts to be used in the Nomad cluster."
  type        = map(map(any))
}

variable "vars" {
  description = "Variables to be used in the inventory file."
  type        = map(any)

  validation {
    condition     = var.vars["gluster_replicas"] != null
    error_message = "The vars value must contain the key gluster_replicas."
  }

  validation {
    condition     = var.vars["gluster_mount_dir"] != null
    error_message = "The vars value must contain the key gluster_mount_dir."
  }

  validation {
    condition     = var.vars["gluster_brick_dir"] != null
    error_message = "The vars value must contain the key gluster_brick_dir."
  }

  validation {
    condition     = var.vars["gluster_brick_name"] != null
    error_message = "The vars value must contain the key gluster_brick_name."
  }
}
