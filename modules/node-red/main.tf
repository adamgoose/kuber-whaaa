resource "kubernetes_namespace" "main" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "node-red" {
  name       = "node-red"
  namespace  = kubernetes_namespace.main.metadata[0].name
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "node-red"
  version    = "1.4.2"

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
