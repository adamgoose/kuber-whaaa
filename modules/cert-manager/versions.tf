terraform {
  required_version = "~> 0.13"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "~> 0.2"
    }
  }
}
