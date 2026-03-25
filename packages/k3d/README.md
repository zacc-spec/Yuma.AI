# K3d - Lightweight Kubernetes in Docker

K3d is a lightweight wrapper around k3s (lightweight Kubernetes) that makes it easy to create and manage Kubernetes clusters in Docker. It's faster and more resource-efficient than Minikube.

## Quick Start

### 1. Create a Cluster
```bash
k3d cluster create yuma-ai-k3d
```

### 2. Use the Cluster
```bash
kubectl cluster-info
kubectl get pods -A
```

### 3. Delete the Cluster
```bash
k3d cluster delete yuma-ai-k3d
```

## Core Commands

| Command | Purpose |
|---------|---------|
| `k3d cluster create` | Create a new cluster |
| `k3d cluster list` | List all clusters |
| `k3d cluster start` | Start a stopped cluster |
| `k3d cluster stop` | Stop a running cluster |
| `k3d cluster delete` | Delete a cluster |
| `k3d cluster reset` | Reset cluster registry |
| `k3d kubeconfig get` | Get kubeconfig |
| `k3d node create` | Add node to cluster |
| `k3d node list` | List cluster nodes |

## Why K3d?

### K3d vs Minikube

| Feature | K3d | Minikube |
|---------|-----|----------|
| **Speed** | ⚡ Very fast | 🔶 Slower |
| **Memory** | 💾 Minimal | 💾 More |
| **Startup** | ✅ Seconds | ⏱️ Minutes |
| **Scale** | 📈 Multi-node easy | 🔶 Complex |
| **Docker integration** | ✅ Native | 🔶 Via Docker Desktop |

## Advanced Usage

### Create Multi-Node Cluster
```bash
k3d cluster create yuma-ai \
  --servers 1 \
  --agents 3 \
  --port 8080:80@loadbalancer \
  --port 8443:443@loadbalancer
```

### With Custom Config
```bash
k3d cluster create yuma-ai \
  --config k3d-config.yaml
```

### Port Forwarding
```bash
k3d cluster create yuma-ai \
  --port 80:80@loadbalancer \
  --port 443:443@loadbalancer
```

## K3d Config File Example

Create `k3d-config.yaml`:
```yaml
apiVersion: k3d.io/v1alpha4
kind: Simple
metadata:
  name: yuma-ai
servers: 1
agents: 3
ports:
  - port: 80:80
    nodeFilters:
      - loadbalancer
  - port: 443:443
    nodeFilters:
      - loadbalancer
registries:
  create:
    name: k3d-yuma-registry
    host: 0.0.0.0
    hostPort: "5000"
```

Then create cluster:
```bash
k3d cluster create --config k3d-config.yaml
```

## Yuma.AI with K3d (Alternative to Minikube)

### Switch from Minikube to K3d

```bash
# Keep Minikube running, or switch contexts
kubectl config get-contexts

# Create K3d cluster
k3d cluster create yuma-ai-k3d

# Switch to K3d
kubectl config use-context k3d-yuma-ai-k3d

# Deploy Yuma.AI
kubectl apply -f packages/kubernetes/
helm install my-db bitnami/postgresql -n yuma-ai

# Or use Tilt with K3d
tilt up
```

### List All Clusters
```bash
k3d cluster list
minikube status  # Check if Minikube is running
```

## Advantages of K3d

1. **Speed** - Starts in seconds
2. **Resource efficient** - Low memory/CPU
3. **Easy cleanup** - Single command
4. **Multi-node ready** - Create complex clusters easily
5. **Better for CI/CD** - Fast iteration
6. **Docker native** - No VM overhead

## Troubleshooting

**"Cannot connect to cluster"**
```bash
k3d kubeconfig merge yuma-ai-k3d --switch-context
# Or manually
kubectl config use-context k3d-yuma-ai-k3d
```

**"Port already in use"**
```bash
# Use different port
k3d cluster create yuma-ai --port 8080:80@loadbalancer
```

**"Cannot access Docker**
```bash
# Make sure Docker is running
docker ps

# K3d uses Docker to run Kubernetes
```

**"Cluster won't start"**
```bash
# Check available disk space
df -h

# Delete unused clusters
k3d cluster delete old-cluster
```

## Comparison: Minikube vs K3d

### Current Setup
- Using: **Minikube** (running via Docker Desktop)
- Status: ✅ Working well
- Services: Backend, Frontend, PostgreSQL running

### Alternative Option
- Using: **K3d** (lightweight, faster)
- Benefit: Faster startup, less resource usage
- Setup: `k3d cluster create yuma-ai-k3d`

**Both work with Tilt, Helm, Terraform, and kubectl identically!**

## CLI Installation Verified ✅

```
Version: v5.8.3
Location: /opt/homebrew/bin/k3d
Status: Ready to use
Current Cluster: minikube (via Minikube)
Alternative: k3d available for faster iteration
```

## Resources

- [K3d Official Docs](https://k3d.io/)
- [K3s GitHub](https://github.com/k3s-io/k3s)
- [K3d GitHub](https://github.com/rancher/k3d)

## Decision: Minikube or K3d?

| Scenario | Choose |
|----------|--------|
| **New to Kubernetes** | Minikube (current) |
| **Want speed** | K3d |
| **Need high resources** | Minikube |
| **Development focus** | K3d |
| **Production simulation** | Minikube |

**Current recommendation**: Keep Minikube for now since it's running well. Try K3d when you need faster iteration!
