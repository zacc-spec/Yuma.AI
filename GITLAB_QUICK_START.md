# 🚀 GitLab Quick Start - Copy & Paste Commands

**Your Setup:** GitLab (Team Primary) + GitHub (Personal Backup) + Minimal Local

---

## ⚡ QUICK SETUP (5 minutes)

### Run These Commands:

```bash
# 1. Install/verify GitLab CLI
brew install gitlab-cli

# 2. Authenticate
gitlab auth login
# Choose: gitlab.com (or your company's GitLab)
# Create Personal Access Token: https://gitlab.com/-/user_settings/personal_access_tokens
# Paste token when prompted

# 3. Verify authentication
gitlab auth status

# 4. Go to your local repo
cd ~/Yuma.AI

# 5. Add GitLab as remote
git remote add gitlab https://gitlab.com/team/yuma-ai.git
# (Replace with your actual team/project path)

# 6. Push to GitLab
git push gitlab main --force

# 7. Verify
git remote -v
# Should show both: origin (GitHub) and gitlab (GitLab)
```

---

## 📊 What You Have Now

```
Your Repository Structure:
┌──────────────────────────────────────┐
│ GitLab: team/yuma-ai ⭐ PRIMARY     │
│ - All team code                      │
│ - Source of truth                    │
│ - Team collaborates here             │
└──────────────────────────────────────┘
         ↑         ↑
    Push/Pull   Merge Requests

┌──────────────────────────────────────┐
│ GitHub: zacc-spec/Yuma.AI (Backup)  │
│ - Your personal copy                 │
│ - Keep for reference                 │
│ - Optional sync                      │
└──────────────────────────────────────┘
         ↑
    Occasional push
```

---

## 🔄 DAILY WORKFLOW

### Starting Work

```bash
# ONCE (first time):
git clone https://gitlab.com/team/yuma-ai.git
cd Yuma.AI

# OR if already cloned:
cd ~/Yuma.AI
git pull gitlab main
```

### Making Changes

```bash
# Create feature branch
git checkout -b feature/my-feature

# Make changes
# Edit files...

# Commit
git add .
git commit -m "Add my changes"

# Push to GitLab
git push gitlab feature/my-feature

# Go to GitLab.com → Create Merge Request
# Team reviews → Approved → Merge
```

### After Work (Minimal Local)

```bash
# Option 1: Delete everything (safest)
cd ~
rm -rf Yuma.AI
# Code is safe in GitLab!

# Option 2: Just update main locally
git checkout main
git pull gitlab main

# Next time you start work:
git clone https://gitlab.com/team/yuma-ai.git
```

---

## 📤 PUSH TO BOTH (If You Want)

```bash
# One-time setup
git remote add github https://github.com/zacc-spec/Yuma.AI.git

# Then push to both:
git push gitlab main
git push github main

# Or all at once:
git push --all
```

---

## 🧪 TEST IT NOW

```bash
# Verify GitLab connection
git ls-remote gitlab --heads

# Should show your branches in GitLab

# Create test file
echo "test" > test-gitlab.txt
git add test-gitlab.txt
git commit -m "test: verify gitlab connection"
git push gitlab HEAD:test-branch

# Check on GitLab.com - should see new branch!

# Clean up
git push gitlab --delete test-branch
rm test-gitlab.txt
git reset HEAD~1
```

---

## 🆘 QUICK TROUBLESHOOTING

**Problem: "fatal: authentication required"**
```bash
# Solution: Authenticate again
gitlab auth login
# Or check token: https://gitlab.com/-/user_settings/personal_access_tokens
```

**Problem: "permission denied"**
```bash
# Check if you're added to the project
# Ask team lead to add you as Developer/Maintainer
```

**Problem: "remote gitlab does not exist"**
```bash
# Solution: Add the remote
git remote add gitlab https://gitlab.com/team/yuma-ai.git
```

**Problem: "conflicts when pushing"**
```bash
# Solution: Pull first, then push
git pull gitlab main
git push gitlab main
```

---

## 📋 CHECKLIST

- [ ] GitLab CLI installed
- [ ] Authenticated with `gitlab auth login`
- [ ] GitLab remote added: `git remote add gitlab ...`
- [ ] Pushed to GitLab: `git push gitlab main`
- [ ] Can see repo on GitLab.com
- [ ] Team can access it

---

## 🎯 REMEMBER

```
PRIMARY (Team):
git push gitlab main

SECONDARY (Personal):
git push github main

MINIMAL LOCAL:
cd ~ && rm -rf Yuma.AI    # Delete when not needed
git clone gitlab...        # Re-clone when needed
```

---

**You're ready to push to GitLab! 🚀**

Questions? See: GITLAB_SETUP_GUIDE.md
