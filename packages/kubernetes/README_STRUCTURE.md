# File Organization Reference

## Kubernetes Manifests Explained

```
01-namespace.yaml
├─ Creates: yuma-ai namespace
├─ Purpose: Isolate all Yuma.AI resources
└─ Deploy first: YES (dependency for others)

02-configmap.yaml
├─ Creates: yuma-config ConfigMap
├─ Contains: Environment variables
├─ Used by: Backend & Frontend deployments
├─ Update with: kubectl set env configmap/yuma-config ...
└─ Deploy before: Deployments (they reference it)

03-backend-deployment.yaml
├─ Creates: Flask API pods
├─ Replicas: 1 (change for HA)
├─ Image: docker-backend:latest
├─ Port: 5000
├─ Health checks: /health endpoint
└─ Needs: ConfigMap, Backend Service

04-backend-service.yaml
├─ Creates: Service for backend pods
├─ Type: ClusterIP (internal only)
├─ Makes: http://yuma-backend:5000 available in cluster
└─ Used by: Frontend pods to reach backend

05-frontend-deployment.yaml
├─ Creates: Nginx + React pods
├─ Replicas: 1 (change for HA)
├─ Image: docker-frontend:latest
├─ Port: 3000
├─ Serves: Pre-built React app
└─ Needs: ConfigMap, Frontend Service

06-frontend-service.yaml
├─ Creates: Service for frontend pods
├─ Type: LoadBalancer (external access)
├─ Port: 3000 (external)
├─ On Minikube: Creates NodePort
└─ On Cloud: Provisions LoadBalancer

DEPLOYMENT_GUIDE.md
├─ Quick commands for deploying
├─ Troubleshooting tips
├─ Common kubectl patterns
└─ Escalation steps for common issues
```

## How to Modify

### Change number of replicas (for HA)
In `03-backend-deployment.yaml` and `05-frontend-deployment.yaml`:
```yaml
spec:
  replicas: 1  # Change to 3 for 3 copies
```

### Change environment variables
In `02-configmap.yaml`:
```yaml
data:
  FLASK_ENV: "development"  # Edit here
  NEW_VAR: "new_value"       # Add here
```

### Change service type
In `06-frontend-service.yaml`:
```yaml
spec:
  type: LoadBalancer  # Options: ClusterIP, NodePort, LoadBalancer
```

### Add secrets (later)
Create: `07-secrets.yaml`
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: yuma-secrets
  namespace: yuma-ai
type: Opaque
stringData:
  anthropic-api-key: "your-key-here"
```

Then reference in deployment:
```yaml
env:
- name: ANTHROPIC_API_KEY
  valueFrom:
    secretKeyRef:
      name: yuma-secrets
      key: anthropic-api-key
```

### Add database (later)
Create: `08-postgres-statefulset.yaml`
Include: PersistentVolumeClaim, StatefulSet, Service

### Add monitoring (later)
Create: `09-prometheus-config.yaml`, `10-grafana-deployment.yaml`

## Deployment Order

```
Always in this order:
1. 01-namespace.yaml       (Create namespace first)
2. 02-configmap.yaml       (Apps need this config)
3. 03-backend-deployment.yaml + 04-backend-service.yaml
4. 05-frontend-deployment.yaml + 06-frontend-service.yaml

Optional (when needed):
5. 07-secrets.yaml         (For API keys)
6. 08-postgres-*.yaml      (For database)
7. 09-monitoring-*.yaml    (For observability)
```

## Quick Deploy Commands

```bash
# Deploy everything in one go
kubectl apply -f packages/kubernetes/

# Deploy with each manifest numbered (enforces order)
kubectl apply -f packages/kubernetes/01-namespace.yaml
kubectl apply -f packages/kubernetes/02-configmap.yaml
kubectl apply -f packages/kubernetes/03-backend-deployment.yaml
kubectl apply -f packages/kubernetes/04-backend-service.yaml
kubectl apply -f packages/kubernetes/05-frontend-deployment.yaml
kubectl apply -f packages/kubernetes/06-frontend-service.yaml

# Verify all created
kubectl get all -n yuma-ai
```
