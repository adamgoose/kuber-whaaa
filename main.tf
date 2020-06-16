// This module provisions a Digitalocean Kubernetes Cluster, and creates a file
// in this directory called `kubeconfig.yaml`. It outputs `endpoint` and
// `kube_config` for use in the other providers.
module "cluster" {
  source = "./modules/cluster"

  name               = "kuber-whaaa"
  region             = "nyc1"
  kubernetes_version = "1.17.5-do.0"
  node_size          = "s-2vcpu-2gb" // $15/mo
  node_count         = 2             // $30/mo
}

// Kube State Metrics provide additional metrics from the Kubernetes API
module "kube-state-metrics" {
  source = "./modules/kube-state-metrics"
}

// Traefik is a reverse proxy, used to implement the "ingress controller" role
// of Kubernetes. It handles all inbound HTTP traffic to the cluster, terminates
// SSL, and provides load balancing among other features. This module will also
// create DNS entries for domain and *.domain.
module "traefik" {
  source = "./modules/traefik"

  domain = "do.enge.me"
}

// Cert Manager automatically detects Kubernetes Ingress resources, and in turn
// provisions LetsEncrypt certificates for TLS termination. It uses the DNS
// validation method, requiring access to the Digitalocean API
module "cert-manager" {
  source = "./modules/cert-manager"

  do_token = var.do_token
}

// NodeRED is an awesome low-code programming tool. If you haven't heard of it,
// definitely check it out!
module "node-red" {
  source = "./modules/node-red"

  hostname = "node-red.do.enge.me"
}

// Minio is an S3-compliant Object Storage API.
module "minio" {
  source = "./modules/minio"

  hostname = "minio.do.enge.me"
}

// Get the generated Minio credentials
output "minio" {
  value = module.minio
}
