# 🔀 Git & GitHub for DevOps Engineers

## 📖 Introduction

**Git** and **GitHub** are essential tools for DevOps Engineers.

In DevOps, we regularly work with:

* Application source code
* Infrastructure as Code (Terraform)
* CI/CD pipeline configurations
* Dockerfiles
* Kubernetes manifests
* Shell scripts
* Configuration files
* Documentation

Git helps us **track changes**, while GitHub helps us **store, collaborate on, and automate work around Git repositories**.

### Simple Example

```text
Developer changes code
        ↓
Git tracks the changes
        ↓
Code is pushed to GitHub
        ↓
GitHub Actions starts a CI/CD pipeline
        ↓
Application is built, tested, and deployed
```

---

# 🤔 What is Git?

**Git** is a distributed version control system.

It helps you:

* Track changes in files
* Maintain version history
* Compare changes
* Undo changes when needed
* Create branches
* Merge changes
* Collaborate with other developers
* Work on a project without affecting the main code

### Example

Suppose you update a Terraform file:

```text
main.tf
```

Git can track:

```text
Version 1 → Initial VPC
Version 2 → Added Public Subnet
Version 3 → Added Private Subnet
Version 4 → Added Internet Gateway
```

You can see what changed and, when appropriate, return to an earlier version.

---

# 🌐 What is GitHub?

**GitHub** is a cloud-based platform for hosting and collaborating on Git repositories.

GitHub provides features such as:

* Remote repositories
* Pull Requests
* Issues
* Code Reviews
* GitHub Actions
* Security features
* Branch protection
* Collaboration tools

### Git vs GitHub

| Git                            | GitHub                                    |
| ------------------------------ | ----------------------------------------- |
| Version control system         | Platform for hosting Git repositories     |
| Runs locally                   | Hosted online                             |
| Tracks file changes            | Stores and shares repositories            |
| Used with the Git command line | Provides web-based collaboration features |

---

# 🔄 Basic Git Workflow

The basic workflow is:

```text
Working Directory
       ↓
   git add
       ↓
Staging Area
       ↓
 git commit
       ↓
Local Repository
       ↓
  git push
       ↓
GitHub Remote Repository
```

---

# 📁 Git Repository

A **repository (repo)** is a project directory managed by Git.

For example:

```text
my-devops-project/
├── README.md
├── main.tf
├── Dockerfile
└── .github/
    └── workflows/
        └── deploy.yml
```

To initialize Git inside a project:

```bash
git init
```

This creates a hidden `.git` directory.

---

# ⚙️ Git Configuration

Before creating commits, configure your Git identity.

## Check Configuration

```bash
git config --list
```

## Set Username

```bash
git config --global user.name "Your Name"
```

## Set Email

```bash
git config --global user.email "your-email@example.com"
```

Check a specific value:

```bash
git config user.name
```

---

# 📌 git init

The `git init` command initializes a new Git repository.

## Syntax

```bash
git init
```

### Example

```bash
mkdir my-project
cd my-project
git init
```

Verify:

```bash
git status
```

---

# 🔍 git status

The `git status` command shows the current state of your repository.

It helps you identify:

* Modified files
* Untracked files
* Staged files
* Current branch

## Syntax

```bash
git status
```

---

# ➕ git add

The `git add` command adds changes to the **staging area**.

## Add One File

```bash
git add README.md
```

## Add Multiple Files

```bash
git add file1.txt file2.txt
```

## Add All Changes

```bash
git add .
```

> Always review `git status` before committing important changes.

---

# 💾 git commit

The `git commit` command saves staged changes to the local Git repository.

## Syntax

```bash
git commit -m "message"
```

### Example

```bash
git commit -m "Add VPC configuration"
```

A good commit message should clearly describe the change.

### Good Examples

```text
Add EC2 deployment script
Fix Terraform security group configuration
Update GitHub Actions workflow
Add Linux user management notes
```

---

# 📜 git log

The `git log` command displays commit history.

```bash
git log
```

A shorter format:

```bash
git log --oneline
```

Example:

```text
a1b2c3d Add VPC configuration
d4e5f6g Add README
h7i8j9k Initial commit
```

---

# 🔎 git diff

The `git diff` command shows changes that have not yet been committed.

```bash
git diff
```

To see staged changes:

```bash
git diff --staged
```

This is useful before creating a commit.

---

# ↩️ git restore

`git restore` is used to discard changes in the working directory.

## Restore a File

```bash
git restore README.md
```

⚠️ This discards uncommitted changes to that file.

## Unstage a File

```bash
git restore --staged README.md
```

---

# 🌿 Git Branches

A **branch** allows you to work on changes independently.

Example:

```text
main
 │
 ├── feature/add-vpc
 │
 ├── feature/add-ec2
 │
 └── fix/security-group
```

This allows new work to be developed without directly changing the main branch.

---

# 🌱 git branch

View branches:

```bash
git branch
```

Create a branch:

```bash
git branch feature/add-vpc
```

---

# 🔄 git switch

Switch to a branch:

```bash
git switch feature/add-vpc
```

Create and switch to a new branch:

```bash
git switch -c feature/add-vpc
```

Switch back to the main branch:

```bash
git switch main
```

---

# 🔀 git merge

The `git merge` command combines changes from one branch into another.

Example:

```bash
git switch main
git merge feature/add-vpc
```

Workflow:

```text
feature/add-vpc
       ↓
     merge
       ↓
      main
```

---

# ⚔️ Merge Conflicts

A **merge conflict** occurs when Git cannot automatically decide how to combine changes.

Example:

```text
<<<<<<< HEAD
security_group = "web-sg"
=======
security_group = "app-sg"
>>>>>>> feature/networking
```

To resolve a conflict:

1. Open the file.
2. Decide which changes should remain.
3. Remove Git conflict markers.
4. Save the file.
5. Stage the resolved file.

```bash
git add filename
git commit
```

---

# 🔗 Remote Repositories

A **remote repository** is a repository hosted somewhere other than your local machine.

Common commands:

```bash
git remote
```

View remote URLs:

```bash
git remote -v
```

Add a remote:

```bash
git remote add origin REPOSITORY_URL
```

Example:

```bash
git remote add origin https://github.com/username/repository.git
```

---

# ⬆️ git push

`git push` uploads local commits to a remote repository.

```bash
git push origin main
```

For the first push of a branch:

```bash
git push -u origin feature/add-vpc
```

The `-u` option sets the upstream branch.

After that, you can usually use:

```bash
git push
```

---

# ⬇️ git pull

`git pull` downloads changes from a remote repository and integrates them into your current branch.

```bash
git pull origin main
```

Conceptually:

```text
git fetch
    +
git merge
    =
git pull
```

---

# 📥 git fetch

`git fetch` downloads remote changes **without automatically merging them** into your current branch.

```bash
git fetch origin
```

This is useful when you want to inspect remote changes first.

---

# 📋 git clone

`git clone` creates a local copy of an existing remote repository.

```bash
git clone REPOSITORY_URL
```

Example:

```bash
git clone https://github.com/username/my-devops-project.git
```

---

# 🔁 git pull vs git fetch

| Command     | What It Does                             |
| ----------- | ---------------------------------------- |
| `git fetch` | Downloads remote changes without merging |
| `git pull`  | Downloads and integrates remote changes  |

---

# ⏪ git reset

`git reset` changes the current branch's position and can also unstage or discard changes depending on the option used.

## Unstage Changes

```bash
git reset HEAD README.md
```

A modern alternative is:

```bash
git restore --staged README.md
```

## Soft Reset

Keeps changes staged:

```bash
git reset --soft HEAD~1
```

## Mixed Reset

Keeps changes in the working directory but unstages them:

```bash
git reset HEAD~1
```

## Hard Reset

⚠️ Discards commits and local changes:

```bash
git reset --hard HEAD~1
```

Be extremely careful with `--hard`.

---

# ↩️ git revert

`git revert` creates a **new commit that reverses an earlier commit**.

```bash
git revert COMMIT_ID
```

Example:

```bash
git revert a1b2c3d
```

This is generally safer for undoing changes that have already been shared.

---

# 🏷️ Git Tags

Tags are commonly used to mark important versions or releases.

Example:

```text
v1.0.0
v1.1.0
v2.0.0
```

Create a tag:

```bash
git tag v1.0.0
```

Create an annotated tag:

```bash
git tag -a v1.0.0 -m "First production release"
```

Push a tag:

```bash
git push origin v1.0.0
```

Push all tags:

```bash
git push origin --tags
```

---

# 🙈 .gitignore

A `.gitignore` file tells Git which files or directories should not be tracked.

Example:

```gitignore
# Environment variables
.env

# Terraform
.terraform/
*.tfstate
*.tfstate.*

# Logs
*.log

# OS files
.DS_Store
```

### Important

Never commit sensitive information such as:

```text
Passwords
AWS Access Keys
API Keys
Private Keys
Secrets
```

---

# 🔐 GitHub and Authentication

When connecting to GitHub, you can use authentication methods such as:

* SSH keys
* HTTPS with an appropriate authentication method

For DevOps work, SSH keys are commonly used for Git operations.

Example remote:

```text
git@github.com:username/repository.git
```

---

# 🔑 Basic SSH Git Setup

Generate an SSH key:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

Start the SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add the private key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Copy the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Then add the public key to your GitHub account's SSH key settings.

Test the connection:

```bash
ssh -T git@github.com
```

---

# 🤝 Pull Requests

A **Pull Request (PR)** is used to propose changes and request review before merging them into another branch.

Typical workflow:

```text
Create Branch
      ↓
Make Changes
      ↓
git add
      ↓
git commit
      ↓
git push
      ↓
Create Pull Request
      ↓
Code Review
      ↓
Merge
```

Pull Requests are important in DevOps because infrastructure and deployment changes often require review before being applied.

---

# 🚀 GitHub Actions and DevOps

GitHub Actions is used to automate workflows directly from a GitHub repository.

Example:

```text
Developer pushes code
        ↓
GitHub Actions starts
        ↓
Run tests
        ↓
Build Docker image
        ↓
Push image to registry
        ↓
Deploy application
```

Workflow files are usually stored in:

```text
.github/workflows/
```

Example:

```text
.github/
└── workflows/
    └── deploy.yml
```

---

# 🏗️ Git for Infrastructure as Code

Git is extremely important when working with Infrastructure as Code.

Example Terraform repository:

```text
aws-infrastructure/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── modules/
```

Git allows teams to:

* Track infrastructure changes
* Review Terraform changes
* Maintain infrastructure history
* Collaborate safely
* Trigger automated deployments

A common workflow is:

```text
Terraform Change
      ↓
Feature Branch
      ↓
Pull Request
      ↓
Review
      ↓
CI Validation
      ↓
Merge
      ↓
Terraform Apply
```

---

# 🐳 Git for Docker

Git tracks Docker-related files such as:

```text
Dockerfile
docker-compose.yml
.dockerignore
```

Example workflow:

```bash
git add Dockerfile
git commit -m "Add Dockerfile"
git push
```

A CI/CD pipeline can then automatically build the Docker image.

---

# ☸️ Git for Kubernetes

Git repositories can store Kubernetes configuration files.

Example:

```text
kubernetes/
├── deployment.yaml
├── service.yaml
├── configmap.yaml
└── ingress.yaml
```

This approach is commonly used in **GitOps**, where Git acts as the source of truth for infrastructure and application configuration.

---

# 🔄 Common DevOps Git Workflow

```bash
# Check current status
git status

# Get latest changes
git pull origin main

# Create a feature branch
git switch -c feature/add-monitoring

# Make changes

# Review changes
git diff

# Stage changes
git add .

# Commit changes
git commit -m "Add monitoring configuration"

# Push branch
git push -u origin feature/add-monitoring

# Create Pull Request on GitHub
```

---

# 📌 Important Git Commands Cheat Sheet

| Command                   | Purpose                           |
| ------------------------- | --------------------------------- |
| `git init`                | Initialize a repository           |
| `git clone URL`           | Clone a repository                |
| `git status`              | Check repository status           |
| `git add FILE`            | Stage a file                      |
| `git add .`               | Stage changes                     |
| `git commit -m "message"` | Create a commit                   |
| `git log --oneline`       | View commit history               |
| `git diff`                | View unstaged changes             |
| `git branch`              | List branches                     |
| `git switch BRANCH`       | Switch branches                   |
| `git switch -c BRANCH`    | Create and switch branch          |
| `git merge BRANCH`        | Merge a branch                    |
| `git remote -v`           | View remote repositories          |
| `git push`                | Upload commits                    |
| `git pull`                | Download and integrate changes    |
| `git fetch`               | Download remote changes           |
| `git restore FILE`        | Discard working-directory changes |
| `git revert COMMIT_ID`    | Safely reverse a commit           |
| `git tag`                 | Manage tags                       |

---

# ⚠️ Common Mistakes

* ❌ Using `git add .` without checking changes
* ❌ Committing passwords or API keys
* ❌ Committing `.env` files containing secrets
* ❌ Using `git reset --hard` without understanding the impact
* ❌ Force-pushing to shared branches without understanding the consequences
* ❌ Working directly on `main` for major changes
* ❌ Writing unclear commit messages
* ❌ Pushing large unnecessary files
* ❌ Ignoring merge conflicts without reviewing them

---

# ⭐ Best Practices for DevOps Engineers

* ✔ Use meaningful commit messages.
* ✔ Review changes using `git diff` before committing.
* ✔ Check `git status` regularly.
* ✔ Use feature branches for changes.
* ✔ Use Pull Requests for important infrastructure changes.
* ✔ Never store secrets in Git.
* ✔ Use `.gitignore` to prevent unnecessary or sensitive files from being tracked.
* ✔ Review Infrastructure as Code before merging.
* ✔ Protect important branches such as `main`.
* ✔ Tag important releases.
* ✔ Keep commits small and focused.
* ✔ Treat Git repositories as a source of truth for code and configuration.
* ✔ Use CI/CD to automatically validate changes.

---

# 🎯 Why Git & GitHub Matter for DevOps

Git and GitHub are not just tools for developers.

For a DevOps Engineer, they are central to managing:

```text
Code
   +
Infrastructure
   +
Automation
   +
Configuration
   +
CI/CD Pipelines
   +
Docker
   +
Kubernetes
```

A typical DevOps workflow often starts with a Git change and ends with automated infrastructure or application deployment.

> **Simple way to remember it:**
> **Git tracks your work. GitHub helps teams collaborate and automate what happens after the change.**

---
