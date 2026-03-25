#!/bin/bash
# Load Kubernetes configuration for Yuma.AI workspace

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export KUBECONFIG="${SCRIPT_DIR}/.kubeconfig"

echo "✅ Kubernetes configured for Yuma.AI workspace"
echo "   KUBECONFIG: $KUBECONFIG"
kubectl version --client --short 2>/dev/null || echo "   kubectl is ready"
