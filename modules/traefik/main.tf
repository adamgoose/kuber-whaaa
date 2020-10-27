// Create the namespace for Traefik
resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

// Install Traefik
resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = kubernetes_namespace.traefik.metadata[0].name
  repository = "https://containous.github.io/traefik-helm-chart"
  chart      = "traefik"
  version    = "8.4.1"

  values = [yamlencode({
    additionalArguments = []
    envFrom             = []
  })]
}

// Retrieve the created Service
data "kubernetes_service" "traefik" {
  metadata {
    name      = "traefik"
    namespace = kubernetes_namespace.traefik.metadata[0].name
  }

  depends_on = [helm_release.traefik]
}

// Create a DNS Zone, aka DO Domain
resource "digitalocean_domain" "domain" {
  name = var.domain
}

// Set the A record using the Service's IP
resource "digitalocean_record" "top" {
  domain = digitalocean_domain.domain.name
  type   = "A"
  ttl    = 60
  name   = "@"
  value  = data.kubernetes_service.traefik.load_balancer_ingress.0.ip
}

// Set a wildcard CNAME
resource "digitalocean_record" "wild" {
  domain = digitalocean_domain.domain.name
  type   = "CNAME"
  ttl    = 60
  name   = "*"
  value  = "${digitalocean_domain.domain.name}."
}
