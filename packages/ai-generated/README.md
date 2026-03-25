# 🤖 AI-Generated Scripts & Files

**Central hub for all AI-generated scripts, files, and configurations.**

This folder keeps AI-generated content organized and prevents files from being scattered across your project directory. Every AI tool you use (Claude in VS Code, Claude in iTerm2, etc.) writes to a dedicated subfolder.

---

## 📁 Folder Structure

```
packages/ai-generated/
├── README.md                    # This file
├── .gitignore                   # What to commit/ignore
│
├── claude-vscode/               # Claude Code Extension (VS Code)
│   ├── README.md
│   ├── scripts/                 # Python, bash, shell scripts
│   ├── configs/                 # Config files (YAML, JSON)
│   ├── tests/                   # Test files
│   ├── migrations/              # Database migrations
│   └── deployments/             # Deployment scripts
│
├── claude-iterm2/               # Claude in iTerm2 Terminal
│   ├── README.md
│   ├── scripts/                 # Terminal-specific scripts
│   ├── commands/                # One-off terminal commands
│   ├── debugging/               # Debug scripts
│   └── utilities/               # Helper utilities
│
├── other-ai-tools/              # Future AI tools
│   ├── README.md
│   └── (organize as needed)
│
└── shared-utils/                # Utilities used across AI tools
    ├── helpers.sh               # Common bash functions
    ├── common.py                # Common Python utilities
    └── Makefile                 # Shared make targets
```

---

## 🎯 Purpose of Each Folder

### `claude-vscode/`
**Claude Code Extension in VS Code**
- Multi-file edits and refactoring
- Project-wide code generation
- Complex configuration files
- Integration scripts

**Organize by type:**
- `scripts/` - Runnable scripts (.py, .sh, .go)
- `configs/` - Configuration files (.yaml, .json)
- `tests/` - Test files for new features
- `migrations/` - Database or schema changes
- `deployments/` - Deployment automation

### `claude-iterm2/`
**Claude in iTerm2 Terminal**
- Quick one-off scripts
- Terminal utilities
- Debugging commands
- System administration tasks

**Organize by purpose:**
- `scripts/` - Standalone executables
- `commands/` - Copy-paste terminal commands
- `debugging/` - Troubleshooting utilities
- `utilities/` - Helper tools

### `shared-utils/`
**Reusable across all AI tools**
- Common bash functions (`helpers.sh`)
- Shared Python utilities (`common.py`)
- Makefile targets
- Configuration templates

### `other-ai-tools/`
**Future AI assistants** (if you add ChatGPT, Gemini, etc.)
- Keep them separate from Claude
- Follow same organizational pattern

---

## 💡 How to Use This

### For Claude Code (VS Code)

When asking Claude Code to generate files, use this prompt pattern:

```
Please create this file in packages/ai-generated/claude-vscode/:

[description of what you want]

Use this path: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[subfolders]
```

Example:
```
Create a deployment script in packages/ai-generated/claude-vscode/deployments/

Please write a script that deploys to Kubernetes using Helm, 1Password for secrets,
and Terraform for infrastructure. Path: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/deploy.sh
```

### For Claude in iTerm2

When asking Claude in iTerm2, use this command pattern:

```bash
# Tell Claude where to save files
# "Please create the output file at: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/[purpose]/[filename]"

# Example in iTerm2:
# > create a script that checks pod status, save to /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/debugging/check-pods.sh
```

---

## 🚀 Running AI-Generated Scripts

### From Claude VSCode
```bash
# Scripts are organized and easy to find
cd packages/ai-generated/claude-vscode/scripts/
chmod +x *.sh
./my-script.sh

# Or from project root
./packages/ai-generated/claude-vscode/deployments/deploy.sh
```

### From Claude iTerm2
```bash
# Direct path reference
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/scripts/my-script.sh

# Or short version
packages/ai-generated/claude-iterm2/scripts/my-script.sh
```

### Using Shared Utilities
```bash
# Source common functions in any script
source packages/ai-generated/shared-utils/helpers.sh

# Use the helper functions
function my_script() {
    source_helpers
    deploy_app "my-app"
}
```

---

## 📋 Prompt Templates

### Template 1: For Claude Code (VS Code)
```
I need a [type of script/file].

Purpose: [what it does]

Save to: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[subfolder]/[filename]

Requirements:
- [requirement 1]
- [requirement 2]

Here's context: [additional context]
```

### Template 2: For Claude in iTerm2
```
Create a [script type] that does [purpose].

Save the output to: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-iterm2/[subfolder]/[filename]

It should:
- [requirement 1]
- [requirement 2]
```

### Template 3: For Shared Utilities
```
Add a new utility function to packages/ai-generated/shared-utils/[helpers.sh or common.py]

Function: [function_name]
Purpose: [what it does]
Language: [bash or python]

The function should:
- [requirement 1]
- [requirement 2]
```

---

## ✅ Quick Checklist

When Claude generates a file:

- [x] **Ask Claude to save it here** - `/Users/zaccromero/Yuma.AI/packages/ai-generated/[al-tool]/[subfolder]/`
- [x] **Organize by type** - scripts, configs, tests, deployments, etc.
- [x] **Make scripts executable** - `chmod +x script.sh`
- [x] **Test before running** - Review AI output before execution
- [x] **Document purpose** - Add comments in script header
- [x] **Share utilities** - Move reusable code to `shared-utils/`
- [x] **Keep organized** - Don't let files clutter project root

---

## 🔧 Maintenance

### Clean Up Old Files
```bash
# View all AI-generated files
find packages/ai-generated -type f -name "*.sh" -o -name "*.py"

# Remove old/unused scripts
rm packages/ai-generated/claude-vscode/scripts/old-script.sh
```

### Back Up Important Scripts
```bash
# Copy to production-ready location after testing
cp packages/ai-generated/claude-vscode/deployments/deploy.sh ./deploy.sh
git add ./deploy.sh
```

### Archive History
```bash
# Keep old versions organized
mkdir packages/ai-generated/claude-vscode/archive
mv packages/ai-generated/claude-vscode/scripts/old-*.sh packages/ai-generated/claude-vscode/archive/
```

---

## 🎓 Examples

### Example 1: Claude Code Generates Deployment Script
```
Location: packages/ai-generated/claude-vscode/deployments/deploy.sh
Purpose: Deploy Yuma.AI to production using Terraform + Helm + 1Password
Used: Once per deployment
Status: Tested ✅
```

### Example 2: Claude iTerm2 Creates Debug Utility
```
Location: packages/ai-generated/claude-iterm2/debugging/check-pods.sh
Purpose: Quick kubectl commands to check pod status
Used: Daily development
Status: Tested ✅
```

### Example 3: Shared Utility Function
```
Location: packages/ai-generated/shared-utils/helpers.sh
Purpose: Common bash functions for all scripts
Used: Sourced by other scripts
Status: Maintained ✅
```

---

## 📝 Notes

- **Don't commit unnecessary files** - Use `.gitignore` to exclude temp/test files
- **Version control important scripts** - Commit production-ready scripts to git
- **Add headers to scripts** - Include author, purpose, and usage comments
- **Test thoroughly** - AI-generated code is helpful but should be reviewed
- **Keep organized** - Maintenance is key to preventing clutter

---

## 🔒 Governance Compliance

✅ **Approved by:**
- Using approved tools only (your 7 tools)
- No external AI services storing data
- All scripts reviewed before execution
- Organized and auditable structure

✅ **Company policy compliant:**
- No secrets in scripts (use 1Password)
- All scripts can be reviewed
- Clear ownership and purpose
- Easy to audit and maintain

**This keeps your AI-generated code organized, searchable, and compliant!** 🚀
