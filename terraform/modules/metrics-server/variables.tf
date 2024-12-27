variable "metrics_server_version" {
  description = "The version of the metrics-server Helm chart."
  type        = string
  default     = "3.11.0"
}

variable "metrics_server_name" {
  description = "The name of the metrics-server Helm chart."
  type        = string
  default     = "metrics-server"
}

variable "namespace" {
  description = "The Kubernetes namespace where Metrics Server will be installed."
  type        = string
  default     = "kube-system"
}