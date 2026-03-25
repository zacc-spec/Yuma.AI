---
name: "AI Guardrails Summary"
description: "Overview of all AI agent guardrails. Where all Claude Code Extension and Claude in iTerm2 generated files MUST go (packages/ai-generated/ with subfolders)."
---

# 🛡️ AI Guardrails - Complete Overview

**What:** Rules that tell AI agents where to save files  
**Why:** Keep project organized, prevent file scatter, ensure governance compliance  
**Who:** Claude Code Extension (VSCode), Claude in iTerm2  
**Where:** These rules are enforced via workspace and file instructions

---

## 🎯 The Core Rule (Say It 3x)

```
EVERY AI-GENERATED FILE GOES TO:
/Users/zaccromero/Yuma.AI/packages/ai-generated/

NOT ANYWHERE ELSE.
NOT PROJECT ROOT.
NOT src/ OR backend/ OR frontend/.
NOT HOME DIRECTORY.
NOT TEMP FOLDERS.

PERIOD.
```

---

## 📋 Guardrail Files (The Full System)

### 1. Main Workspace Instructions
**File:** `.github/copilot-instructions.md`
**Scope:** Applies globally to ALL AI agents in the project
**Content:** 
- Core rule
- Path structure for each tool
- Agent checklist
- Reference documentation

**When it activates:** Whenever any AI agent generates files in this workspace

---

### 2. Claude VSCode Instructions
**File:** `.github/instructions/claude-vscode.instructions.md`  
**Scope:** Specifically for Claude Code Extension in VSCode
**Content:**
- VSCode subfolder selection rules
- Workflow for determining correct path
- Example interactions
- Detailed checklist

**Subfolders (choose one):**
- `scripts/` - Executable code
- `configs/` - Configuration files
- `tests/` - Test files
- `migrations/` - Database changes
- `deployments/` - Deployment scripts

**Example path:**
```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[subfolder]/[filename]
```

---

### 3. Claude iTerm2 Instructions
**File:** `.github/instructions/claude-iterm2.instructions.md`
**Scope:** Specifically for Claude AI in iTerm2 terminal
**Content:**
- iTerm2 subfolder selection rules
- Save patterns and commands
- Example interactions
- Pattern templates

**Subfolders (choose one):**
- `scripts/` - Standalone utilities
- `commands/` - Copy-paste commands
- `debugging/` - Troubleshooting tools
- `utilities/` - Helper functions

**Example path:**
```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/[subfolder]/[filename]
```

---

### 4. This File (Summary)
**File:** `.github/instructions/GUARDRAILS.md`
**Purpose:** Quick overview of the guardrail system

---

## 🔄 How Guardrails Work

### When Someone Asks Claude to Generate a File

```
User: "Create a deployment script"
     ↓
AI Agent reads workspace instructions (.github/copilot-instructions.md)
     ↓
AI Agent determines: "This is a deployment script"
     ↓
AI Agent checks: "Am I Claude Code or Claude iTerm2?"
     ↓
IF Claude Code (VSCode):
   → Reads .github/instructions/claude-vscode.instructions.md
   → Determines: deployments/ subfolder
   → Suggests: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/[name].sh
   ↓
IF Claude iTerm2:
   → Reads .github/instructions/claude-iterm2.instructions.md
   → Determines: scripts/ subfolder
   → Provides: cat > /Users/.../claude-iterm2/scripts/[name].sh << 'EOF' ... EOF
     ↓
User approves path
     ↓
File created in correct location ✅
```

---

## 📊 Guardrail Coverage

| Scenario | Covered By | Result |
|----------|-----------|--------|
| Claude Code generates deployment script | claude-vscode.instructions.md | → `packages/ai-generated/claude-vscode/deployments/` |
| Claude iTerm2 provides debug utility | claude-iterm2.instructions.md | → `packages/ai-generated/claude-iterm2/debugging/` |
| New AI tool added to project | copilot-instructions.md | → Add new instructions file in `.github/instructions/` |
| Team onboarding on AI usage | All guardrails + Quick Reference | → Point to `AI_SCRIPTS_QUICK_REFERENCE.md` |
| Code review detects scattered AI files | copilot-instructions.md | → Reject, point to guardrails |

---

## ✅ Guardrail Checklist

**For Claude Code (VSCode):**
- [ ] File has full path `/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/`
- [ ] Subfolder chosen: scripts|configs|tests|migrations|deployments
- [ ] Path confirmed with user before creation
- [ ] Executable scripts mention `chmod +x`
- [ ] File created in exact specified location

**For Claude iTerm2:**
- [ ] File instructions include full path `/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/`
- [ ] Subfolder chosen: scripts|commands|debugging|utilities
- [ ] Save command provided (cat >, output instructions)
- [ ] Executable scripts mention `chmod +x`
- [ ] Usage instructions included

**General:**
- [ ] No files in project root
- [ ] No files in src/, backend/, frontend/
- [ ] No files in home directory (~/)
- [ ] No files in Downloads, Desktop, tmp/
- [ ] All paths start with `/Users/zaccromero/Yuma.AI/packages/ai-generated/`

---

## 🚀 Enforcing Guardrails

### During Development
1. When asking Claude to generate a file:
   - Quote the path explicitly: "Save to: `/Users/...`"
   - Get confirmation before proceeding
   - Verify file appears in correct location

2. When reviewing AI output:
   - Check if file would go to correct path
   - Reject suggestions to save elsewhere
   - Point to appropriate subfolder if unclear

### During Code Review
```
PR Comment (if file found in wrong location):
"This AI-generated file is in the wrong location. 

Per project guardrails (see .github/copilot-instructions.md), 
it should be in packages/ai-generated/[tool]/[subfolder]/

Please move it and update references."
```

### During Team Onboarding
1. Point new developers to: `AI_SCRIPTS_QUICK_REFERENCE.md`
2. Reference: `.github/copilot-instructions.md`
3. Tool-specific details in: `.github/instructions/[tool].instructions.md`

---

## 📞 Common Questions

**Q: My Claude Code script is too simple, can I save directly?**  
A: No. Every AI-generated file → `packages/ai-generated/` → appropriate subfolder

**Q: Can I save a shared utility to claude-vscode/ instead of shared-utils/?**  
A: No. Shared utilities ALWAYS → `shared-utils/` so both tools can use them

**Q: The file is a one-liner, do I still need to follow guardrails?**  
A: Yes, even one-liners. Actually, one-liners should go to `claude-iterm2/commands/`

**Q: What if there's no matching subfolder?**  
A: Check all options. If truly nothing fits:
1. Create a new descriptive subfolder (e.g., `custom-tools/`)
2. Mention in guardrails update
3. Get team consensus

**Q: Can I move AI-generated files after Claude creates them?**  
A: Yes, once tested and approved, move to production location (e.g., `bin/`, `scripts/`)  
Keep original in `packages/ai-generated/` as reference

---

## 🔗 Related Documentation

**Quick Reference (copy/paste paths):**
- `AI_SCRIPTS_QUICK_REFERENCE.md`

**Detailed Guides:**
- `packages/ai-generated/README.md` (main overview)
- `packages/ai-generated/claude-vscode/README.md` (VSCode details)
- `packages/ai-generated/claude-iterm2/README.md` (iTerm2 details)
- `packages/ai-generated/shared-utils/README.md` (utilities)

**Guardrail Files:**
- `.github/copilot-instructions.md` (global rules)
- `.github/instructions/claude-vscode.instructions.md` (VSCode rules)
- `.github/instructions/claude-iterm2.instructions.md` (iTerm2 rules)
- `.github/instructions/GUARDRAILS.md` (this file)

---

## 🎓 Training Scenarios

### Scenario 1: Onboarding New Developer on AI Usage
```
You: "Here's how we organize AI-generated files"

Point them to: AI_SCRIPTS_QUICK_REFERENCE.md

They see:
- Full paths ready to copy
- Examples for each tool
- How to run the scripts

That's it. They're good.
```

### Scenario 2: Code Review - Bad Save Location
```
Review sees: Claude-generated script in src/utils/

You comment: "This should be in packages/ai-generated/ per our guardrails.
             See .github/copilot-instructions.md for details."

Dev moves file to correct location, updates imports.

PR approved ✅
```

### Scenario 3: New Tool Added (Future)
```
New AI tool added (e.g., ChatGPT API)

You:
1. Create new subfolder: packages/ai-generated/chatgpt/
2. Create instructions: .github/instructions/chatgpt.instructions.md
3. Update copilot-instructions.md to mention new tool
4. Update AI_SCRIPTS_QUICK_REFERENCE.md with new paths

Done. New tool follows guardrails automatically.
```

---

## ✨ Summary

| Component | Purpose | Location |
|-----------|---------|----------|
| **copilot-instructions.md** | Global rules for all AI agents | `.github/` |
| **claude-vscode.instructions.md** | Specific rules for Claude Code | `.github/instructions/` |
| **claude-iterm2.instructions.md** | Specific rules for Claude iTerm2 | `.github/instructions/` |
| **GUARDRAILS.md** | This overview document | `.github/instructions/` |
| **AI_SCRIPTS_QUICK_REFERENCE.md** | Quick copy-paste paths + examples | Project root |
| **packages/ai-generated/** | Actual storage for all AI files | Project folder |

---

## 🔒 Enforcement Status

✅ **Workspace Instructions:** Active globally  
✅ **Tool-Specific Instructions:** Active for each tool  
✅ **Quick Reference:** Available for team
✅ **Shared Utilities:** Ready for reuse  
✅ **Documentation:** Complete and committed to git

---

**These guardrails ensure that NO AI-generated file ends up scattered across the project. Everything is organized, auditable, and compliant with company governance.** 🛡️
