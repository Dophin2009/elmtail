variable "maas_api_key" {
  type        = string
  description = "MAAS API key"
  sensitive   = true
}

variable "maas_api_url" {
  type        = string
  description = "MAAS API URL"
  sensitive   = true
}

terraform {
  required_providers {
    maas = {
      source  = "dan-sullivan/maas"
      version = "1.0.0-ds"
    }
  }
}

provider "maas" {
  api_version = "2.0"
  api_key     = var.maas_api_key
  api_url     = var.maas_api_url
}
