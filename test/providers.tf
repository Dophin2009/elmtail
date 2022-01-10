terraform {
  backend "local" { path = "./.terraform/state/terraform.tfstate" }
  required_providers {
    vagrant = {
      source  = "bmatcuk/vagrant"
      version = "~> 4.0.0"
    }
  }
}

provider "vagrant" {}
