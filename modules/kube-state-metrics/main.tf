resource "helm_release" "kube-state-metrics" {
  name       = "kube-state-metrics"
  namespace  = "kube-system"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "kube-state-metrics"
  version    = "2.8.9"
}
