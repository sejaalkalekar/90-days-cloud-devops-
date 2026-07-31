# 🚀 Project 01 – Linux Server Setup

> Learn the basics of Linux server administration by provisioning a Linux machine and performing common system administration tasks.

---

## 📌 Project Overview

This project demonstrates how to set up a Linux server from scratch and perform essential administration tasks. It covers connecting to the server, user management, file permissions, package installation, and basic system monitoring.

---

## 🎯 Objective

- Launch a Linux server
- Connect using SSH
- Create and manage users
- Configure file permissions
- Install required packages
- Monitor system resources
- Practice basic Linux commands

---

## 🏗️ Architecture

```
          +----------------+
          |   Local Laptop |
          +--------+-------+
                   |
                 SSH
                   |
          +--------v-------+
          | Linux Server   |
          | Ubuntu / Amazon|
          | Linux          |
          +----------------+
```

---

## 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| OS | Ubuntu 24.04 / Amazon Linux 2023 |
| Cloud | AWS EC2 *(Optional)* |
| Access | SSH |
| Terminal | Linux CLI |

---

## 📋 Prerequisites

- AWS Account *(Optional)*
- EC2 Instance *(or Virtual Machine)*
- SSH Key Pair
- Terminal / PowerShell
- Internet Connection

---

## 📂 Project Structure

```
project-01-linux-server-setup/
│
├── README.md
├── screenshots/
│   ├── login.png
│   ├── users.png
│   └── permissions.png
│
├── commands.md
│
├── scripts/
│   └── setup.sh
│
└── assets/
```

---

# 📝 Implementation Steps

## Step 1 - Launch Linux Server

- Create an EC2 instance
- Select Ubuntu / Amazon Linux
- Configure Security Group
- Download Key Pair
- Launch Instance

📸 Screenshot

```
screenshots/login.png
```

---

## Step 2 - Connect Using SSH

Command

```bash
ssh -i my-key.pem ubuntu@<public-ip>
```

Output

```
Connected Successfully
```

📸 Screenshot

```
screenshots/login.png
```

---

## Step 3 - Update Packages

Command

```bash
sudo apt update
sudo apt upgrade -y
```

Expected Result

- Packages updated successfully

---

## Step 4 - Create New User

Command

```bash
sudo adduser devops
```

Verify

```bash
cat /etc/passwd
```

📸 Screenshot

```
screenshots/users.png
```

---

## Step 5 - Give Sudo Access

Command

```bash
sudo usermod -aG sudo devops
```

Verify

```bash
groups devops
```

---

## Step 6 - File Permission Practice

Create File

```bash
touch demo.txt
```

Change Permission

```bash
chmod 755 demo.txt
```

Verify

```bash
ls -l
```

📸 Screenshot

```
screenshots/permissions.png
```

---

## Step 7 - Install Git

```bash
sudo apt install git -y
```

Verify

```bash
git --version
```

---

## Step 8 - Monitor System

Commands

```bash
df -h
free -h
top
uptime
```

---

# 📸 Screenshots

| Screenshot | Description |
|------------|-------------|
| login.png | SSH Login |
| users.png | User Creation |
| permissions.png | File Permissions |
| monitoring.png | System Monitoring |

---

# 📖 Commands Used

| Command | Purpose |
|----------|----------|
| pwd | Show current directory |
| ls | List files |
| cd | Change directory |
| mkdir | Create directory |
| touch | Create file |
| chmod | Change permissions |
| chown | Change ownership |
| useradd | Create user |
| passwd | Set password |
| df -h | Disk usage |
| free -h | Memory usage |
| top | System monitoring |

---

# ✅ Verification

- Successfully connected to Linux server
- User created successfully
- Sudo access verified
- File permissions changed
- Git installed
- System monitoring commands executed

---

# ⚠️ Challenges Faced

| Challenge | Solution |
|------------|----------|
| Permission denied while using SSH | Corrected SSH key permissions |
| Unable to install packages | Ran `sudo apt update` first |
| User couldn't use sudo | Added user to sudo group |

---

# 💡 Key Learnings

- Linux directory structure
- SSH connectivity
- User and group management
- File permissions
- Package management
- Basic Linux administration
- System monitoring commands

---

# 🚀 Future Improvements

- Install Docker
- Configure Nginx
- Automate setup using Bash
- Configure firewall
- Create backup script

---

# 📚 References

- Linux Documentation
- AWS Documentation
- Ubuntu Documentation

---

## 👨‍💻 Author

**Sejal Kalekar**

AWS & DevOps Enthusiast

📌 GitHub: https://github.com/sejaalkalekar

---

⭐ If you found this project helpful, consider giving the repository a star.