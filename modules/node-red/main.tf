resource "kubernetes_namespace" "main" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "node-red" {
  name       = "node-red"
  namespace  = kubernetes_namespace.main.metadata[0].name
  repository = "https://k8s-at-home.com/charts/"
  chart      = "node-red"
  version    = "3.1.0"

  values = [yamlencode({
    timezone = "America/Chicago"
    ingress = {
      enabled = true
      annotations = {
        "traefik.ingress.kubernetes.io/router.tls" = "true"
        "cert-manager.io/cluster-issuer"           = "letsencrypt"
      }
      hosts = [var.hostname]
      tls = [{
        secretName = "node-red-ssl"
        hosts      = [var.hostname]
      }]
    }
    persistence = {
      enabled = true
      size    = "1Gi"
    }
  })]
}
