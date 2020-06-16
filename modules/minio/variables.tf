variable "namespace" {
  description = "Namespace in which to deploy Minio"
  type        = string
  default     = "minio"
}

variable "hostname" {
  description = "Hostname to use for Minio"
  type        = string
}
