# 🤖 AI Scripts - Quick Reference Card

**Where to tell Claude to save generated files**

---

## 🚀 Copy Your Full Path Reference

### For Claude Code (VS Code)
```
Full path base:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/

Examples:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/scripts/my-script.sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/deploy.sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/configs/app-config.yaml
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/tests/test_api.py
```

### For Claude in iTerm2
```
Full path base:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/

Examples:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/scripts/check-pods.sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/find-errors.sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/commands/useful-k8s.sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/utilities/color-output.sh
```

---

## 📋 Subfolders - Pick One

### Claude VSCode Subfolders
- `scripts/` - Executable scripts (.sh, .py, .go)
- `configs/` - Config files (.yaml, .json)
- `tests/` - Test files
- `migrations/` - Database migrations
- `deployments/` - Deployment scripts

### Claude iTerm2 Subfolders
- `scripts/` - Standalone utilities
- `commands/` - Copy-paste terminal commands
- `debugging/` - Troubleshooting tools
- `utilities/` - Helper functions

---

## 💡 How to Use with Claude

### Pattern 1: Ask Claude in VSCode
```
"Create a [type] file and save it to:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[SUBFOLDER]/[filename]

It should... [describe what]"
```

### Pattern 2: Ask Claude in iTerm2
```
"Create a bash script that [does something]

Save the full output to:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/[SUBFOLDER]/[filename]"
```

### Pattern 3: For Shared Utilities
```
"Add a new [bash function / Python function] to:
packages/ai-generated/shared-utils/[helpers.sh or common.py]

Function: [name]
Purpose: [describe]"
```

---

## 🎯 Live Examples

### Example 1: Deployment Script (VSCode)
Tell Claude Code:
```
Create a Helm deployment script to:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/deploy-helm.sh

It should:
1. Check 1Password for secrets
2. Load environment variables
3. Validate Helm chart
4. Deploy using Helm
5. Check pod status
6. Log results
```

### Example 2: Debug Script (iTerm2)
Tell Claude:
```
Create a bash script that checks pod status and shows recent errors.

Save to:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/pod-debug.sh

Include:
- List all pods in yuma-ai namespace
- Show pod status
- Show recent errors from logs
```

### Example 3: Shared Helper (Both)
Tell Claude:
```
Add a bash function to helpers.sh:

Function: get_deployment_info
Purpose: Get deployment replica count and image version
Path: packages/ai-generated/shared-utils/helpers.sh

Example usage:
get_deployment_info "yuma-backend"
```

---

## 🔧 Run Your Scripts

### From Project Root
```bash
# VSCode scripts
./packages/ai-generated/claude-vscode/scripts/my-script.sh
./packages/ai-generated/claude-vscode/deployments/deploy.sh

# iTerm2 scripts
./packages/ai-generated/claude-iterm2/scripts/utility.sh
./packages/ai-generated/claude-iterm2/debugging/check-pods.sh

# Or with full path
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/scripts/my-script.sh
```

---

## 📚 Use Shared Utilities

### In Bash Scripts
```bash
#!/bin/bash

# At the top of your script
source packages/ai-generated/shared-utils/helpers.sh

# Now use them
log_info "Starting process"
safe_kubectl "get pods"
log_success "All done!"
```

### In Python Scripts
```python
#!/usr/bin/env python3

import sys
sys.path.insert(0, 'packages/ai-generated/shared-utils')
from common import log_info, safe_run, load_yaml

log_info("Starting")
safe_run("kubectl get pods")
```

---

## ✅ Workflow Summary

**When you want Claude to create a script:**

1. **Copy the full path** from above
2. **Tell Claude** "Save to [full path]"
3. **Claude creates it** in the right place
4. **Make executable** if needed: `chmod +x script.sh`
5. **Test it** before running
6. **Run from project root** or use full path

**Benefits:**
- ✅ No files scattered everywhere
- ✅ Easy to find and organize
- ✅ Simple to share with team
- ✅ Git tracks important scripts
- ✅ Shared utilities keep things DRY

---

## 🎓 Documentation

Full details in:
- `packages/ai-generated/README.md` - Main overview
- `packages/ai-generated/claude-vscode/README.md` - VSCode details
- `packages/ai-generated/claude-iterm2/README.md` - iTerm2 details
- `packages/ai-generated/shared-utils/README.md` - Utilities docs

---

## 📌 Post This Somewhere!

**Options:**
1. Pin to VS Code bookmark
2. Add to team wiki/knowledge base
3. Alias in your shell: `alias ai-ref="cat /Users/zaccromero/Yuma.AI/AI_SCRIPTS_QUICK_REFERENCE.md"`
4. Keep in this repo for team reference

**The Full Paths You'll Use Most:**
```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/
```

**Quick Copy:**
```
VSCode: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[subfolder]/
iTerm2:  /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/[subfolder]/
```

---

🚀 **Ready to safely organize all your AI-generated scripts!**
