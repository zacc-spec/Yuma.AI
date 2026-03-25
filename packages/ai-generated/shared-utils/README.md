# 🔧 Shared Utilities

**Reusable functions and utilities for all AI-generated scripts**

This folder contains common functions, helpers, and utilities that any AI-generated script (from Claude VSCode or Claude iTerm2) can use.

---

## 📂 Contents

```
shared-utils/
├── helpers.sh               # Common bash functions
├── common.py               # Common Python utilities
├── constants.sh            # Configuration values
└── Makefile               # Shared make targets
```

---

## 🚀 Usage

### In Bash Scripts
```bash
#!/bin/bash

# Source the helpers
source packages/ai-generated/shared-utils/helpers.sh

# Use helper functions
log_info "Starting deployment"
safe_helm_deploy "my-app"
log_success "Deployment complete"
```

### In Python Scripts
```python
# Import common utilities
import sys
sys.path.insert(0, 'packages/ai-generated/shared-utils')
from common import safe_run, log_info, load_env

# Use the utilities
log_info("Starting process")
safe_run("kubectl get pods")
```

---

## 📝 Available Functions

### Bash Functions (helpers.sh)
**Logging:**
- `log_info "message"` - Informational log
- `log_warn "message"` - Warning log
- `log_error "message"` - Error log
- `log_success "message"` - Success message

**Kubernetes:**
- `safe_kubectl "command"` - Run kubectl with error handling
- `check_pod_status "deployment"` - Check if pods are healthy
- `get_pod_logs "deployment"` - Get logs from deployment

**Helm:**
- `safe_helm_deploy "chart"` - Deploy with safety checks
- `validate_helm_values` - Validate Helm values file

**Utilities:**
- `retry "command"` - Retry a command if it fails
- `wait_for_endpoint "url"` - Wait for endpoint to be ready
- `validate_env_vars` - Check required environment variables

### Python Functions (common.py)
**Utilities:**
- `log_info(msg)` - Log information
- `safe_run(cmd)` - Run command safely
- `load_env(file)` - Load environment file
- `validate_config(config)` - Validate configuration

---

## 🎯 Creating New Utilities

### Add a Bash Function
Tell Claude Code:

```
Add a new bash function to packages/ai-generated/shared-utils/helpers.sh

Function name: my_new_function
Purpose: [describe what it does]
Parameters: [param1, param2]
Returns: [what it returns]

Example usage:
my_new_function "arg1" "arg2"
```

### Add a Python Function
```
Add a new Python function to packages/ai-generated/shared-utils/common.py

Function name: my_new_function
Purpose: [describe what it does]
Parameters: [param1, param2]
Returns: [what it returns]

The function should:
- [requirement 1]
- [requirement 2]
```

---

## 💡 Example: Using Shared Helpers

### Create a Deployment Script (Claude VSCode)
Ask Claude Code:
```
Create a deployment script at:
packages/ai-generated/claude-vscode/deployments/deploy-app.sh

It should:
1. Source the shared utilities: source packages/ai-generated/shared-utils/helpers.sh
2. Check that required environment variables are set
3. Build the Docker image
4. Deploy to Kubernetes using Helm
5. Verify the deployment is healthy
6. Log success message

Use the helper functions for logging and Kubernetes operations.
```

### Result - deploy-app.sh
```bash
#!/bin/bash

source packages/ai-generated/shared-utils/helpers.sh

# Main deployment logic using shared functions
log_info "Starting deployment"

validate_env_vars "DOCKER_IMAGE" "HELM_CHART" "NAMESPACE"

safe_kubectl "apply -f namespace.yaml"

safe_helm_deploy "my-app"

check_pod_status "my-app"

log_success "Deployment completed successfully!"
```

---

## 📦 Maintaining Shared Utilities

### Adding New Functions
```bash
# Create new function in helpers.sh or common.py
# Test it in a script
# Document it with comments
# Commit to git
```

### Updating Functions
```bash
# Only update if:
# - Fixing a bug
# - Improving performance
# - Adding missing error handling
# Don't break existing usage!
```

### Deprecating Functions
```bash
# Mark with @deprecated comment
# Suggest replacement
# Wait for all scripts to migrate
# Remove in next version
```

---

## ✅ Common Shared Functions

### Error Handling
```bash
# In any script
source packages/ai-generated/shared-utils/helpers.sh

# Automatically exit on error
set -e

# Safe command execution
safe_kubectl "get pods"
```

### Logging
```bash
log_info "This is informational"
log_warn "This is a warning"
log_error "This is an error"
log_success "This succeeded!"
```

### Configuration
```bash
# Load from .env file
source packages/ai-generated/shared-utils/helpers.sh

# Check required variables
validate_env_vars "API_KEY" "DATABASE_URL"
```

---

## 🔍 Testing Shared Utilities

### Test a Function
```bash
# Source the helpers
source packages/ai-generated/shared-utils/helpers.sh

# Test the function
log_info "Testing log_info function"
log_success "If you see this, it works!"

# Test error handling
safe_kubectl "get pods" || log_error "Failed to get pods"
```

---

## 📋 Adding to Your Scripts

### Template for Using Shared Utils
```bash
#!/bin/bash
#
# Script: my-script
# Requires: shared-utils/helpers.sh
#

set -e

# Source shared utilities
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SHARED_UTILS="${SCRIPT_DIR}/../shared-utils/helpers.sh"

if [[ ! -f "$SHARED_UTILS" ]]; then
    echo "Error: Cannot find shared utilities at $SHARED_UTILS"
    exit 1
fi

source "$SHARED_UTILS"

# Now use the shared functions
log_info "Starting my-script"

# Your script logic here

log_success "Script completed!"
```

---

## 🚀 Best Practices

- [x] **Keep functions generic** - Reusable across projects
- [x] **Document with comments** - Include purpose and usage
- [x] **Error handling** - All functions should handle errors gracefully
- [x] **Logging** - Use consistent logging throughout
- [x] **No side effects** - Functions should be predictable
- [x] **Version control** - Commit changes to git
- [x] **Test before use** - Test in a script first

---

## 📞 Need More?

Ask Claude to add utilities you need:

**In bash:**
```
Add this function to shared-utils/helpers.sh:

Function: validate_yaml
Purpose: Validate YAML file syntax
Params: filepath
Returns: 0 if valid, 1 if invalid

Example:
validate_yaml "deployment.yaml"
```

**In Python:**
```
Add this function to shared-utils/common.py:

Function: parse_kubernetes_config
Purpose: Parse kubectl config and return active context
Returns: context name string

Example:
context = parse_kubernetes_config()
```

All shared utilities available to both Claude Code and Claude iTerm2! 🎯
