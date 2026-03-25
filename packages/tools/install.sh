#!/bin/bash
# Yuma.AI Project Setup Script
# Installs and configures all dependencies for development

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🚀 Setting up Yuma.AI Project..."
echo "📁 Project Root: $PROJECT_ROOT"

# Python dependencies
echo "📦 Installing Python dependencies..."
cd "$PROJECT_ROOT"
pip3 install -r packages/dependencies/requirements.txt

# Kubernetes configuration
echo "🐳 Configuring Kubernetes..."
source ./setup-kubernetes.sh

echo "✅ Setup complete!"
echo ""
echo "📍 Next steps:"
echo "   1. Copy backend/.env.example to backend/.env and fill in API keys"
echo "   2. Run backend: python3 backend/main.py"
echo "   3. Run frontend: cd frontend && npm install && npm start"
