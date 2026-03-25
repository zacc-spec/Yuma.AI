variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Kubernetes context to use (e.g., 'minikube', 'docker-desktop')"
  type        = string
  default     = "minikube"
}

variable "namespace" {
  description = "Kubernetes namespace for Yuma.AI resources"
  type        = string
  default     = "yuma-ai"
}

variable "environment" {
  description = "Environment name (development, staging, production)"
  type        = string
  default     = "development"
  
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}
