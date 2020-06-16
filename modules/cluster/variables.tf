variable "name" {
  description = "Name of the cluster"
  type        = string
}

variable "region" {
  description = "Digitalocean Region of the cluster"
  type        = string
  default     = "nyc1"
}

variable "kubernetes_version" {
  description = "Digitalocean Kubernetes Version of the cluster"
  type        = string
  default     = "1.17.5-do.0"
}

variable "node_size" {
  description = "Size of the nodes in the default node pool"
  type        = string
  default     = "s-2vcpu-2gb" // $15/mo
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}
