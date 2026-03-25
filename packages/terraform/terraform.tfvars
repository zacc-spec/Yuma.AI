# Terraform Variables for Yuma.AI
# Copy this to terraform.tfvars and customize as needed

kubeconfig_path  = "~/.kube/config"
kubeconfig_context = "minikube"    # Change to your K8s context (minikube, docker-desktop, eks-cluster, etc.)
namespace        = "yuma-ai"
environment      = "development"    # development, staging, or production
