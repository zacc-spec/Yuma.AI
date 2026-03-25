# 🛡️ AI Guardrails System - Visual Overview

## The Complete Guardrail Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    YOUR AI USAGE GUARDRAILS                    │
│                      (The Full System)                          │
└─────────────────────────────────────────────────────────────────┘

                         WORKSPACE LEVEL
                              ↓
                  .github/copilot-instructions.md
                  (Global rules for ALL AI agents)
                              ↓
              ┌─────────────────┬──────────────────┐
              ↓                 ↓                  ↓
        Claude Code      Claude in iTerm2    All Other Tools
        (VSCode)         (Terminal)          (Future)
              ↓                 ↓                  ↓
   .github/instructions/ .github/instructions/ (TBD)
   claude-vscode.       claude-iterm2.
   instructions.md      instructions.md
```

---

## 📁 The File Organization

```
/Users/zaccromero/Yuma.AI/
├── .github/
│   ├── copilot-instructions.md ⭐ MAIN GUARDRAIL FILE
│   └── instructions/
│       ├── claude-vscode.instructions.md ⭐ VSCode rules
│       ├── claude-iterm2.instructions.md ⭐ iTerm2 rules
│       └── GUARDRAILS.md (overview)
│
└── packages/ai-generated/ 📁 ACTUAL STORAGE
    ├── README.md (main guide)
    ├── .gitignore
    ├── claude-vscode/
    │   ├── scripts/
    │   ├── configs/
    │   ├── tests/
    │   ├── migrations/
    │   └── deployments/
    ├── claude-iterm2/
    │   ├── scripts/
    │   ├── commands/
    │   ├── debugging/
    │   └── utilities/
    └── shared-utils/
        ├── helpers.sh
        └── common.py
```

---

## 🔄 How It Works

### When You Ask Claude in VSCode to Create a File

```
YOU:
"Create a deployment script"
    ↓
CLAUDE CODE READS:
.github/copilot-instructions.md
    ↓
CLAUDE CODE DETERMINES:
"This is deployment code"
"I'm Claude Code (VSCode)"
    ↓
CLAUDE CODE LOADS:
.github/instructions/claude-vscode.instructions.md
    ↓
CLAUDE CODE CHOOSES SUBFOLDER:
"deployments/" ← for deployment scripts
    ↓
CLAUDE CODE PROPOSES:
"/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/deploy.sh"
    ↓
YOU CONFIRM:
✅ Path looks right!
    ↓
FILE CREATED:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/deploy.sh
    ✅ CORRECT LOCATION!
```

---

### When You Ask Claude in iTerm2 to Create a File

```
YOU (IN iTERM2):
"Create a script to check pod status"
    ↓
CLAUDE iTERM2 READS:
.github/copilot-instructions.md
    ↓
CLAUDE iTERM2 DETERMINES:
"This is a debugging utility"
"I'm Claude in iTerm2"
    ↓
CLAUDE iTERM2 LOADS:
.github/instructions/claude-iterm2.instructions.md
    ↓
CLAUDE iTERM2 CHOOSES SUBFOLDER:
"debugging/" ← for troubleshooting tools
    ↓
CLAUDE iTERM2 PROVIDES SAVE COMMAND:
"cat > /Users/.../packages/ai-generated/claude-iterm2/debugging/check-pods.sh << 'EOF'"
    ↓
YOU RUN THE COMMAND:
✅ Copies code to correct location
    ↓
FILE CREATED:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/check-pods.sh
    ✅ CORRECT LOCATION!
```

---

## 📋 Quick Reference - The Paths

### Claude Code (VSCode)
```
Base: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/

Subfolders:
├── scripts/       → /Users/.../claude-vscode/scripts/build.sh
├── configs/       → /Users/.../claude-vscode/configs/k8s.yaml
├── tests/         → /Users/.../claude-vscode/tests/test_api.py
├── migrations/    → /Users/.../claude-vscode/migrations/001_users.sql
└── deployments/   → /Users/.../claude-vscode/deployments/deploy.sh
```

### Claude in iTerm2
```
Base: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/

Subfolders:
├── scripts/       → /Users/.../claude-iterm2/scripts/utility.sh
├── commands/      → /Users/.../claude-iterm2/commands/k8s-helpers.sh
├── debugging/     → /Users/.../claude-iterm2/debugging/check-pods.sh
└── utilities/     → /Users/.../claude-iterm2/utilities/retry.sh
```

### Shared by Both
```
Base: /Users/zaccromero/Yuma.AI/packages/ai-generated/shared-utils/

Files:
├── helpers.sh     → Common bash functions
└── common.py      → Common Python utilities
```

---

## 🎯 Decision Tree

```
CLAUDE ASKS: "Where should I save this?"

    ↓
    Is it executable code/script?
    ├─ YES → scripts/
    └─ NO → Next...

    ↓
    Is it configuration?
    ├─ YES → configs/
    └─ NO → Next...

    ↓
    Is it for testing?
    ├─ YES → tests/
    └─ NO → Next...

    ↓
    Is it a database migration?
    ├─ YES → migrations/
    └─ NO → Next...

    ↓
    Is it deployment automation?
    ├─ YES → deployments/
    └─ NO → Doesn't fit anywhere!

    ↓
    (For iTerm2 only) Not fitting above?
    ├─ Quick copy-paste command? → commands/
    ├─ Debugging tool? → debugging/
    └─ Helper function? → utilities/
```

---

## ✅ Guardrail Enforcement Checklist

**Before Claude Creates Any File:**

- [ ] Full absolute path specified: `/Users/zaccromero/Yuma.AI/packages/ai-generated/...`
- [ ] Correct subfolder chosen (scripts, configs, tests, migrations, deployments, commands, debugging, utilities)
- [ ] Path confirmed with user
- [ ] No scatter across project
- [ ] Executable flag noted if needed (`chmod +x`)
- [ ] File appears in correct location

**After Claude Creates the File:**

- [ ] File exists in specified path ✓
- [ ] File is readable/executable if needed ✓
- [ ] File can be run or used from project root ✓
- [ ] Shared utilities created in shared-utils/ if reusable ✓

---

## 🚀 Real World Example: Deploy Script

```
SCENARIO: User asks Claude Code (VSCode) to write a deployment script

WRONG APPROACH ❌
User:       "Create a deployment script"
Claude:     "Here's your script" [no path given]
Result:     "Where did it go?" 😕

CORRECT APPROACH ✅
User:       "Create a deployment script and save it to 
             /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/deploy.sh"
Claude:     "I'll create this at: [confirms path]"
Claude:     [creates file at exact path]
User:       "Perfect! File is at packages/ai-generated/claude-vscode/deployments/deploy.sh" ✓
```

---

## 🔗 Where to Find Each Guardrail

### Need the Main Rules?
**File:** `.github/copilot-instructions.md`
**Contains:**
- The core rule (everything goes to `packages/ai-generated/`)
- Paths for each tool
- Agent checklist

### Need VSCode-Specific Rules?
**File:** `.github/instructions/claude-vscode.instructions.md`
**Contains:**
- VSCode subfolder selection
- Workflow examples
- Detailed checklist

### Need iTerm2-Specific Rules?
**File:** `.github/instructions/claude-iterm2.instructions.md`
**Contains:**
- iTerm2 subfolder selection
- Save patterns
- Command templates

### Need Quick Copy-Paste Paths?
**File:** `AI_SCRIPTS_QUICK_REFERENCE.md`
**Contains:**
- Ready-to-copy full paths
- Live examples
- Quick usage patterns

### Need a Complete Overview?
**File:** `.github/instructions/GUARDRAILS.md`
**Contains:**
- High-level summary
- How guardrails work
- Enforcement scenarios

---

## 🎓 Team Training Flow

**New developer joining:**

```
Day 1 - Onboarding
├─ Read: AI_SCRIPTS_QUICK_REFERENCE.md (5 min)
├─ Understand: "All AI files go to packages/ai-generated/"
└─ See examples: "Here's VSCode example, here's iTerm2 example"

Day 7 - First AI Use
├─ When asking Claude: "Remember the guardrails"
├─ When Claude responds: "Check if path matches the pattern"
└─ Check: Is it in packages/ai-generated/? ✓

Day 30 - Expert
├─ Naturally follows guardrails
├─ Corrects teammates if they forget
└─ Can explain "why we do this"
```

---

## 📊 What's Covered

| Item | Status | File |
|------|--------|------|
| Global rules | ✅ | .github/copilot-instructions.md |
| Claude Code rules | ✅ | .github/instructions/claude-vscode.instructions.md |
| Claude iTerm2 rules | ✅ | .github/instructions/claude-iterm2.instructions.md |
| Guardrails overview | ✅ | .github/instructions/GUARDRAILS.md |
| Quick reference | ✅ | AI_SCRIPTS_QUICK_REFERENCE.md |
| Folder structure | ✅ | packages/ai-generated/ |
| Shared utilities | ✅ | packages/ai-generated/shared-utils/ |
| Documentation | ✅ | Multiple README files |

---

## 🎯 The Bottom Line

```
┌─────────────────────────────────────────────────────┐
│  ALL AI-GENERATED FILES GO TO:                      │
│                                                     │
│  /Users/zaccromero/Yuma.AI/packages/ai-generated/  │
│                                                     │
│  WITH APPROPRIATE SUBFOLDER:                        │
│  - claude-vscode/[type]/                            │
│  - claude-iterm2/[type]/                            │
│  - shared-utils/                                    │
│                                                     │
│  ✅ ORGANIZED                                       │
│  ✅ AUDITABLE                                       │
│  ✅ GOVERNANCE COMPLIANT                            │
│  ✅ NEVER SCATTERED                                 │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 Ready to Use!

Your guardrails are complete, committed to git, and ready:

✅ Workspace instructions active  
✅ Tool-specific rules in place  
✅ Storage structure ready  
✅ Documentation complete  
✅ Quick references available  
✅ Team-ready for onboarding  

**Start using them now!** 🎉
