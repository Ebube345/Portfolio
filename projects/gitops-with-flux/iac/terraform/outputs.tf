output "kubeconfig" {
  description = "Kubeconfig for the KIND cluster"
  value       = kind_cluster.this.kubeconfig
  sensitive   = true
}

output "flux_private_key" {
  description = "Flux SSH private key (for reference; store securely"
  value       = tls_private_key.flux.private_key_pem
  sensitive   = true
}