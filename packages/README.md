# Packages Directory

Centralized location for all project dependencies, tools, and configurations.

## Structure

```
packages/
├── dependencies/        # Python pip dependencies
│   └── requirements.txt
├── node/               # Node.js/npm dependencies
│   └── package-lock.json (shared reference)
├── docker/             # Docker images and configurations
│   ├── Dockerfile (if needed)
│   └── docker-compose.yml
├── kubernetes/         # Kubernetes manifests and configs
│   ├── deployments/
│   ├── services/
│   └── configmaps/
├── tools/              # Scripts and CLI tools
│   ├── install.sh
│   └── setup.sh
└── README.md (this file)
```

## Setup Instructions

### 1. Python Dependencies
```bash
cd packages && pip3 install -r dependencies/requirements.txt
```

### 2. Node/Frontend Dependencies
```bash
cd frontend && npm install
# (uses frontend/package.json)
```

### 3. Docker Setup (optional)
```bash
docker-compose -f packages/docker/docker-compose.yml up
```

### 4. Kubernetes Configuration (if using K8s)
```bash
kubectl apply -f packages/kubernetes/
```

### 5. Tools & Scripts
```bash
source packages/tools/install.sh
```

## Best Practices

- ✅ **All dependencies are stored in one place** — No scatter across the system
- ✅ **Version controlled** — Everything committed to git
- ✅ **Easy to replicate** — New team members follow the same path
- ✅ **CI/CD friendly** — Scripts can reference these locations
- ✅ **Isolated from system** — Won't interfere with other projects

## Adding New Dependencies

### Adding Python packages:
1. Update `packages/dependencies/requirements.txt`
2. Run `pip3 install -r packages/dependencies/requirements.txt`

### Adding npm packages:
1. Add to `frontend/package.json`
2. Ensure reference is documented in `packages/node/`

### Adding Docker images:
1. Update `packages/docker/docker-compose.yml`
2. Keep custom Dockerfiles in `packages/docker/`

### Adding tools/scripts:
1. Add scripts to `packages/tools/`
2. Update this README with usage instructions
