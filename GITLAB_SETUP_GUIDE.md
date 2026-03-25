# GitLab Setup Guide - Team Primary Repository

**Scenario:** GitLab is team's primary (source of truth) + personal GitHub for reference  
**Goal:** Minimal local storage, push to GitLab, work from cloud

---

## 🎯 Your Setup

```
┌─────────────────────────────────────────────────────┐
│         YOUR CODEBASE - DUAL REMOTE SETUP          │
└─────────────────────────────────────────────────────┘

GitLab (Team) ⭐ PRIMARY SOURCE OF TRUTH
├─ team/Yuma.AI repo
├─ All production code lives here
├─ Team collaborates here
└─ This is your main remote

GitHub (Personal)
├─ zacc-spec/Yuma.AI repo
├─ Mirrored/synced for reference
├─ Your personal backup
└─ Secondary remote

Local Machine
├─ Minimal copy of code
├─ Used for development when needed
├─ Can be deleted and re-cloned anytime
└─ Push back to GitLab regularly
```

---

## 📋 STEP-BY-STEP SETUP

### Step 1: Get GitLab Credentials

```bash
# First, verify GitLab CLI is installed
gitlab --version

# Should show something like: gitlab version 1.90.0

# If not installed, install it:
brew install gitlab-cli

# Authenticate with GitLab
gitlab auth login

# Follow prompts:
# - Enter GitLab instance URL (usually: https://gitlab.com or your company's GitLab)
# - Create Personal Access Token 
# - Authorize

# Verify authentication
gitlab auth status
```

**Where to get Personal Access Token:**
1. Go to GitLab.com (or your company's GitLab)
2. Settings → Access Tokens
3. Create new token with `api`, `read_repository`, `write_repository` scopes
4. Copy the token
5. Paste into terminal when prompted

---

### Step 2: Find Your Team's GitLab Project

```bash
# List your GitLab projects
gitlab project list

# Or search for Yuma-related projects
gitlab project list --search yuma

# Look for output like:
# ID    Name                Path               ...
# 12345 Yuma.AI            team/yuma-ai       ...

# Note the PROJECT_ID and PROJECT_PATH
```

---

### Step 3: Add GitLab as Remote (Keep GitHub Too)

```bash
cd ~/Yuma.AI

# Check current remotes
git remote -v
# Should show:
# origin  https://github.com/zacc-spec/Yuma.AI.git (GitHub)

# Add GitLab as a second remote
git remote add gitlab https://gitlab.com/team/yuma-ai.git

# OR if your company uses self-hosted GitLab:
git remote add gitlab https://gitlab.yourcompany.com/team/yuma-ai.git

# Verify both remotes exist
git remote -v
# Should show:
# origin   https://github.com/zacc-spec/Yuma.AI.git (fetch)
# origin   https://github.com/zacc-spec/Yuma.AI.git (push)
# gitlab   https://gitlab.com/team/yuma-ai.git (fetch)
# gitlab   https://gitlab.com/team/yuma-ai.git (push)
```

---

### Step 4: Push to GitLab

```bash
# Make sure you're on main branch
git checkout main

# Push all branches and tags to GitLab
git push gitlab main --force

# Push all branches if you have multiple
git push gitlab --all

# Push tags
git push gitlab --tags

# Verify on GitLab - check via CLI
gitlab project-member list --project-id=team/yuma-ai
```

---

### Step 5: Set GitLab as DEFAULT Push Remote (Optional)

If you want `git push` to default to GitLab instead of GitHub:

```bash
# Option A: Change main remote to GitLab
git remote set-url origin https://gitlab.com/team/yuma-ai.git
git remote add github https://github.com/zacc-spec/Yuma.AI.git
# (Now git push goes to GitLab, git push github goes to GitHub)

# Option B: Configure git to push to BOTH
cat >> ~/.gitconfig << 'EOF'
[remote "all"]
    url = https://gitlab.com/team/yuma-ai.git
    url = https://github.com/zacc-spec/Yuma.AI.git
EOF

# Then push to both with: git push all
# OR push to specific: git push gitlab, git push github
```

I recommend **Option A** if GitLab is primary.

---

## 🔄 NEW WORKFLOW: Minimal Local + GitLab Primary

### Normal Development Workflow

```
1. CLONE from GitLab (source of truth)
   git clone https://gitlab.com/team/yuma-ai.git

2. CREATE feature branch
   git checkout -b feature/my-feature

3. MAKE CHANGES locally
   [edit files]

4. COMMIT
   git add .
   git commit -m "your message"

5. PUSH to GitLab (primary)
   git push gitlab feature/my-feature
   (or just: git push if you set GitLab as default)

6. CREATE Merge Request in GitLab
   - Go to GitLab project
   - Click "New Merge Request"
   - Select your branch
   - Describe changes
   - Assign reviewers
   - Submit

7. AFTER MERGE
   - Code lives in GitLab
   - Delete local branch (saves space)
   - Delete local copy if not needed
   
8. TO WORK AGAIN LATER
   - Clone fresh from GitLab
   - Or: git pull gitlab main
   - Start new feature branch
```

---

## 🗑️ CLEANUP: Minimal Local Storage

Since you want minimal local, periodically clean up:

```bash
# Delete local copy after pushing (keeps GitLab safe)
cd ~
rm -rf Yuma.AI

# When you need to work again:
git clone https://gitlab.com/team/yuma-ai.git
cd Yuma.AI

# Pull latest
git pull gitlab main
```

---

## 📤 SYNCING BOTH (GitHub + GitLab)

If you want to keep both updated:

**Option 1: Quick Dual Push**
```bash
# After committing locally
git push gitlab main       # Push to GitLab (primary)
git push github main       # Push to GitHub (backup)

# Or push to BOTH at once (if configured):
git push all main
```

**Option 2: Automated Sync Script**

Create: `packages/ai-generated/claude-vscode/scripts/sync-repos.sh`

```bash
#!/bin/bash
# Sync to both GitLab and GitHub

set -e

echo "🔄 Syncing to both repositories..."

# Pull latest from GitLab (primary)
git pull gitlab main --force

# Push to GitLab
echo "📤 Pushing to GitLab..."
git push gitlab main

# Also push to GitHub (secondary)
echo "📤 Pushing to GitHub (backup)..."
git push github main

echo "✅ Sync complete!"
```

Run it: `./packages/ai-generated/claude-vscode/scripts/sync-repos.sh`

---

## 🧪 TEST THE SETUP

```bash
# Verify GitLab connection
git ls-remote gitlab --heads main

# Should show:
# [commit-hash]  refs/heads/main

# Verify you can push
echo "test" > test.txt
git add test.txt
git commit -m "test commit"
git push gitlab test-branch

# Check on GitLab UI - should see new branch
# Then clean up:
git push gitlab --delete test-branch
rm test.txt
git reset HEAD~1
```

---

## 🚨 IMPORTANT: GitLab vs GitHub Differences

| Feature | GitHub | GitLab |
|---------|--------|--------|
| Merge Requests | Pull Requests (PR) | Merge Requests (MR) |
| Workflows | GitHub Actions | GitLab CI/CD |
| Teams | Organizations + Teams | Groups + Projects |
| Access | Settings → Collaborators | Members → Add Members |
| Permissions | Read, Write, Admin | Developer, Maintainer, Owner |

**For your team:**
- Always use GitLab terminology (Merge Request, not PR)
- Check GitLab's default branch policy
- Use GitLab Issues instead of GitHub Issues
- Use GitLab CI/CD instead of GitHub Actions

---

## 💻 CLOUD-FIRST WORKFLOW (Minimal Local)

Since you want minimal local storage:

### Cloud-Based Development Options

**Option 1: GitLab Web IDE**
```
1. Go to your GitLab project
2. Click "Edit" (or Web IDE button)
3. Make changes directly in browser
4. Commit and push from web UI
```

**Option 2: VSCode Remote SSH**
```bash
# Install Remote - SSH extension in VSCode
# Connect to cloud VM/dev machine
# Clone repo there, edit there, push there
```

**Option 3: GitHub Codespaces or GitLab Workspace**
```
1. Open in cloud code editor
2. Make changes
3. Terminal: git push gitlab main
4. Code stays in cloud, not on local disk
```

---

## 📝 Git Config for Your Setup

Update your git config to make life easier:

```bash
# Set GitLab as default
git config --global user.name "Your Name"
git config --global user.email "your.email@company.com"

# Set main as default branch
git config --global init.defaultBranch main

# Create git aliases for common commands
git config --global alias.glpush 'push gitlab main'
git config --global alias.ghpush 'push github main'
git config --global alias.sync '!git pull gitlab main && git push gitlab main && git push github main'

# Now you can use:
git glpush        # Push to GitLab
git ghpush        # Push to GitHub
git sync          # Sync both
```

---

## ✅ VERIFICATION CHECKLIST

- [ ] GitLab CLI installed: `gitlab --version`
- [ ] GitLab authenticated: `gitlab auth status`
- [ ] Both remotes added: `git remote -v` shows gitlab and origin
- [ ] Main branch pushed to GitLab: Check GitLab web UI
- [ ] Can create merge request in GitLab
- [ ] Team members can see the code
- [ ] GitHub still has a copy (backup)

---

## 🎯 FINAL SETUP SUMMARY

```
✅ PRIMARY: GitLab
   └─ All team code lives here
   └─ Source of truth
   └─ Push: git push gitlab main

✅ SECONDARY: GitHub
   └─ Personal backup
   └─ Can be synced or left as-is
   └─ Push: git push github main

✅ LOCAL: Minimal
   └─ Clone when needed
   └─ Delete when done
   └─ Can re-clone anytime from GitLab
```

---

## 🚀 Next Steps

1. **Authenticate with GitLab**: `gitlab auth login`
2. **Add GitLab remote**: `git remote add gitlab [url]`
3. **Push to GitLab**: `git push gitlab main`
4. **Verify on GitLab UI**: Check project appears
5. **Set as default** (optional): `git config user.gitlab ...`
6. **Delete local when not needed**: `rm -rf ~/Yuma.AI`
7. **Re-clone when needed**: `git clone https://gitlab.com/team/yuma-ai.git`

---

**You're all set for team GitLab development!** 🎉
