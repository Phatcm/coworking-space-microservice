output "metrics_server_release_name" {
  value = helm_release.metrics_server.name
  description = "The name of the metrics-server Helm release."
}