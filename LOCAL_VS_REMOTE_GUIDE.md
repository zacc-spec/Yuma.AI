# 📁 Local vs Remote - What Goes Where

**Your Setup:** Keep tools locally, send code to GitLab/GitHub

---

## 🎯 Quick Rule

```
LOCAL MACHINE:
├─ Development tools (Docker, kubectl, Git, Node, Python)
├─ Dependencies (requirements.txt, package.json installed)
├─ Configuration files (for your local environment)
├─ IDE/VSCode setup
└─ Anything needed to WORK on the project

GITLAB/GITHUB (Remote - Project Code):
├─ Your actual code (backend/, frontend/, etc.)
├─ Project configuration (Dockerfile, docker-compose.yml)
├─ Project dependencies lists (requirements.txt, package.json)
├─ Documentation (README, guides)
├─ Database migrations
├─ Deployment scripts
└─ Everything your team needs to build/run the project
```

---

## ✅ What STAYS LOCAL (Don't Push These)

```
~/Yuma.AI/
├─ node_modules/           ❌ Don't push - too big
├─ __pycache__/           ❌ Don't push - auto-generated
├─ .venv/                 ❌ Don't push - local environment
├─ venv/                  ❌ Don't push - local environment
├─ dist/                  ❌ Don't push - built files
├─ build/                 ❌ Don't push - built files
├─ .DS_Store              ❌ Don't push - macOS junk
├─ .env                   ❌ Don't push - local secrets
├─ .env.local             ❌ Don't push - local config
└─ docker_data/           ❌ Don't push - database files
```

---

## 📤 What GOES TO GITLAB/GITHUB (Project Code)

```
~/Yuma.AI/
├─ backend/               ✅ All code
├─ frontend/              ✅ All code
├─ packages/              ✅ Configurations & scripts
│  ├─ docker/            ✅ Dockerfile, docker-compose.yml
│  ├─ kubernetes/        ✅ K8s manifests
│  ├─ terraform/         ✅ Infrastructure as code
│  ├─ helm/              ✅ Helm charts
│  └─ ai-generated/      ✅ AI scripts
├─ Dockerfile            ✅ Build instructions
├─ .gitignore            ✅ What to exclude
├─ package.json          ✅ Dependencies list (not node_modules)
├─ requirements.txt      ✅ Dependencies list (not .venv)
├─ README.md             ✅ Documentation
├─ .github/              ✅ Guardrails & docs
└─ [all source code]     ✅ Everything else
```

---

## 🏗️ TYPICAL LOCAL SETUP YOU NEED

### Installed on Your Computer

```bash
# Essential tools (stay on local drive)
/usr/local/bin/docker              # Container runtime
/usr/local/bin/kubectl             # Kubernetes
/usr/local/bin/git                 # Git
/usr/local/bin/python3             # Python
/usr/local/bin/node                # Node.js
/usr/local/bin/helm                # Helm
~/.kube/                            # Kubernetes config
~/.docker/                          # Docker config
~/.ssh/                             # SSH keys
```

### Installed in Project (Via .gitignore)

```bash
~/Yuma.AI/.venv/                   # Python virtual env (.gitignore)
~/Yuma.AI/node_modules/            # Node deps (.gitignore)
~/Yuma.AI/.env                     # Local config (.gitignore)
~/Yuma.AI/dist/                    # Build output (.gitignore)
```

### Pushed to GitLab/GitHub

```bash
~/Yuma.AI/requirements.txt         # Lists what to install (not .venv itself)
~/Yuma.AI/package.json             # Lists what to install (not node_modules itself)
~/Yuma.AI/Dockerfile               # Instructions to set up
~/Yuma.AI/docker-compose.yml       # Instructions to set up
~/Yuma.AI/.gitignore               # Defines what NOT to push
```

---

## 📝 Your .gitignore (Prevents Pushing Local Stuff)

Already exists, but verify it has:

```gitignore
# Dependencies (local installs)
node_modules/
__pycache__/
*.pyc
.venv/
venv/
ENV/

# Local environment files
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp

# Build outputs
dist/
build/
*.egg-info/

# Database
*.db
data/
postgres_data/

# OS
.DS_Store
Thumbs.db

# Docker
docker_data/

# Kubernetes
kubeconfig

# Cache
.cache/
.pytest_cache/
```

---

## 🔄 WORKFLOW: Local Work → Remote Code

```
Step 1:
Install tools/dependencies locally
├─ Node: npm install (creates node_modules locally)
├─ Python: pip install -r requirements.txt (creates .venv locally)
├─ Docker: docker build (works locally)
└─ Code is pushed: requirements.txt, package.json ✅

Step 2:
Edit code in ~/Yuma.AI/
├─ Edit: backend/main.py ✅ Push to GitLab
├─ Edit: frontend/App.jsx ✅ Push to GitLab
├─ Edit: Dockerfile ✅ Push to GitLab
├─ node_modules/ locally but NOT pushed ✅
└─ .venv/ locally but NOT pushed ✅

Step 3:
Commit and push code
├─ git add backend/ frontend/ Dockerfile ...
├─ git commit -m "my changes"
├─ git push gitlab main ✅
└─ Only code goes to GitLab, not dependencies ✅

Step 4:
Team pulls from GitLab
├─ git clone https://gitlab.com/team/yuma-ai.git
├─ npm install (creates their own node_modules locally)
├─ pip install -r requirements.txt (creates their own .venv locally)
└─ Code works everywhere! ✅
```

---

## 🛡️ KEY FILES (What Actually Gets Pushed)

These files tell people how to set up locally:

```
requirements.txt
├─ Lists all Python packages
├─ ONE per line with versions
├─ Example:
   Flask==3.0.0
   SQLAlchemy==2.0.23
   psycopg2-binary==2.9.9
└─ Installation: pip install -r requirements.txt

package.json
├─ Lists all Node packages
├─ Includes version ranges
├─ Example:
   {
     "dependencies": {
       "react": "^18.2.0",
       "vite": "^5.0.0"
     }
   }
└─ Installation: npm install

Dockerfile
├─ Instructions to build container
├─ Installs all dependencies
├─ Example:
   RUN pip install -r requirements.txt
   RUN npm install
└─ Build: docker build -t myapp .

docker-compose.yml
├─ Orchestrates services
├─ Defines databases, etc.
└─ Run: docker-compose up
```

---

## 📋 CHECKLIST: What's Local vs What's Remote

### Should Be on Your Local Machine
- [ ] Docker installed
- [ ] kubectl installed
- [ ] Git installed
- [ ] Python 3.9+ installed
- [ ] Node.js 18+ installed
- [ ] 1Password CLI installed
- [ ] Helm installed
- [ ] Virtual environment created (`.venv/`)
- [ ] Node modules installed (`node_modules/`)
- [ ] SSH keys (`~/.ssh/`)
- [ ] Git credentials configured

### Should Be in GitLab/GitHub (Code)
- [ ] All source code (backend/, frontend/)
- [ ] Dockerfile and docker-compose.yml
- [ ] requirements.txt (not .venv)
- [ ] package.json (not node_modules)
- [ ] Configuration files
- [ ] Database migrations
- [ ] Deployment scripts
- [ ] Documentation

### Should NOT Be in GitLab/GitHub
- [ ] `.venv/` or `venv/`
- [ ] `node_modules/`
- [ ] `.env` files with secrets
- [ ] Built files (`dist/`, `build/`)
- [ ] Database files (`*.db`)
- [ ] Generated files (`__pycache__/`)

---

## 🚀 TYPICAL DEVELOPER FLOW

**First Time Setup:**
```bash
# Clone from GitLab (code only)
git clone https://gitlab.com/team/yuma-ai.git
cd Yuma.AI

# Install dependencies locally (NOT in git)
npm install              # Creates node_modules locally
pip install -r requirements.txt  # Creates .venv locally

# Copy environment template
cp .env.example .env     # Edit with your secrets

# Now work
npm start
python backend/main.py
```

**Daily Work:**
```bash
# Pull latest code from GitLab
git pull gitlab main

# Your local dependencies still work (node_modules, .venv)

# Make changes and push
git add backend/
git commit -m "fix bug"
git push gitlab main
```

**Team member gets your code:**
```bash
# They clone (gets your code, not your dependencies)
git clone https://gitlab.com/team/yuma-ai.git

# Install their own dependencies locally
npm install
pip install -r requirements.txt

# It works because requirements.txt and package.json are identical
```

---

## 🎯 REAL EXAMPLE: Yuma.AI

```
YOUR LOCAL MACHINE (~):
├─ Yuma.AI/
│  ├─ .venv/ ❌ NOT in git
│  ├─ node_modules/ ❌ NOT in git
│  ├─ backend/main.py ✅ In git
│  ├─ frontend/App.jsx ✅ In git
│  ├─ requirements.txt ✅ In git
│  ├─ package.json ✅ In git
│  └─ ... other code ✅ In git
│
├─ /usr/local/bin/python ✅ Tools (local only)
├─ /usr/local/bin/node ✅ Tools (local only)
└─ ~/.ssh/ ✅ Keys (local only)

GITLAB (Remote):
├─ backend/ ✅
├─ frontend/ ✅
├─ requirements.txt ✅
├─ package.json ✅
├─ Dockerfile ✅
└─ ... all code ✅
```

---

## 💡 SIZE COMPARISON

```
Local:
├─ Yuma.AI/.venv/  ~200MB (local only)
├─ node_modules/   ~500MB (local only)
├─ Docker images   ~5GB (local only)
└─ Total: ~5.7GB on your computer

GitLab:
├─ All code        ~50MB (shared with team)
├─ Documentation   ~5MB (shared with team)
└─ Total: ~55MB in the repository

RESULT:
✅ Your computer: ~5.7GB of tools/dependencies
✅ GitLab: ~55MB of project code
✅ 100x smaller in repository!
```

---

## ✨ SUMMARY

```
RIGHT:
✅ Keep tools (Docker, kubectl, Python, Node) locally
✅ Keep dependencies installed locally (node_modules, .venv)
✅ Push the LISTS of dependencies (package.json, requirements.txt)
✅ Push all SOURCE CODE (backend/, frontend/, etc.)

WRONG:
❌ Push node_modules to GitLab
❌ Push .venv to GitLab
❌ Push built files to GitLab
❌ Push .env with secrets to GitLab
✅ BUT: Push configuration templates (.env.example)
```

---

**Perfect balance: Everything you need locally + code shared in GitLab!** 🎉
