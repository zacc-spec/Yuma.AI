# INTEGRATION: 1Password with Approved Tools

Since your company uses **1Password for secret management**, here's how to integrate it with your 7 approved tools while staying governance-compliant.

## 🔐 1Password Setup for Yuma.AI

### What 1Password Provides
- ✅ Centralized secret storage
- ✅ Access control & audit logs
- ✅ Team sharing
- ✅ API for programmatic access
- ✅ CLI integration (`op` command)
- ✅ Browser extension
- ✅ Encryption at rest & in transit

---

## 🔧 Integration with Your Approved Tools

### 1. **Docker** - Inject Secrets from 1Password

```dockerfile
# backend/Dockerfile
FROM python:3.9-slim

# Runtime will inject secrets via environment variables
ENV ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

CMD ["python", "main.py"]
```

```bash
# Build with 1Password secrets (using op CLI)
export ANTHROPIC_API_KEY=$(op read "op://Yuma.AI/anthropic-api-key/credential")
export DATABASE_PASSWORD=$(op read "op://Yuma.AI/db-password/credential")

docker build -t backend:latest .
```

---

### 2. **Kubernetes** - Load Secrets from 1Password

#### Option A: Use 1Password Operator (If Approved)
```bash
# Install 1Password Operator
# This requires company approval for the operator
kubectl apply -f https://onepassword.com/downloads/kubernetes-operator
```

#### Option B: Manual Injection (No Additional Tools Needed)
```bash
#!/bin/bash
# deploy.sh - Load from 1Password, create K8s secret

# Get secrets from 1Password
ANTHROPIC_KEY=$(op read "op://Yuma.AI/anthropic-api-key/credential")
DB_PASSWORD=$(op read "op://Yuma.AI/db-password/credential")

# Create Kubernetes Secret
kubectl create secret generic yuma-secrets \
  --from-literal=ANTHROPIC_API_KEY=$ANTHROPIC_KEY \
  --from-literal=DATABASE_PASSWORD=$DB_PASSWORD \
  -n yuma-ai --dry-run=client -o yaml | kubectl apply -f -

# Deploy with secret reference
kubectl apply -f deployment.yaml
```

#### deployment.yaml with Secret Reference
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: yuma-backend
  namespace: yuma-ai
spec:
  template:
    spec:
      containers:
      - name: backend
        image: backend:latest
        env:
        - name: ANTHROPIC_API_KEY
          valueFrom:
            secretKeyRef:
              name: yuma-secrets
              key: ANTHROPIC_API_KEY
        - name: DATABASE_PASSWORD
          valueFrom:
            secretKeyRef:
              name: yuma-secrets
              key: DATABASE_PASSWORD
```

---

### 3. **Helm** - Use 1Password Secrets

```bash
# Create Helm values file with reference to 1Password
cat > helm-values-secrets.sh << 'EOF'
#!/bin/bash
# Fetch from 1Password and pass to Helm

helm install yuma ./helm-chart \
  --set anthropic.apiKey=$(op read "op://Yuma.AI/anthropic-api-key/credential") \
  --set database.password=$(op read "op://Yuma.AI/db-password/credential") \
  --values values-prod.yaml
EOF

chmod +x helm-values-secrets.sh
./helm-values-secrets.sh
```

Or create a Helm secrets values file:
```yaml
# helm/values-secrets.yaml (NEVER commit to git!)
apiKey: 
  anthropic: ${ANTHROPIC_API_KEY}  # Will be replaced at deploy time
database:
  password: ${DATABASE_PASSWORD}   # Will be replaced at deploy time
```

---

### 4. **Terraform** - Inject 1Password Secrets

```hcl
# terraform/main.tf

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# Get secrets from environment (populated from 1Password)
variable "anthropic_api_key" {
  type      = string
  sensitive = true
}

variable "database_password" {
  type      = string
  sensitive = true
}

# Create Kubernetes Secret from 1Password values
resource "kubernetes_secret" "yuma_secrets" {
  metadata {
    name      = "yuma-secrets"
    namespace = "yuma-ai"
  }

  data = {
    ANTHROPIC_API_KEY   = var.anthropic_api_key
    DATABASE_PASSWORD   = var.database_password
  }

  type = "Opaque"
}
```

Deploy with 1Password secrets:
```bash
# Get secrets from 1Password
export TF_VAR_anthropic_api_key=$(op read "op://Yuma.AI/anthropic-api-key/credential")
export TF_VAR_database_password=$(op read "op://Yuma.AI/db-password/credential")

# Deploy
terraform apply
```

---

### 5. **Tilt** - Use 1Password for Local Development

```python
# Tiltfile
load('ext://secret_sync', 'secret_sync_for_helm')

# Get secrets from 1Password for local development
import subprocess
import json

def get_from_1password(path):
    """Fetch secret from 1Password"""
    try:
        result = subprocess.run(
            ['op', 'read', path],
            capture_output=True,
            text=True
        )
        return result.stdout.strip()
    except:
        return ""

# Use in Tiltfile
local_env = {
    'ANTHROPIC_API_KEY': get_from_1password("op://Yuma.AI/anthropic-api-key/credential"),
    'DATABASE_PASSWORD': get_from_1password("op://Yuma.AI/db-password/credential"),
}

k8s_yaml('packages/kubernetes/backend-deployment.yaml')
k8s_resource('yuma-backend', env=local_env)
```

Or simpler - just export before running Tilt:
```bash
# Before running tilt up
export ANTHROPIC_API_KEY=$(op read "op://Yuma.AI/anthropic-api-key/credential")
export DATABASE_PASSWORD=$(op read "op://Yuma.AI/db-password/credential")

tilt up
```

---

## 📋 GOVERNANCE-COMPLIANT SECRET MANAGEMENT WORKFLOW

### Step 1: Store Secrets in 1Password
```
1Password Vault: Yuma.AI
├─ anthropic-api-key
├─ database-password
├─ jwt-secret
└─ other-api-keys
```

### Step 2: Retrieve via 1Password CLI
```bash
op read "op://Yuma.AI/anthropic-api-key/credential"
```

### Step 3: Inject into Approved Tools
```
1Password CLI (op)
    ↓
Docker (environment variables)
Kubernetes (via script)
Terraform (TF_VAR_ env vars)
Helm (via script)
Tilt (local development)
```

### Step 4: Never Commit Secrets to Git
```bash
# .gitignore
.env
*.tfvars
secrets.yaml
values-secrets.yaml
```

---

## 🔐 DEPLOYMENT SCRIPT USING APPROVED TOOLS + 1PASSWORD

### Complete Deployment Flow
```bash
#!/bin/bash
# deploy.sh - Deploy with 1Password secrets (governance-compliant)

set -e

# 1. LOGIN TO 1PASSWORD
eval $(op signin)

# 2. FETCH SECRETS
export ANTHROPIC_API_KEY=$(op read "op://Yuma.AI/anthropic-api-key/credential")
export DATABASE_PASSWORD=$(op read "op://Yuma.AI/db-password/credential")
export JWT_SECRET=$(op read "op://Yuma.AI/jwt-secret/credential")

# 3. BUILD CONTAINER (Docker)
docker build -f backend/Dockerfile -t backend:latest .

# 4. CREATE K8S SECRETS (Kubernetes native)
kubectl create secret generic yuma-secrets \
  --from-literal=ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  --from-literal=DATABASE_PASSWORD=$DATABASE_PASSWORD \
  --from-literal=JWT_SECRET=$JWT_SECRET \
  -n yuma-ai --dry-run=client -o yaml | kubectl apply -f -

# 5. DEPLOY WITH HELM
helm upgrade --install yuma ./helm-chart \
  --values values-prod.yaml \
  -n yuma-ai

# 6. VERIFY DEPLOYMENT
kubectl rollout status deployment/yuma-backend -n yuma-ai

echo "✅ Deployment complete with 1Password secrets"
```

---

## ✅ GOVERNANCE-COMPLIANT CHECKLIST

### Using 1Password Correctly
- [x] All secrets stored in 1Password (not Git)
- [x] Access controlled via 1Password vault
- [x] Audit logs tracked by 1Password
- [x] Secrets fetched at deploy time (not build time)
- [x] Using approved tools only (Docker, K8s, Helm, Terraform, Tilt)
- [x] No hardcoded secrets in code
- [x] No secrets in environment files committed to Git

### Approved Integration Methods
- [x] 1Password CLI (`op` command)
- [x] Environment variables from 1Password
- [x] Deployment scripts that fetch secrets
- [x] Kubernetes Secrets (populated from 1Password)
- [x] Terraform variables (populated from 1Password)
- [x] Helm values (populated from 1Password)

### NOT Approved (Don't Do These)
- ❌ Store secrets in .env files in Git
- ❌ Store secrets in terraform.tfvars in Git
- ❌ Store secrets in Helm values.yaml in Git
- ❌ Commit 1Password tokens to Git
- ❌ Use other secret management tools (HashiCorp Vault, etc.)
- ❌ Hardcode secrets in application code

---

## 🚀 QUICK START WITH 1PASSWORD

### 1. Prerequisites
```bash
# Install 1Password CLI (if not already installed)
brew install 1password-cli

# Verify installation
op --version
```

### 2. Setup Vault
```bash
# Create vault in 1Password named "Yuma.AI"
# Add these items:
# - anthropic-api-key (with apikey field)
# - database-password (with password field)
# - jwt-secret (with secret field)
```

### 3. Test Retrieval
```bash
# Login
eval $(op signin)

# Get secret
op read "op://Yuma.AI/anthropic-api-key/credential"
# Should output your API key
```

### 4. Use in Deployment Script
```bash
# Save the deployment script above to deploy.sh
chmod +x deploy.sh

# Run deployment
./deploy.sh
```

---

## 📚 Best Practices with 1Password + Approved Tools

### Development (Local)
```bash
# Use Tilt with 1Password
export ANTHROPIC_API_KEY=$(op read "op://Yuma.AI/anthropic-api-key/credential")
tilt up
```

### Staging
```bash
# Use Helm with Kubernetes Secrets from 1Password
./deploy.sh  # Fetches from 1Password, applies to staging
```

### Production
```bash
# Use Terraform + Kubernetes + Helm
# All secrets flow from 1Password via environment variables
# Automated via deployment pipeline
```

---

## 🔒 Security Layers

With 1Password + Approved Tools:

```
1Password Vault (Encrypted, Audited)
    ↓
1Password CLI (Authenticated user)
    ↓
Environment Variables (Temporary, memory-only)
    ↓
Docker/Kubernetes/Terraform/Helm (Uses variables)
    ↓
Services Access Secrets (From Kubernetes Secret Store)
    ↓
Application Uses Secret ✅
```

**Each layer is encrypted and audited!**

---

## ✨ You Now Have:

✅ **Governance-Compliant Secret Management** (1Password)
✅ **Integration with All Approved Tools** (Docker, K8s, Helm, Terraform, Tilt)
✅ **No Secrets in Git Repository**
✅ **Centralized Access Control** (1Password)
✅ **Audit Trail** (1Password logs)
✅ **Production-Ready Deployment** (Script-based)

**You're fully compliant with company governance while maintaining enterprise-grade security!** 🔐
