# Helm - Package Manager for Kubernetes

Helm is the Kubernetes package manager. It helps deploy, manage, and upgrade applications on Kubernetes.

## Quick Start

### 1. Verify Helm Installation
```bash
helm version
helm --help
```

### 2. List Available Repositories
```bash
helm repo list
```

### 3. Search for Charts
```bash
helm search repo bitnami   # Search Bitnami charts
helm search repo          # Search all repos
```

### 4. Install a Chart
```bash
# Example: Install PostgreSQL from Bitnami
helm install my-postgres bitnami/postgresql \
  --namespace yuma-ai \
  --values values.yaml
```

### 5. List Installed Releases
```bash
helm list -n yuma-ai       # List in specific namespace
helm list --all-namespaces # List all releases
```

### 6. Check Release Status
```bash
helm status my-postgres -n yuma-ai
```

## Core Helm Commands

| Command | Purpose |
|---------|---------|
| `helm install` | Deploy a chart to Kubernetes |
| `helm upgrade` | Update an existing release |
| `helm uninstall` | Remove a release |
| `helm list` | List all release |
| `helm status` | Show release status |
| `helm history` | Release version history |
| `helm rollback` | Revert to previous version |
| `helm repo add` | Add a chart repository |
| `helm search` | Search for charts |
| `helm pull` | Download a chart |
| `helm create` | Create a new chart |

## Helm Repositories

### Pre-configured Repositories
```bash
# Bitnami (community maintained)
helm repo add bitnami https://charts.bitnami.com/bitnami

# Helm Official
helm repo add stable https://charts.helm.sh/stable

# Add more as needed
helm repo update  # Update all repos
```

### Remove a Repository
```bash
helm repo remove bitnami
```

## Yuma.AI Helm Charts

### Future: Custom Helm Chart for Yuma.AI
Create a reusable Helm chart to deploy the entire Yuma.AI stack:

```bash
helm create ./yuma-ai-chart
```

This will create:
```
yuma-ai-chart/
├── Chart.yaml           # Chart metadata
├── values.yaml          # Default configuration
├── values-dev.yaml      # Development overrides
├── values-prod.yaml     # Production overrides
└── templates/           # Kubernetes manifests (templated)
    ├── deployment.yaml
    ├── service.yaml
    ├── configmap.yaml
    └── ...
```

## Managing Releases

### Install with Custom Values
```bash
helm install yuma-ai ./yuma-ai-chart \
  -f values-dev.yaml \
  -n yuma-ai
```

### Upgrade a Release
```bash
helm upgrade yuma-ai ./yuma-ai-chart \
  -f values-dev.yaml \
  -n yuma-ai
```

### View Release History
```bash
helm history yuma-ai -n yuma-ai
```

### Rollback to Previous Version
```bash
helm rollback yuma-ai 1 -n yuma-ai  # Rollback to revision 1
```

### Uninstall Release
```bash
helm uninstall yuma-ai -n yuma-ai
```

## Helm vs kubectl

| Task | Helm | kubectl |
|------|------|---------|
| Install multiple resources together | ✅ Yes | ❌ One file at a time |
| Variable substitution | ✅ Yes | ❌ No |
| Versioning/history | ✅ Yes | ❌ No |
| Upgrades | ✅ Easy | ❌ Manual |
| Rollbacks | ✅ One command | ❌ Manual |

## Troubleshooting

**"Error: release not found"**
```bash
helm list -n yuma-ai  # Check if release exists
helm install ... # If not, install it
```

**"Chart not found"**
```bash
helm repo update  # Update chart repositories
helm search repo chart-name  # Verify chart exists
```

**"Permission denied"**
```bash
# Check RBAC and namespace
kubectl get pods -n yuma-ai
kubectl describe pod <pod-name> -n yuma-ai
```

## Resources

- [Helm Official Docs](https://helm.sh/docs/)
- [Helm Hub - Chart Repository](https://hub.helm.sh/)
- [Bitnami Charts](https://bitnami.com/stacks/helm)

## CLI Installation Verified ✅

```
Version: v4.1.3
Location: /opt/homebrew/bin/helm
Kubernetes Context: minikube
Repository: bitnami added and updated
Status: Fully functional
```
