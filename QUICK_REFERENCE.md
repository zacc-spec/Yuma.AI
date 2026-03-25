# YUMA.AI - QUICK REFERENCE GUIDE

## 🚀 Daily Development Workflow

### Start Development
```bash
cd ~/Yuma.AI
tilt up
```
Then press **space** to open dashboard at http://localhost:10350

### Make Code Changes
```
Edit code in VS Code
↓ (Ctrl+S save)
Tilt detects changes
↓
Docker rebuilds image
↓
Kubernetes redeploys
↓
See live updates immediately!
```

### Access Services
- **Backend API:** http://localhost:5000
- **Frontend:** http://localhost:3000
- **Tilt Dashboard:** http://localhost:10350
- **Database:** localhost:5432

### Commit & Push
```bash
git add .
git commit -m "Your message"
git push origin main
```

---

## 📋 Tool Quick Reference

### Tilt (Development)
```bash
tilt up                 # Start
tilt down               # Stop
tilt logs               # View all logs
tilt logs backend       # View specific logs
tilt trigger backend    # Force rebuild
```

### Kubernetes
```bash
kubectl get pods -n yuma-ai           # List pods
kubectl describe pod <pod> -n yuma-ai # Details
kubectl logs <pod> -n yuma-ai         # Pod logs
kubectl delete pod <pod> -n yuma-ai   # Delete pod
```

### Helm
```bash
helm list -n yuma-ai                  # List releases
helm status my-db -n yuma-ai          # Release status
helm upgrade my-db bitnami/postgresql # Update
```

### Docker
```bash
docker images                         # List images
docker ps                            # Running containers
docker build -f backend/Dockerfile . # Build image
```

### Terraform
```bash
cd packages/terraform
terraform plan                       # Preview changes
terraform apply                      # Apply changes
terraform destroy                    # Delete resources
```

### GitHub
```bash
gh repo view zacc-spec/Yuma.AI      # View repo
gh pr create                         # Create PR
gh issue list                        # List issues
```

---

## 🔧 Common Tasks

### View Backend Logs
```bash
kubectl logs -f deployment/yuma-backend -n yuma-ai
# or via Tilt
tilt logs yuma-backend
```

### Connect to Database
```bash
# Get password
export PG_PASSWORD=$(kubectl get secret my-db-postgresql -n yuma-ai -o jsonpath="{.data.postgres-password}" | base64 -d)

# Port forward
kubectl port-forward svc/my-db-postgresql 5432:5432 -n yuma-ai

# Connect in another terminal
psql -h localhost -U postgres -d postgres
# Enter password when prompted
```

### Check Pod Status
```bash
kubectl get pods -n yuma-ai -o wide
kubectl describe pod <pod-name> -n yuma-ai
```

### Restart Service
```bash
kubectl rollout restart deployment/yuma-backend -n yuma-ai
```

### View Resource Usage
```bash
kubectl top pods -n yuma-ai
kubectl top nodes
```

---

## 📊 System Architecture

```
┌─────────────────────────────────────────┐
│          YOUR CODE (VS Code)            │
├─────────────────────────────────────────┤
│  backend/main.py | frontend/src/App.jsx│
└────────────┬────────────────────────────┘
             │
             ↓ (Save file)
┌─────────────────────────────────────────┐
│     TILT (Watch & Auto-Rebuild)         │
├─────────────────────────────────────────┤
│  Detects changes, triggers builds       │
└────────────┬────────────────────────────┘
             │
             ↓
┌─────────────────────────────────────────┐
│  DOCKER (Build Container Images)        │
├─────────────────────────────────────────┤
│  docker-backend | docker-frontend       │
└────────────┬────────────────────────────┘
             │
             ↓
┌─────────────────────────────────────────┐
│ KUBERNETES/MINIKUBE (Orchestrate)       │
├─────────────────────────────────────────┤
│  Pod: yuma-backend (Flask on :5000)     │
│  Pod: yuma-frontend (React on :3000)    │
│  Pod: my-db-postgresql (on :5432)       │
│  Service: LoadBalancer, ClusterIP       │
└────────────┬────────────────────────────┘
             │
             ↓
┌─────────────────────────────────────────┐
│ TILT DASHBOARD (Real-time Status)       │
├─────────────────────────────────────────┤
│  http://localhost:10350                 │
│  ✓ Pod status  ✓ Logs  ✓ Metrics       │
└─────────────────────────────────────────┘
```

---

## ⚠️ What's Missing (Priority Order)

### Phase 1: Testing
- [ ] pytest for backend
- [ ] Jest for frontend
- [ ] Test coverage reports

### Phase 2: Security
- [ ] Kubernetes Secrets for sensitive data
- [ ] Authentication (JWT tokens)
- [ ] API key management

### Phase 3: CI/CD
- [ ] GitHub Actions workflow
- [ ] Automated tests on push
- [ ] Auto-deploy to staging

### Phase 4: Monitoring
- [ ] Prometheus (metrics)
- [ ] Grafana (dashboards)
- [ ] Loki (logs aggregation)
- [ ] Alerts

### Phase 5: Production Ready
- [ ] API documentation (Swagger)
- [ ] Database migrations (Alembic)
- [ ] Load testing
- [ ] Backup strategy

---

## 🆘 Troubleshooting

### Tilt won't start (port in use)
```bash
killall tilt
TILT_PORT=10351 tilt up  # Use different port
```

### Pod keeps restarting
```bash
kubectl describe pod <pod-name> -n yuma-ai  # Check events
kubectl logs <pod-name> -n yuma-ai          # Check logs
```

### Docker image too large
```bash
docker images | grep docker-  # Check sizes
# Use multi-stage builds to reduce size
```

### Database connection failed
```bash
kubectl get svc -n yuma-ai                  # Check service
kubectl port-forward svc/my-db-postgresql 5432:5432 -n yuma-ai
# Test connection in new terminal
```

### Code changes not reflecting
```bash
# Make sure Tilt is watching:
tilt logs  # Check for errors
tilt trigger backend  # Force rebuild
```

---

## 📞 Getting Help

### Check Logs
```bash
# Application logs
tilt logs yuma-backend
tilt logs yuma-frontend

# System logs
kubectl describe pod <pod> -n yuma-ai
kubectl get events -n yuma-ai
```

### Run Diagnostics
```bash
tilt doctor
kubectl cluster-info
docker ps
```

### Documentation Files
- **ARCHITECTURE_GUIDE.md** - How everything works together
- **TOOLKIT_STATUS.md** - Tools installation status
- **packages/kubernetes/README.md** - Kubernetes guide
- **packages/terraform/README.md** - Infrastructure as Code
- **packages/helm/README.md** - Package manager
- **packages/tilt/README.md** - Development environment

---

## 🎯 You're Ready To:

✅ **Develop** - Edit code, auto-rebuild, see changes instantly  
✅ **Test locally** - Full Kubernetes setup on your machine  
✅ **Deploy to K8s** - Minikube environment configured  
✅ **Manage infrastructure** - Terraform ready for cloud deployment  
✅ **Package applications** - Helm charts available  
✅ **Version control** - GitHub integration complete  

🚀 **Start with:** `tilt up`
