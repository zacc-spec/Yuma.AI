#!/usr/bin/env python3
"""
Shared Python Utilities

Purpose: Common functions for all Python scripts
Usage: from common import *
"""

import os
import sys
import subprocess
import json
import yaml
from pathlib import Path
from typing import Dict, List, Any, Optional

# 🎨 COLORS
class Colors:
    """ANSI color codes for terminal output"""
    BLUE = '\033[0;34m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    RED = '\033[0;31m'
    END = '\033[0m'

# 📝 LOGGING

def log_info(msg: str) -> None:
    """Log informational message"""
    print(f"{Colors.BLUE}ℹ️  INFO{Colors.END}: {msg}")

def log_success(msg: str) -> None:
    """Log success message"""
    print(f"{Colors.GREEN}✅ SUCCESS{Colors.END}: {msg}")

def log_warn(msg: str) -> None:
    """Log warning message"""
    print(f"{Colors.YELLOW}⚠️  WARN{Colors.END}: {msg}")

def log_error(msg: str) -> None:
    """Log error message"""
    print(f"{Colors.RED}❌ ERROR{Colors.END}: {msg}", file=sys.stderr)

# 🔍 VALIDATION

def validate_env_vars(*vars: str) -> bool:
    """
    Validate that environment variables are set
    
    Args:
        *vars: Environment variable names
        
    Returns:
        True if all are set, False otherwise
    """
    missing = [v for v in vars if not os.getenv(v)]
    
    if missing:
        log_error(f"Missing environment variables: {', '.join(missing)}")
        return False
    
    log_info(f"All required environment variables are set")
    return True

def validate_command_exists(cmd: str) -> bool:
    """Check if a command exists in PATH"""
    result = subprocess.run(['which', cmd], capture_output=True)
    if result.returncode == 0:
        log_info(f"Command exists: {cmd}")
        return True
    else:
        log_error(f"Command not found: {cmd}")
        return False

# 🔧 SUBPROCESS UTILITIES

def safe_run(cmd: str, shell: bool = True, capture: bool = False) -> int:
    """
    Safely run a command with error handling
    
    Args:
        cmd: Command to run
        shell: Run in shell
        capture: Capture output
        
    Returns:
        Return code
    """
    log_info(f"Running: {cmd}")
    
    try:
        if capture:
            result = subprocess.run(cmd, shell=shell, capture_output=True, text=True)
            if result.stdout:
                print(result.stdout)
            if result.stderr:
                log_warn(result.stderr)
            return result.returncode
        else:
            return subprocess.run(cmd, shell=shell).returncode
    except Exception as e:
        log_error(f"Command failed: {e}")
        return 1

def run_kubectl(cmd: str) -> int:
    """Run kubectl command safely"""
    return safe_run(f"kubectl {cmd}")

def run_helm(cmd: str) -> int:
    """Run helm command safely"""
    return safe_run(f"helm {cmd}")

# 📋 FILE OPERATIONS

def load_env(filepath: str) -> Dict[str, str]:
    """Load environment variables from .env file"""
    log_info(f"Loading environment from: {filepath}")
    env_vars = {}
    
    if not os.path.exists(filepath):
        log_error(f"File not found: {filepath}")
        return env_vars
    
    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, value = line.split('=', 1)
                env_vars[key.strip()] = value.strip()
    
    log_success(f"Loaded {len(env_vars)} environment variables")
    return env_vars

def load_yaml(filepath: str) -> Optional[Dict]:
    """Load YAML file"""
    log_info(f"Loading YAML: {filepath}")
    
    try:
        with open(filepath, 'r') as f:
            data = yaml.safe_load(f)
        log_success(f"Loaded YAML successfully")
        return data
    except Exception as e:
        log_error(f"Failed to load YAML: {e}")
        return None

def load_json(filepath: str) -> Optional[Dict]:
    """Load JSON file"""
    log_info(f"Loading JSON: {filepath}")
    
    try:
        with open(filepath, 'r') as f:
            data = json.load(f)
        log_success(f"Loaded JSON successfully")
        return data
    except Exception as e:
        log_error(f"Failed to load JSON: {e}")
        return None

def validate_config(config: Dict[str, Any], required_keys: List[str]) -> bool:
    """
    Validate configuration has required keys
    
    Args:
        config: Configuration dictionary
        required_keys: List of required keys
        
    Returns:
        True if all required keys present
    """
    missing = [k for k in required_keys if k not in config]
    
    if missing:
        log_error(f"Missing configuration keys: {', '.join(missing)}")
        return False
    
    log_success("Configuration is valid")
    return True

# ☸️ KUBERNETES HELPERS

def get_pods(namespace: str = "yuma-ai") -> List[str]:
    """Get list of pod names in namespace"""
    log_info(f"Getting pods in namespace: {namespace}")
    
    result = subprocess.run(
        f"kubectl get pods -n {namespace} -o jsonpath='{{.items[*].metadata.name}}'",
        shell=True,
        capture_output=True,
        text=True
    )
    
    if result.returncode == 0:
        pods = result.stdout.split()
        log_success(f"Found {len(pods)} pods")
        return pods
    else:
        log_error("Failed to get pods")
        return []

def check_pod_status(deployment: str, namespace: str = "yuma-ai") -> bool:
    """Check if pod deployment is healthy"""
    log_info(f"Checking pod status: {deployment}")
    
    result = subprocess.run(
        f"kubectl get deployment {deployment} -n {namespace} -o jsonpath='{{.status.readyReplicas}}'",
        shell=True,
        capture_output=True,
        text=True
    )
    
    if result.returncode == 0 and result.stdout:
        ready = int(result.stdout)
        log_success(f"Pod replicas ready: {ready}")
        return ready > 0
    else:
        log_error("Failed to check pod status")
        return False

# 🚀 DEPLOYMENT HELPERS

class Deployment:
    """Helper class for deployments"""
    
    def __init__(self, name: str, namespace: str = "yuma-ai"):
        self.name = name
        self.namespace = namespace
    
    def status(self) -> bool:
        """Get deployment status"""
        return check_pod_status(self.name, self.namespace)
    
    def restart(self) -> int:
        """Restart deployment"""
        log_info(f"Restarting deployment: {self.name}")
        return safe_run(f"kubectl rollout restart deployment/{self.name} -n {self.namespace}")
    
    def logs(self) -> int:
        """Get deployment logs"""
        log_info(f"Getting logs for: {self.name}")
        return safe_run(f"kubectl logs deployment/{self.name} -n {self.namespace} -f --all-containers=true")

# 📦 APPLICATION

__all__ = [
    'log_info', 'log_success', 'log_warn', 'log_error',
    'validate_env_vars', 'validate_command_exists',
    'safe_run', 'run_kubectl', 'run_helm',
    'load_env', 'load_yaml', 'load_json', 'validate_config',
    'get_pods', 'check_pod_status',
    'Deployment',
]

if __name__ == "__main__":
    # Test the utilities
    log_info("Testing shared utilities...")
    log_success("Utilities are working!")
    log_warn("This is a warning")
    log_error("This is an error")
