data "kustomization" "cert-manager" {
  path = "${path.module}/kustomize"
}

resource "kustomization_resource" "cert-manager" {
  for_each = data.kustomization.cert-manager.ids
  manifest = data.kustomization.cert-manager.manifests[each.value]
}

resource "kubernetes_secret" "do-token" {
  metadata {
    name      = "do"
    namespace = "cert-manager"
  }
  data = {
    token = var.do_token
  }

  depends_on = [kustomization_resource.cert-manager]
}
