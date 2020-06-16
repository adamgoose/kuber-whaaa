variable "namespace" {
  description = "Namespace in which to deploy NodeRED"
  type        = string
  default     = "node-red"
}

variable "hostname" {
  description = "Hostname to use for NodeRED"
  type        = string
}
