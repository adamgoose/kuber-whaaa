provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  load_config_file = false
  host             = module.cluster.endpoint
  token            = module.cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    module.cluster.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    load_config_file = false
    host             = module.cluster.endpoint
    token            = module.cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(
      module.cluster.kube_config[0].cluster_ca_certificate
    )
  }
}

provider "kustomization" {
  kubeconfig_path = "${path.root}/kubeconfig.yaml"
}
