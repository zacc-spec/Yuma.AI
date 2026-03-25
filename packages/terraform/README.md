# Terraform - Infrastructure as Code for Yuma.AI

This directory contains Terraform configuration for managing Yuma.AI infrastructure using **Infrastructure as Code (IaC)** principles.

## Quick Start

### 1. Initialize Terraform
```bash
cd packages/terraform
terraform init
```

### 2. Configure Variables
```bash
# Copy example configuration
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
nano terraform.tfvars
```

### 3. Validate Configuration
```bash
terraform validate
terraform plan
```

### 4. Apply Configuration
```bash
terraform apply
```

## Files Overview

- **providers.tf** - Kubernetes provider configuration
- **variables.tf** - Input variables (kubeconfig path, context, namespace, environment)
- **outputs.tf** - Output values after Terraform applies
- **terraform.tfvars.example** - Example variables file

## Providers

### Kubernetes Provider
Manages Kubernetes resources (Deployments, Services, ConfigMaps, Namespaces).

**Configured for:**
- ✅ Minikube (local development)
- ✅ Docker Desktop Kubernetes
- ✅ EKS (AWS Kubernetes)
- ✅ GKE (Google Kubernetes Engine)
- ✅ AKS (Azure Kubernetes Service)

**Switch contexts:**
```bash
# List available contexts
kubectl config get-contexts

# Set context in terraform.tfvars
kubeconfig_context = "docker-desktop"  # or "eks-cluster", etc.
```

## Common Terraform Commands

```bash
# Plan changes (preview)
terraform plan

# Apply changes
terraform apply

# Destroy resources
terraform destroy

# Format code
terraform fmt -recursive

# Validate syntax
terraform validate

# Get provider info
terraform providers
```

## Next Steps

1. **Convert YAML to Terraform** - Migrate existing K8s manifests to Terraform resources
   - Example: `resource "kubernetes_deployment" "backend" { ... }`

2. **Add Cloud Providers** - Configure AWS/GCP/Azure if deploying to cloud
   - AWS: `aws` provider
   - Google Cloud: `google` provider
   - Azure: `azurerm` provider

3. **Remote State** - Move from local to remote state (S3, Azure Blob, Terraform Cloud)
   - Uncomment `backend` block in providers.tf

4. **Modules** - Organize code into reusable modules
   - Example: `modules/kubernetes/deployment/`

## Troubleshooting

**Error: "Unable to locate kubeconfig"**
- Check `kubeconfig_path` in terraform.tfvars
- Ensure file exists: `ls ~/.kube/config`

**Error: "context not found"**
- List available contexts: `kubectl config get-contexts`
- Update `kubeconfig_context` in terraform.tfvars

**Error: "provider not found"**
- Run: `terraform init -upgrade`

## Documentation

- [Kubernetes Provider Docs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
- [Terraform Documentation](https://www.terraform.io/docs)
