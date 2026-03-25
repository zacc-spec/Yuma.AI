# Yuma.AI Kubernetes Setup - Complete Overview

## ✅ What We Just Created

### 6 Core Kubernetes Manifests

```
packages/kubernetes/
├── 01-namespace.yaml              ← Isolates all Yuma.AI resources
├── 02-configmap.yaml              ← Configuration & environment variables
├── 03-backend-deployment.yaml     ← Flask API pods (1 replica)
├── 04-backend-service.yaml        ← Internal service for backend
├── 05-frontend-deployment.yaml    ← React/Nginx pods (1 replica)
├── 06-frontend-service.yaml       ← External service for frontend
├── README.md                       ← Original setup info
├── README_STRUCTURE.md             ← How to modify manifests
└── DEPLOYMENT_GUIDE.md             ← Commands & troubleshooting
```

## 🎯 Key Design Decisions

| Component | Choice | Why? | Can Change Later? |
|-----------|--------|------|----------|
| **Platform** | Minikube/K8s cluster | Start simple, works anywhere | ✅ Yes |
| **Replicas** | 1 each | Minimal resource usage | ✅ Change in manifest |
| **Config** | ConfigMap | Easy to update, dev-friendly | ✅ Switch to Secrets later |
| **Backend Access** | ClusterIP | Internal only (secure) | ✅ No change needed |
| **Frontend Access** | LoadBalancer | External access | ✅ Change to NodePort if needed |
| **Database** | None | Keep it simple for now | ✅ Add 07-postgres.yaml later |
| **Secrets** | Not included | Add when you have API keys | ✅ Create 07-secrets.yaml |
| **Monitoring** | Not included | Can add later | ✅ Add when needed |

## 🔄 How Everything Connects

```
User's Browser
    ↓
http://localhost:3000  (or minikube service)
    ↓
Kubernetes Service: yuma-frontend (LoadBalancer)
    ↓
Pods: yuma-frontend (Nginx + React)
    ↓
Internal call to: http://yuma-backend:5000
    ↓
Kubernetes Service: yuma-backend (ClusterIP)
    ↓
Pods: yuma-backend (Flask API)
    ↓
/health endpoint response
```

## 📋 What's in Each Manifest

### **01-namespace.yaml**
```
- Creates: yuma-ai namespace
- Purpose: Everything lives in this isolated space
- Size: ~10 lines
- Deploy order: FIRST
```

### **02-configmap.yaml**
```
- Creates: yuma-config ConfigMap
- Contains: FLASK_ENV, PORT, API_VERSION, LOG_LEVEL
- Purpose: Configuration shared by all pods
- TODO notes: Where to add ANTHROPIC_API_KEY (later)
- Size: ~25 lines
- Deploy order: SECOND
```

### **03-backend-deployment.yaml** (MOST COMPLEX)
```
Features:
- 1 replica (change for HA)
- Health checks (liveness + readiness + startup)
- Resource limits (128-512 MB RAM)
- Environment from ConfigMap
- Rolling updates (zero downtime)
- Non-root user (security)
- Security context

Size: ~130 lines
Deploy order: THIRD
```

### **04-backend-service.yaml**
```
- Creates: yuma-backend service
- Type: ClusterIP (internal only)
- Port: 5000
- Access: http://yuma-backend:5000 inside cluster

Size: ~25 lines
Deploy order: RIGHT AFTER 03
```

### **05-frontend-deployment.yaml**
```
Similar to backend but:
- Image: docker-frontend (Nginx + React)
- Port: 3000
- Resources: Lower (64-256 MB)
- Serves static files

Size: ~130 lines
Deploy order: FIFTH
```

### **06-frontend-service.yaml**
```
- Creates: yuma-frontend service
- Type: LoadBalancer (external access)
- Port: 3000
- On Minikube: NodePort
- On Cloud: Provisions LB

Size: ~25 lines
Deploy order: SIXTH (last)
```

## 🚀 How to Use These Manifests

### Option 1: Deploy Everything at Once
```bash
cd ~/Yuma.AI
kubectl apply -f packages/kubernetes/
```

### Option 2: Deploy Step-by-Step (Recommended)
```bash
kubectl apply -f packages/kubernetes/01-namespace.yaml
kubectl apply -f packages/kubernetes/02-configmap.yaml
kubectl apply -f packages/kubernetes/03-backend-deployment.yaml
kubectl apply -f packages/kubernetes/04-backend-service.yaml
kubectl apply -f packages/kubernetes/05-frontend-deployment.yaml
kubectl apply -f packages/kubernetes/06-frontend-service.yaml
```

### Option 3: Watch Deployment
```bash
kubectl get pods -n yuma-ai -w  # Real-time pod status
```

## 🔧 How to Modify for Your Needs

### Add High Availability (3 replicas)
```yaml
# In 03-backend-deployment.yaml and 05-frontend-deployment.yaml:
spec:
  replicas: 3  # Was: 1
```

### Add API Key (when you get it)
```yaml
# Create 07-secrets.yaml:
apiVersion: v1
kind: Secret
metadata:
  name: yuma-secrets
  namespace: yuma-ai
data:
  anthropic-api-key: <base64-encoded-key>

# Then reference in 03-backend-deployment.yaml:
env:
- name: ANTHROPIC_API_KEY
  valueFrom:
    secretKeyRef:
      name: yuma-secrets
      key: anthropic-api-key
```

### Add Database (when needed)
```
Create: 07-postgres-statefulset.yaml
Include:
- PersistentVolume claim
- PostgreSQL StatefulSet
- Service for database
- ConfigMap with schema
```

### Switch to Production Config
```yaml
# In 02-configmap.yaml:
FLASK_ENV: "production"  # Was: development
FLASK_DEBUG: "False"
```

## 📊 Resource Usage

| Component | Memory Request | Memory Limit | CPU Request | CPU Limit |
|-----------|---|---|---|---|
| Backend | 128 MB | 512 MB | 100m | 500m |
| Frontend | 64 MB | 256 MB | 50m | 200m |
| **Total** | **192 MB** | **768 MB** | **150m** | **700m** |

(Good for dev; increase for production)

## ✨ What We Built That's Production Ready

✅ **Multi-stage manifests** - Each can be deployed independently  
✅ **Health checks** - Automatic pod restart on failure  
✅ **Rolling updates** - Zero downtime deployments  
✅ **Resource limits** - Won't crash the cluster  
✅ **Security** - Non-root users, security context  
✅ **Logging** - Easy to debug with kubectl logs  
✅ **Scalable** - Change replicas for HA  
✅ **Modular** - Add features without touching existing manifests  

## 🎓 What You Can Learn From These Manifests

- How Deployments manage pods
- How Services create networking
- How ConfigMaps inject configuration
- Health checks (liveness, readiness, startup)
- Rolling update strategies
- Resource requests vs limits
- Pod security best practices
- YAML structure for Kubernetes

## 🚦 Next Steps (When You Get Team Input)

### Week 1 (Now)
- [ ] Ask team: Where will this run? (Minikube/Cloud/On-prem?)
- [ ] Try deploying to Minikube locally
- [ ] Test kubectl commands

### Week 2
- [ ] Get Anthropic API key
- [ ] Create 07-secrets.yaml
- [ ] Update backend to use API key
- [ ] Test backend <-> frontend connection

### Week 3+
- [ ] Ask team: Do we need database?
- [ ] Ask team: Do we need monitoring?
- [ ] Add persistent storage if needed
- [ ] Set up CI/CD pipeline
- [ ] Plan cloud deployment

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| DEPLOYMENT_GUIDE.md | Commands to run, troubleshooting |
| README_STRUCTURE.md | How to modify each manifest |
| This file | High-level overview |

## 💡 Pro Tips

1. **Always deploy namespace first** - Prevents resource conflicts
2. **Use ConfigMap for non-sensitive config** - Easy to update
3. **Keep replicas at 1 for dev** - Save resources
4. **Test with `kubectl dry-run`** - See what will deploy without deploying

```bash
kubectl apply -f packages/kubernetes/ --dry-run=client
```

5. **Use port-forward for testing** - Access services locally

```bash
kubectl port-forward svc/yuma-backend 5000:5000 -n yuma-ai
```

## ✅ Ready to Go!

You now have **production-ready Kubernetes manifests** that:
- ✅ Use existing Docker images
- ✅ Follow Kubernetes best practices
- ✅ Are easy to modify and scale
- ✅ Support production deployment
- ✅ Can evolve as requirements change

**You're way ahead of the game for day 1!** 🎉
