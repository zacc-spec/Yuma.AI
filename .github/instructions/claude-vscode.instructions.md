---
name: "Claude Code Extension (VSCode) - File Generation Rules"
description: "Use when: Claude Code Extension (in VSCode) generates files. All files MUST go to packages/ai-generated/claude-vscode/ with appropriate subfolder (scripts, configs, tests, migrations, deployments)."
---

# Claude Code Extension - File Generation Guardrails

**APPLIES TO:** Claude Code Extension (AI features in VSCode)

---

## ⚠️ MANDATORY RULE FOR CLAUDE CODE

**EVERY file you generate MUST be saved to:**
```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[SUBFOLDER]/
```

---

## 📂 SUBFOLDER SELECTION

Determine the correct subfolder BEFORE generating a file:

### `scripts/` 
**Use for:** Executable code that runs
- `.sh` files (bash scripts)
- `.py` files (Python scripts)  
- `.go` files (Go programs)
- Any runnable code

**Examples:**
- `build.sh` - Build automation
- `deploy.sh` - Deployment script
- `test_runner.py` - Run tests
- `data-migration.py` - Process data

### `configs/`
**Use for:** Configuration files that need review before applying
- `.yaml` files (Kubernetes, Helm configurations)
- `.json` files (application config)
- `.env` files (environment templates)
- `.yml` files (YAML configs)

**Examples:**
- `app-config.yaml` - App settings
- `k8s-deployment.yaml` - Kubernetes manifests
- `docker-compose.yml` - Docker composition
- `values.yaml` - Helm values

### `tests/`
**Use for:** Test files (unit tests, integration tests)
- `test_*.py` - Python tests
- `*.test.sh` - Bash test scripts
- `fixtures.json` - Test data
- `test-data/` - Test fixtures

**Examples:**
- `test_api.py` - API endpoint tests
- `test_integration.sh` - Integration tests
- `test-fixtures.json` - Mock data

### `migrations/`
**Use for:** Database schema changes
- `.sql` files (SQL migrations)
- `.py` files (Alembic migrations)
- Migration scripts

**Examples:**
- `001_create_users.sql` - Schema creation
- `002_add_indexes.sql` - Performance improvements
- `003_seed_data.sql` - Initial data

### `deployments/`
**Use for:** Deployment and infrastructure automation
- `deploy.sh` - Main deployment script
- `rollback.sh` - Rollback procedures
- Infrastructure automation
- Environment setup scripts

**Examples:**
- `deploy.sh` - Deploy to Kubernetes
- `rollback.sh` - Rollback procedure
- `setup-env.sh` - Environment initialization
- `health-check.sh` - Post-deployment validation

---

## 🎯 GENERATION WORKFLOW

### STEP 1: Determine Subfolder
```
User asks for a "Docker compose file" 
→ That's configuration
→ Use: configs/
```

```
User asks for a "test script"
→ That's for testing
→ Use: tests/
```

```
User asks for a "database migration"
→ That's schema changes
→ Use: migrations/
```

### STEP 2: Use Full Absolute Path
```
❌ DON'T:  "I created script.sh"
❌ DON'T:  "Save to ./script.sh"
❌ DON'T:  "Store in src/script.sh"

✅ DO:    "I created: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/scripts/script.sh"
```

### STEP 3: Confirm Path with User
```
"I'll create this configuration file at:
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/configs/app-config.yaml

Is this path correct?"
```

### STEP 4: Create with Full Path
When creating the file, use the COMPLETE path:
```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[subfolder]/[filename]
```

---

## 💡 EXAMPLE INTERACTIONS

### Example 1: Generate a Test File
```
User: "Create a Python test for the API endpoints"

You: "I'll create a test file at:
     /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/tests/test_api.py
     
     [creates file with full path]
     
     Next steps:
     - Review the test
     - Run: pytest packages/ai-generated/claude-vscode/tests/test_api.py
     - If good, you can move it to the main test directory"
```

### Example 2: Generate a Config
```
User: "Create a Kubernetes deployment manifest"

You: "I'll create this at:
     /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/configs/k8s-backend.yaml
     
     [creates file with full path]
     
     You can then:
     kubectl apply -f packages/ai-generated/claude-vscode/configs/k8s-backend.yaml"
```

### Example 3: Generate a Deployment Script
```
User: "Create a script that deploys to Kubernetes using Helm"

You: "I'll create this at:
     /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/deployments/deploy.sh
     
     [creates file with full path]
     
     To use it:
     chmod +x packages/ai-generated/claude-vscode/deployments/deploy.sh
     ./packages/ai-generated/claude-vscode/deployments/deploy.sh"
```

---

## ✅ CHECKLIST BEFORE CREATING ANY FILE

- [ ] I've determined the correct subfolder (scripts, configs, tests, migrations, deployments)
- [ ] I'm using the FULL absolute path: `/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[subfolder]/`
- [ ] I will confirm the path with the user before creating
- [ ] I will NOT create files in project root, src/, backend/, frontend/, or anywhere else
- [ ] If executable, I'll mention `chmod +x` when needed
- [ ] I'll provide clear usage instructions

---

## 🔗 RELATED DOCUMENTATION

- **Main Rules:** `.github/copilot-instructions.md`
- **Quick Reference:** `AI_SCRIPTS_QUICK_REFERENCE.md`
- **Detailed Guide:** `packages/ai-generated/claude-vscode/README.md`

---

## 🚫 WHAT NOT TO DO

❌ Save to project root
❌ Save to `src/` or `backend/` or `frontend/`
❌ Save without asking user for confirmation
❌ Use relative paths like `./scripts/` or `../scripts/`
❌ Say "I created [file]" without specifying the full path
❌ Save tests to project root test directory initially
❌ Save configs anywhere except `configs/` subfolder

---

## ✨ ONLY CORRECT PATH PATTERN

**This is the ONLY valid path pattern for Claude Code generated files:**

```
/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[scripts|configs|tests|migrations|deployments]/[filename]
```

**That's it. Nothing else.**
