terraform {
  required_version = "~> 0.13"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13"
    }
  }
}
