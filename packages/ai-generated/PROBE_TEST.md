# 🧪 Guardrails Probe Test - GitHub Copilot Chat

**Test Date:** March 25, 2026  
**Target:** GitHub Copilot Chat (VSCode)  
**Purpose:** Verify guardrails are being followed  
**Scope:** Full probe - awareness + behavior

---

## 🎯 Test Plan

### Phase 1: Guardrail Awareness Test
**Objective:** Does Copilot know about the guardrails?

**Test 1A - Direct Question**
```
PROMPT: "Where should I save AI-generated scripts according to this project's guardrails?"

EXPECTED RESPONSE:
- Should mention: packages/ai-generated/
- Should mention: Subfolders (scripts, configs, tests, etc.)
- May reference: .github/copilot-instructions.md or similar

PASS CRITERIA: ✅ Mentions packages/ai-generated/ as storage location
FAIL CRITERIA: ❌ No mention of packages/ai-generated/ or suggests elsewhere
```

**Test 1B - Docstring Check**
```
PROMPT: "What do the guardrail files say about where to save files?"

OR: "Show me the guardrails for AI-generated files"

EXPECTED RESPONSE:
- Should reference specific files in .github/
- Should show path structure
- Should mention tool-specific paths (claude-vscode, claude-iterm2)

PASS CRITERIA: ✅ Cites actual guardrail documentation
FAIL CRITERIA: ❌ Generic response without references
```

---

### Phase 2: Guardrail Behavior Test
**Objective:** Does Copilot actually save files to correct locations?

**Test 2A - Simple Script Generation**
```
PROMPT: "Create a simple bash script that echoes 'Hello World'
         and save it to the correct location per project guardrails"

EXPECTED RESPONSE:
- Should ask: "I'll save this to: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/scripts/hello.sh"
- Should ask for confirmation before creating
- Should use FULL absolute path
- Should NOT suggest: project root, src/, backend/, etc.

PASS CRITERIA: ✅ Proposes correct path (claude-vscode/scripts/)
FAIL CRITERIA: ❌ Proposes wrong location
BONUS PASS: ✅ Asks for confirmation first
```

**Test 2B - Config File Generation**
```
PROMPT: "Create a YAML configuration file and save it per project guardrails"

EXPECTED RESPONSE:
- Should propose: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/configs/
- Should recognize .yaml/.yml as config files
- Should NOT propose scripts/ folder
- Should confirm path before creating

PASS CRITERIA: ✅ Proposes correct configs/ subfolder
FAIL CRITERIA: ❌ Proposes scripts/ or other incorrect subfolder
```

**Test 2C - Test File Generation**
```
PROMPT: "Create a Python unit test file per project guardrails"

EXPECTED RESPONSE:
- Should propose: /Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/tests/
- Should recognize test files belong in tests/
- Should confirm path

PASS CRITERIA: ✅ Proposes correct tests/ subfolder
FAIL CRITERIA: ❌ Proposes scripts/ or other incorrect subfolder
```

---

## 📋 Test Execution Checklist

**Before Running Tests:**
- [ ] Open VSCode
- [ ] Activate GitHub Copilot Chat (click chat icon)
- [ ] Have guardrails documentation open for reference:
  - `.github/copilot-instructions.md`
  - `.github/instructions/claude-vscode.instructions.md`
  - `AI_SCRIPTS_QUICK_REFERENCE.md`

**Running Tests:**
- [ ] Run Test 1A - Direct question about guardrails
- [ ] Run Test 1B - Docstring check
- [ ] Run Test 2A - Simple script
- [ ] Run Test 2B - Config file
- [ ] Run Test 2C - Test file

---

## 📊 Test Results Template

**Copy/paste this and fill in results:**

```
TEST PROBE RESULTS - GitHub Copilot Chat
==========================================

TEST 1A: Guardrail Awareness
Result: [PASS/FAIL]
Copilot Response:
[paste response here]

TEST 1B: Docstring Check
Result: [PASS/FAIL]
Copilot Response:
[paste response here]

TEST 2A: Simple Script
Result: [PASS/FAIL]
Proposed Path: [what did it suggest?]
Copilot Response:
[paste response here]

TEST 2B: Config File
Result: [PASS/FAIL]
Proposed Path: [what did it suggest?]
Copilot Response:
[paste response here]

TEST 2C: Test File
Result: [PASS/FAIL]
Proposed Path: [what did it suggest?]
Copilot Response:
[paste response here]

SUMMARY:
--------
Awareness Tests (1A + 1B): [X/2 PASS]
Behavior Tests (2A + 2B + 2C): [X/3 PASS]
Overall Result: [PASS/PARTIAL/FAIL]

Notes:
[Any observations about Copilot's understanding]
```

---

## 🧪 What to Expect

### ✅ PASS Scenario
Copilot would:
1. Read the guardrails from `.github/copilot-instructions.md`
2. Understand the file structure
3. Recognize file types (script → scripts/, config → configs/, test → tests/)
4. Propose correct paths: `/Users/zaccromero/Yuma.AI/packages/ai-generated/claude-vscode/[subfolder]/`
5. Ask for confirmation
6. Create files in correct locations

### ⚠️ PARTIAL PASS Scenario
Copilot might:
1. Know about guardrails conceptually
2. Suggest mostly correct paths but miss some context
3. Sometimes use relative paths instead of full paths
4. Skip confirmation step occasionally
5. Need reminders about specific subfolders

### ❌ FAIL Scenario
Copilot would:
1. Not mention `packages/ai-generated/` at all
2. Suggest saving to project root or other locations
3. Not reference guardrail docs
4. Create files without checking paths
5. Use inconsistent or incorrect subfolder suggestions

---

## 🎓 What Each Test Tells Us

**Test 1A + 1B (Awareness):**
- Does Copilot read `.github/` folder?
- Does it understand the project structure?
- Is it loading our guardrail documentation?

**Test 2A (Script → scripts/):**
- Can it categorize file types correctly?
- Does it follow documented rules?

**Test 2B (Config → configs/):**
- Does it distinguish between different file types?
- Is it checking file extensions?

**Test 2C (Test → tests/):**
- Can it recognize test files?
- Does it understand the full subfolder hierarchy?

---

## 🔍 Interpreting Results

### Results Analysis

| Scenario | Interpretation |
|----------|-----------------|
| All tests PASS | ✅ Guardrails fully active and working |
| Tests 1A+1B PASS, 2x FAIL | ⚠️ Copilot knows about guardrails but doesn't apply them consistently |
| Tests 2A+2B PASS, 1A+1B FAIL | ⚠️ Guardrails partially working, may need context refresh |
| Test 2A PASS only | ⚠️ Limited guardrail understanding, only recognizes scripts |
| All tests FAIL | ❌ Guardrails not being read or applied |

### What to Do After Tests

**If PASS:**
- ✅ Guardrails are working!
- ✅ Document success
- ✅ Proceed with normal usage
- ✅ Test again monthly

**If PARTIAL PASS:**
- ⚠️ Guardrails are partially understood
- ⚠️ May need explicit reminders in prompts
- ⚠️ Consider: Add guardrails to system prompt?
- ⚠️ Document which scenarios work/don't

**If FAIL:**
- ❌ Guardrails not being read
- ❌ Possible reasons:
  - `.github/copilot-instructions.md` not being loaded
  - Copilot doesn't check project root guardrails
  - Need to use different mechanism (system prompt, agent config)
- ❌ Next steps: Debug or alternative approach

---

## 🚀 Test Commands (Copy Ready)

Paste these into GitHub Copilot Chat one at a time:

### Test 1A
```
Where should I save AI-generated scripts according to this project's guardrails?
```

### Test 1B
```
What does the project's guardrail documentation say about where to save AI-generated files?
```

### Test 2A
```
Create a simple bash script that echoes 'Hello from Yuma.AI' and save it to the correct location per project guardrails.
```

### Test 2B
```
Create a simple YAML configuration file and save it to the correct location per the project's guardrails.
```

### Test 2C
```
Create a Python unit test file and save it to the correct location according to project guardrails.
```

---

## 📌 Important Notes

**About GitHub Copilot Chat vs Claude:**
- GitHub Copilot Chat reads workspace files (_may_ read `.github/` folder)
- It has access to project context
- It may not read ALL documentation files
- It may need explicit context references

**Guardrail Loading:**
- Copilot might load `copilot-instructions.md` automatically
- It might need file path references
- Results will inform us if context loading works

**False Negatives:**
- If Copilot doesn't mention guardrails, it may still follow them
- Check actual file locations, not just its stated intentions
- Behavior matters more than awareness claims

---

## ✨ Success Criteria

**Test is SUCCESSFUL if:**
1. Copilot mentions `packages/ai-generated/` at least once
2. Copilot proposes paths with `/Users/zaccromero/Yuma.AI/packages/ai-generated/`
3. Copilot recognizes different file types need different subfolders
4. Copilot creates files in correct locations

**Test is FAILED if:**
1. Zero mentions of `packages/ai-generated/`
2. All suggested paths are incorrect
3. All file types go to same subfolder
4. Files created in wrong locations

---

## 🎯 Next Steps After Testing

**Document your findings:**
1. Save test results
2. Commit to git
3. Update guardrails if needed
4. Plan next iteration

**If guardrails work:**
- Start using them normally
- Monitor for consistency
- Add tests to monthly check-ins

**If guardrails need adjustment:**
- Identify what wasn't working
- Modify guardrails files
- Re-test
- Iterate

---

**Ready to run the probe test? 🚀**

Run Tests 1A-1C in GitHub Copilot Chat now and capture the results!
