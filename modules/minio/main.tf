# https://kubernetes-charts.storage.googleapis.com

resource "kubernetes_namespace" "minio" {
  metadata {
    name = var.namespace
  }
}

resource "random_password" "accessKey" {
  length  = 20
  special = false
}

resource "random_password" "secretKey" {
  length  = 40
  special = false
}

resource "helm_release" "minio" {
  name       = "minio"
  namespace  = kubernetes_namespace.minio.metadata[0].name
  repository = "https://helm.min.io/"
  chart      = "minio"
  version    = "8.0.0"

  values = [yamlencode({
    accessKey = random_password.accessKey.result
    secretKey = random_password.secretKey.result

    resources = {
      requests = {
        memory = "0Gi"
      }
    }
    persistence = {
      size = "10Gi"
    }

    ingress = {
      enabled = true
      annotations = {
        "traefik.ingress.kubernetes.io/router.tls" = "true"
        "cert-manager.io/cluster-issuer"           = "letsencrypt"
      }
      hosts = [var.hostname]
      tls = [{
        secretName = "minio-ssl"
        hosts      = [var.hostname]
      }]
    }
  })]
}

output "accessKey" {
  value = random_password.accessKey.result
}

output "secretKey" {
  value = random_password.secretKey.result
}
