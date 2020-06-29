resource "kubernetes_namespace" "surprise" {
  metadata {
    name = "surprise"
  }
}

data "kustomization" "surprise" {
  path = "${path.module}/kustomize"
}

resource "kustomization_resource" "surprise" {
  for_each = data.kustomization.surprise.ids
  manifest = data.kustomization.surprise.manifests[each.value]

  depends_on = [kubernetes_namespace.surprise]
}
