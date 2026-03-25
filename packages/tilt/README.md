# Tilt - Local Kubernetes Development

Tilt is a tool for local Kubernetes development that watches your files and automatically builds/deploys changes. It's like "docker-compose for Kubernetes".

## Quick Start

### 1. Verify Installation
```bash
tilt version
```

### 2. Start Tilt
```bash
cd ~/Yuma.AI
tilt up
```

This will:
- Open Tilt UI at http://localhost:10350
- Build Docker images for backend & frontend
- Deploy to Minikube
- Watch for file changes
- Auto-rebuild on any code changes

### 3. View the Services
- **Backend API**: http://localhost:5000
- **Frontend**: http://localhost:3000
- **Tilt Dashboard**: http://localhost:10350

### 4. Stop Tilt
```bash
tilt down
```

## Core Commands

| Command | Purpose |
|---------|---------|
| `tilt up` | Start development environment |
| `tilt down` | Stop and cleanup |
| `tilt logs` | View logs |
| `tilt logs <service>` | View specific service logs |
| `tilt trigger <service>` | Force rebuild |
| `tilt alpha analytics` | Usage analytics |
| `tilt doctor` | Diagnostic info |
| `tilt ci` | CI/batch mode |

## How Tilt Works for Yuma.AI

1. **Watches Files**
   - Backend: `./backend/**/*.py`
   - Frontend: `./frontend/src/**`, `./frontend/*.js`

2. **Rebuilds on Changes**
   - Detects code changes
   - Rebuilds Docker images
   - Redeploys to Kubernetes

3. **Live Feedback**
   - Dashboard at localhost:10350
   - Real-time build status
   - Log streaming
   - Error reporting

## Tiltfile Overview

Our `Tiltfile` in root directory:
- Defines backend Docker build
- Defines frontend Docker build
- Points to Kubernetes manifests
- Sets port forwards (5000, 3000)
- Configures namespace (yuma-ai)

## Features

### Hot Reload
- Change backend code → Tilt rebuilds automatically
- Change frontend code → Tilt rebuilds and refreshes browser

### Port Forwarding
- Backend at `localhost:5000`
- Frontend at `localhost:3000`
- No need for minikube service commands

### Logging
```bash
tilt logs yuma-backend    # Backend logs
tilt logs yuma-frontend   # Frontend logs
tilt logs                 # All logs
```

### Dashboard
- Visual status of all services
- Real-time build output
- Log viewer
- Resource usage
- Manual triggers

## Development Workflow

```bash
# 1. Start Tilt dev environment
tilt up

# 2. Open http://localhost:5000 (backend test)
# 3. Open http://localhost:3000 (frontend)

# 4. Make code changes in VS Code
# 5. Tilt automatically rebuilds
#    - Check Tilt Dashboard for status
#    - View logs: tilt logs

# 6. When done
tilt down
```

## Tilt vs kubectl

| Task | Tilt | kubectl |
|------|------|---------|
| Development setup | ✅ One command | ❌ Manual |
| Watch files | ✅ Automatic | ❌ Manual |
| Auto rebuild | ✅ Yes | ❌ Manual |
| Port forward | ✅ Automatic | ❌ Manual |
| Logs | ✅ Dashboard | ❌ CLI only |
| Live updates | ✅ Yes | ❌ No |

## Troubleshooting

**"Tilt can't connect to Kubernetes"**
```bash
kubectl config current-context  # Verify minikube is active
minikube start                   # Start if not running
```

**"Port 10350 already in use"**
```bash
tilt up -- --port 10351  # Use different port
```

**"Docker build failing"**
```bash
docker images              # Check available images
docker build -f backend/Dockerfile ./backend  # Test build manually
```

**"Services not deploying"**
```bash
tilt logs yuma-backend    # Check deployment logs
kubectl describe pods -n yuma-ai  # Check pod details
```

## CLI Installation Verified ✅

```
Version: v0.37.0
Location: /opt/homebrew/bin/tilt
Setup: Tiltfile configured for Yuma.AI
Status: Ready to use
```

## Resources

- [Tilt Official Docs](https://docs.tilt.dev/)
- [Tilt GitHub](https://github.com/tilt-dev/tilt)
- [Tilt Community Slack](https://tilt.dev/community)
