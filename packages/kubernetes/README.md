# Kubernetes Configuration
# Manifests and deployments for Kubernetes orchestration

## Setup

Your kubeconfig is located at: `../../.kubeconfig`

To load Kubernetes configuration:
```bash
source ./setup-kubernetes.sh
```

## Structure

- `deployments/` — Kubernetes Deployment manifests
- `services/` — Service configurations
- `configmaps/` — ConfigMap resources
- `secrets/` — (if needed) Sensitive data

## Common Commands

```bash
# Apply all manifests in this directory
kubectl apply -f ./

# Check deployment status
kubectl get deployments

# View logs
kubectl logs deployment/yuma-backend

# Port forward for local development
kubectl port-forward svc/yuma-backend 5000:5000
```

## Create Your Manifests

Add YAML files for:
- Backend Deployment
- Frontend Deployment (optional)
- Services (LoadBalancer or ClusterIP)
- ConfigMaps for configuration
- Secrets for sensitive data
