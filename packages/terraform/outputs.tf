output "kubernetes_cluster_name" {
  description = "Kubernetes cluster name in current context"
  value       = var.kubeconfig_context
}

output "kubernetes_namespace" {
  description = "Kubernetes namespace for Yuma.AI"
  value       = var.namespace
}

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}
