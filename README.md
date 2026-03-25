# Yuma.AI

A full-stack Python application leveraging Claude AI capabilities.

## Project Structure

```
Yuma.AI/
├── backend/              # Python backend application
├── frontend/             # Frontend application
├── packages/
│   └── dependencies/     # External dependencies and packages
├── README.md
└── .gitignore
```

## Getting Started

### Prerequisites
- Python 3.10+
- Node.js 18+ (for frontend)
- Docker & Kubernetes (via Minikube)

### Setup

1. **Install Python dependencies:**
   ```bash
   pip install -r packages/dependencies/requirements.txt
   ```

2. **Run backend:**
   ```bash
   python backend/main.py
   ```

3. **Run frontend:**
   ```bash
   cd frontend && npm install && npm start
   ```

4. **Configure Kubernetes (workspace-specific):**
   ```bash
   source ./setup-kubernetes.sh
   ```
   Or manually set:
   ```bash
   export KUBECONFIG=~./Yuma.AI/.kubeconfig
   ```

## Development

This project is set up for development with Claude Code integration. Open in VS Code to leverage AI-powered code assistance.
