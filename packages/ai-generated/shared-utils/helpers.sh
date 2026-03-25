#!/bin/bash
#
# Shared Bash Utilities
# Purpose: Common functions for all shell scripts
# Usage: source helpers.sh
#

# 🎨 Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 📝 LOGGING FUNCTIONS

function log_info() {
    echo -e "${BLUE}ℹ️  INFO${NC}: $1"
}

function log_success() {
    echo -e "${GREEN}✅ SUCCESS${NC}: $1"
}

function log_warn() {
    echo -e "${YELLOW}⚠️  WARN${NC}: $1"
}

function log_error() {
    echo -e "${RED}❌ ERROR${NC}: $1" >&2
}

# 🔍 VALIDATION FUNCTIONS

function validate_env_vars() {
    local missing_vars=()
    for var in "$@"; do
        if [[ -z "${!var}" ]]; then
            missing_vars+=("$var")
        fi
    done
    
    if [[ ${#missing_vars[@]} -gt 0 ]]; then
        log_error "Missing environment variables: ${missing_vars[*]}"
        return 1
    fi
    
    log_info "All required environment variables are set"
    return 0
}

function validate_command_exists() {
    if ! command -v "$1" &> /dev/null; then
        log_error "Command not found: $1"
        return 1
    fi
    log_info "Command exists: $1"
    return 0
}

# ☸️ KUBERNETES FUNCTIONS

function safe_kubectl() {
    local cmd="$*"
    log_info "Running: kubectl $cmd"
    
    if kubectl $cmd; then
        return 0
    else
        log_error "kubectl command failed: $cmd"
        return 1
    fi
}

function check_pod_status() {
    local deployment=$1
    local namespace=${2:-yuma-ai}
    
    log_info "Checking status of deployment: $deployment in namespace: $namespace"
    
    local ready=$(kubectl get deployment "$deployment" -n "$namespace" -o jsonpath='{.status.readyReplicas}' 2>/dev/null || echo "0")
    local desired=$(kubectl get deployment "$deployment" -n "$namespace" -o jsonpath='{.spec.replicas}' 2>/dev/null || echo "0")
    
    if [[ "$ready" -eq "$desired" && "$desired" -gt 0 ]]; then
        log_success "Pod is healthy: $desired / $desired replicas ready"
        return 0
    else
        log_warn "Pod status: $ready / $desired replicas ready"
        return 1
    fi
}

function get_pod_logs() {
    local deployment=$1
    local namespace=${2:-yuma-ai}
    
    log_info "Getting logs from deployment: $deployment"
    kubectl logs -f deployment/"$deployment" -n "$namespace" --all-containers=true --max-log-requests=10 || log_error "Failed to get logs"
}

function wait_for_pods() {
    local deployment=$1
    local namespace=${2:-yuma-ai}
    local timeout=${3:-300}
    
    log_info "Waiting for deployment $deployment to be ready (timeout: ${timeout}s)"
    
    if kubectl rollout status deployment/"$deployment" -n "$namespace" --timeout="${timeout}s"; then
        log_success "Deployment is ready!"
        return 0
    else
        log_error "Deployment failed to become ready"
        return 1
    fi
}

# 🔧 HELM FUNCTIONS

function safe_helm_deploy() {
    local chart=$1
    local release=${2:-$chart}
    local namespace=${3:-yuma-ai}
    
    log_info "Deploying Helm chart: $chart (release: $release)"
    
    if helm upgrade --install "$release" "$chart" -n "$namespace"; then
        log_success "Helm deployment successful"
        return 0
    else
        log_error "Helm deployment failed"
        return 1
    fi
}

function validate_helm_chart() {
    local chart=$1
    
    log_info "Validating Helm chart: $chart"
    
    if helm lint "$chart"; then
        log_success "Helm chart is valid"
        return 0
    else
        log_error "Helm chart validation failed"
        return 1
    fi
}

# 🔄 UTILITY FUNCTIONS

function retry() {
    local max_attempts=3
    local wait_seconds=5
    local attempt=1
    
    while [[ $attempt -le $max_attempts ]]; do
        log_info "Attempt $attempt of $max_attempts: $*"
        
        if "$@"; then
            log_success "Command succeeded"
            return 0
        fi
        
        if [[ $attempt -lt $max_attempts ]]; then
            log_warn "Command failed, retrying in ${wait_seconds}s..."
            sleep "$wait_seconds"
        fi
        
        ((attempt++))
    done
    
    log_error "Command failed after $max_attempts attempts"
    return 1
}

function wait_for_endpoint() {
    local url=$1
    local timeout=${2:-60}
    local start_time=$(date +%s)
    
    log_info "Waiting for endpoint to be ready: $url (timeout: ${timeout}s)"
    
    while true; do
        if curl -sf "$url" > /dev/null 2>&1; then
            log_success "Endpoint is ready!"
            return 0
        fi
        
        local current_time=$(date +%s)
        local elapsed=$((current_time - start_time))
        
        if [[ $elapsed -gt $timeout ]]; then
            log_error "Endpoint not ready after ${timeout}s"
            return 1
        fi
        
        sleep 2
    done
}

# 📋 FILE FUNCTIONS

function validate_yaml() {
    local file=$1
    
    if [[ ! -f "$file" ]]; then
        log_error "File not found: $file"
        return 1
    fi
    
    log_info "Validating YAML: $file"
    
    if python3 -c "import yaml; yaml.safe_load(open('$file'))" 2>/dev/null; then
        log_success "YAML is valid"
        return 0
    else
        log_error "YAML validation failed"
        return 1
    fi
}

function validate_json() {
    local file=$1
    
    if [[ ! -f "$file" ]]; then
        log_error "File not found: $file"
        return 1
    fi
    
    log_info "Validating JSON: $file"
    
    if python3 -c "import json; json.load(open('$file'))" 2>/dev/null; then
        log_success "JSON is valid"
        return 0
    else
        log_error "JSON validation failed"
        return 1
    fi
}

# 🚀 DEPLOYMENT HELPERS

function check_deployment_readiness() {
    local deployment=$1
    local namespace=${2:-yuma-ai}
    
    log_info "Checking deployment readiness: $deployment"
    
    if check_pod_status "$deployment" "$namespace" && wait_for_pods "$deployment" "$namespace"; then
        log_success "Deployment is fully ready"
        return 0
    else
        log_error "Deployment is not ready"
        return 1
    fi
}

# Export functions for use in sourced scripts
export -f log_info log_success log_warn log_error
export -f validate_env_vars validate_command_exists
export -f safe_kubectl check_pod_status get_pod_logs wait_for_pods
export -f safe_helm_deploy validate_helm_chart
export -f retry wait_for_endpoint
export -f validate_yaml validate_json
export -f check_deployment_readiness
