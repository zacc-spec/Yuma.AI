---
name: "Claude in iTerm2 Terminal - File Generation Rules"
description: "Use when: Claude AI generates files via iTerm2 terminal. All files MUST go to packages/ai-generated/claude-iterm2/ with appropriate subfolder (scripts, commands, debugging, utilities)."
---

# Claude in iTerm2 - File Generation Guardrails

**APPLIES TO:** Claude AI accessed via terminal/iTerm2

---

## ⚠️ MANDATORY RULE FOR CLAUDE IN iTERM2

**EVERY file you provide/generate MUST be saved to:**
```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/[SUBFOLDER]/
```

---

## 📂 SUBFOLDER SELECTION

Choose the correct subfolder for the type of file:

### `scripts/`
**Use for:** Standalone, reusable terminal utilities
- Utilities you'll run frequently
- General purpose scripts
- Helper tools

**Examples:**
- `quick-deploy.sh` - Fast deployment
- `log-analyzer.sh` - Parse logs
- `pod-repair.sh` - Fix stuck pods
- `db-backup.sh` - Database backup

### `commands/`
**Use for:** Copy-paste terminal commands
- One-liners you use often
- Command collections
- Quick helpers

**Examples:**
- `useful-k8s-commands.sh` - kubectl snippets
- `docker-cleanup.sh` - Docker maintenance
- `git-helpers.sh` - Git shortcuts
- `system-info.sh` - System diagnostics

### `debugging/`
**Use for:** Troubleshooting and debugging tools
- When something breaks
- Diagnostic utilities
- Error investigation scripts

**Examples:**
- `check-pods.sh` - Pod status checker
- `find-errors.sh` - Search logs for errors
- `network-test.sh` - Network diagnostics
- `resource-check.sh` - Resource usage

### `utilities/`
**Use for:** Helper functions (often sourced in other scripts)
- Functions to use in other scripts
- Reusable code blocks
- Helper libraries

**Examples:**
- `color-output.sh` - Terminal colors
- `retry-logic.sh` - Retry functions
- `error-handling.sh` - Error management
- `prompt-helpers.sh` - User input handling

---

## 🎯 GENERATION WORKFLOW

### STEP 1: Determine Subfolder
```
Claude suggests kubectl commands
→ Useful for other terminal sessions
→ Use: commands/
```

```
Claude shows debugging script
→ For troubleshooting issues
→ Use: debugging/
```

```
Claude provides reusable script
→ For regular maintenance
→ Use: scripts/
```

### STEP 2: Provide Full Path Instructions
```
✅ "Save this to: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/scripts/check-pods.sh"

OR provide save command:
cat > /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/find-errors.sh << 'EOF'
[code here]
EOF

chmod +x /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/find-errors.sh
```

### STEP 3: Include Usage Instructions
```
"You can now run:
./packages/ai-generated/claude-iterm2/scripts/check-status.sh

Or with full path:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/scripts/check-status.sh"
```

---

## 💡 EXAMPLE INTERACTIONS

### Example 1: Terminal Commands
```
You: "Here are useful kubectl commands:

Save to: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/commands/kubectl-helpers.sh

[commands here]

Then run:
source packages/ai-generated/claude-iterm2/commands/kubectl-helpers.sh
[function_name]"
```

### Example 2: Debug Script
```
You: "This script finds ERROR lines in pod logs:

Save to: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/find-errors.sh

cat > /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/find-errors.sh << 'EOF'
#!/bin/bash
kubectl logs deployment/yuma-backend -n yuma-ai | grep ERROR
EOF

chmod +x /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/find-errors.sh

Run it:
./packages/ai-generated/claude-iterm2/debugging/find-errors.sh"
```

### Example 3: Utility Function
```
You: "Here's a retry function for other scripts:

Add to: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/utilities/retry.sh

[function code]

Then in other scripts use:
source packages/ai-generated/claude-iterm2/utilities/retry.sh
retry "your command here""
```

---

## ✅ CHECKLIST FOR SHELL/TERMINAL FILES

- [ ] Determined correct subfolder (scripts, commands, debugging, utilities)
- [ ] Provided FULL absolute path starting with `/Users/zaccromero/Yuma.AI/`
- [ ] Included save command (cat >, echo >, etc.) if providing file creation method
- [ ] Mentioned `chmod +x` for executable scripts
- [ ] Provided usage/run command after save
- [ ] NEVER suggested saving elsewhere

---

## 🔮 CLAUDE iTERM2 PATTERNS TO FOLLOW

### Pattern 1: Script with Save Instructions
```
Here's a script to [purpose]:

Save it:
cat > /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/scripts/[name].sh << 'EOF'
#!/bin/bash
[code]
EOF

chmod +x /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/scripts/[name].sh

Run it:
./packages/ai-generated/claude-iterm2/scripts/[name].sh
```

### Pattern 2: One-Liner to Script
```
You can copy this command:
[command here]

Or save it as a script:
cat > /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/commands/[name].sh << 'EOF'
#!/bin/bash
[command]
EOF

chmod +x /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/commands/[name].sh
```

### Pattern 3: Debug Utility
```
When you need to debug [issue], use:

cat > /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/[name].sh << 'EOF'
[debug code]
EOF

chmod +x /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/[name].sh

Then: ./packages/ai-generated/claude-iterm2/debugging/[name].sh
```

---

## 🔗 RELATED DOCUMENTATION

- **Main Rules:** `.github/copilot-instructions.md`
- **Quick Reference:** `AI_SCRIPTS_QUICK_REFERENCE.md`
- **Detailed Guide:** `packages/ai-generated/claude-iterm2/README.md`
- **Shared Utilities:** `packages/ai-generated/shared-utils/`

---

## 🚫 WHAT NOT TO DO

❌ Say "Here's a script" without path
❌ Suggest saving to home directory (~/)
❌ Suggest saving to tmp/
❌ Suggest saving to project root
❌ Provide code without save instructions
❌ Forget `chmod +x` for shell scripts
❌ Suggest saving to Desktop or Downloads

---

## ✨ ONLY CORRECT PATH PATTERNS

**These are the ONLY valid paths for Claude iTerm2 generated files:**

```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/scripts/[filename].sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/commands/[filename].sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/[filename].sh
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/utilities/[filename].sh
```

**That's it. Nothing else.**
