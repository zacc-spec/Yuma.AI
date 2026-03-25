# Kubernetes Deployment Guide for Yuma.AI

## Quick Start

### Prerequisites
- Kubernetes cluster running (Minikube or Docker Desktop K8s)
- kubectl configured
- Docker images available: `docker-backend:latest` and `docker-frontend:latest`

### Deploy All at Once
```bash
# From Yuma.AI root directory
kubectl apply -f packages/kubernetes/

# Verify deployment
kubectl get all -n yuma-ai
```

### Deploy Step by Step
```bash
# 1. Create namespace
kubectl apply -f packages/kubernetes/01-namespace.yaml

# 2. Create config
kubectl apply -f packages/kubernetes/02-configmap.yaml

# 3. Deploy backend
kubectl apply -f packages/kubernetes/03-backend-deployment.yaml
kubectl apply -f packages/kubernetes/04-backend-service.yaml

# 4. Deploy frontend
kubectl apply -f packages/kubernetes/05-frontend-deployment.yaml
kubectl apply -f packages/kubernetes/06-frontend-service.yaml
```

## Accessing the Application

### Minikube
```bash
# Get frontend URL
minikube service yuma-frontend -n yuma-ai

# Get backend URL (internal)
kubectl port-forward svc/yuma-backend 5000:5000 -n yuma-ai
curl http://localhost:5000/health
```

### Cloud Deployment (AWS/GCP/Azure)
```bash
# Get LoadBalancer IP
kubectl get service yuma-frontend -n yuma-ai
# EXTERNAL-IP is your public URL
```

## Useful Commands

### Monitor Deployments
```bash
# Check status
kubectl get deployment -n yuma-ai
kubectl get pods -n yuma-ai
kubectl get svc -n yuma-ai

# Watch in real-time
kubectl get pods -n yuma-ai -w

# See detailed info
kubectl describe deployment yuma-backend -n yuma-ai
kubectl describe pod <pod-name> -n yuma-ai
```

### View Logs
```bash
# Backend logs
kubectl logs deployment/yuma-backend -n yuma-ai
kubectl logs deployment/yuma-backend -n yuma-ai -f  # Follow

# Frontend logs
kubectl logs deployment/yuma-frontend -n yuma-ai
```

### Debug Pods
```bash
# Execute command in pod
kubectl exec -it <pod-name> -n yuma-ai -- /bin/sh

# Port forward for testing
kubectl port-forward svc/yuma-backend 5000:5000 -n yuma-ai

# Get pod details
kubectl describe pod <pod-name> -n yuma-ai
```

### Update Deployments

**Scale replicas**
```bash
kubectl scale deployment yuma-backend -n yuma-ai --replicas=3
kubectl scale deployment yuma-frontend -n yuma-ai --replicas=3
```

**Update image**
```bash
kubectl set image deployment/yuma-backend yuma-backend=docker-backend:v2 -n yuma-ai
```

**Update config**
```bash
kubectl set env configmap/yuma-config FLASK_ENV=production -n yuma-ai
```

**Rolling update (watch zero-downtime updates)**
```bash
kubectl rollout status deployment/yuma-backend -n yuma-ai -w
```

## Clean Up

```bash
# Delete everything in yuma-ai namespace
kubectl delete namespace yuma-ai

# Delete specific resource
kubectl delete deployment yuma-backend -n yuma-ai
```

## Common Issues & Fixes

### Pods not starting
```bash
# Check events
kubectl describe pod <pod-name> -n yuma-ai

# Common issues:
# - Image not found: kubectl must be able to pull docker-backend/docker-frontend
# - Port already in use: Check existing services
# - Resource limits: Increase memory/cpu in manifest
```

### Can't access frontend from browser
```bash
# On Minikube, get IP
minikube ip

# Try:
minikube service yuma-frontend -n yuma-ai
```

### Frontend can't reach backend
```bash
# Backend should be at: http://yuma-backend:5000 (inside cluster)
# Check network policy and service DNS
kubectl exec -it <frontend-pod> -n yuma-ai -- nslookup yuma-backend
```

## Next Steps (When You Get Team Input)

- [ ] Add Kubernetes Secrets for API keys
- [ ] Add database StatefulSet (PostgreSQL)
- [ ] Add Ingress controller for better routing
- [ ] Add monitoring (Prometheus + Grafana)
- [ ] Add persistent volumes for data
- [ ] Set up CI/CD pipeline to auto-deploy
- [ ] Configure resource quotas per namespace
