# ⚙️ Processes in Linux

## 📖 Introduction

A **Process** is simply a **program that is currently running** in the Linux operating system.

Whenever you execute a command, open an application, or start a service, Linux creates a process for it.

For example:

- Opening Firefox creates a Firefox process.
- Running `vim` creates a Vim process.
- Starting Apache creates an Apache process.

Linux is a **multitasking operating system**, so it can run multiple processes simultaneously.

---

# 🧠 Process Lifecycle

Every process goes through different states during its lifetime.

```text
New
 ↓
Ready
 ↓
Running
 ↓
Waiting
 ↓
Running
 ↓
Terminated
```

---

# 📌 Types of Processes

## 1️⃣ Foreground Process

Runs directly in the terminal.

The terminal waits until the process finishes.

Example

```bash
ping google.com
```

The terminal is busy until you stop it.

Stop using

```bash
Ctrl + C
```

---

## 2️⃣ Background Process

Runs behind the terminal.

You can continue using the terminal while the process is running.

Example

```bash
ping google.com &
```

The **&** sends the process to the background.

---

## 3️⃣ Daemon Process

A daemon is a background service that starts automatically when Linux boots.

Examples

- SSH Server
- Apache
- Nginx
- Docker
- MySQL

Check running services

```bash
systemctl list-units --type=service
```

---

# 🆔 Process ID (PID)

Every process in Linux has a unique **Process ID (PID)**.

Example

```bash
ps
```

Output

```text
PID TTY          TIME CMD
2534 pts/0    00:00:00 bash
```

Here

```text
PID = 2534
```

---

# 👨 Parent Process (PPID)

Every process is created by another process called the **Parent Process**.

Linux stores its Parent Process ID (**PPID**).

Example

```bash
ps -ef
```

Output

```text
UID   PID  PPID
root  100    1
```

Here

```text
PPID = 1
```

---

# ⚙️ init / systemd Process

The very first process started by Linux is **systemd** (older systems use `init`).

It has

```text
PID = 1
```

It is responsible for starting all other processes and system services.

Check

```bash
ps -p 1
```

---

# 📋 Viewing Running Processes

## ps Command

Displays currently running processes.

Syntax

```bash
ps
```

---

### Show Detailed Information

```bash
ps -f
```

---

### Show All Processes

```bash
ps -e
```

or

```bash
ps -A
```

---

### Show Every Process in Full Format

```bash
ps -ef
```

---

### BSD Style Output

```bash
ps aux
```

---

# 📊 top Command

## 📖 What is it?

The **top** command displays real-time information about running processes.

Syntax

```bash
top
```

Displays

- CPU Usage
- Memory Usage
- Running Processes
- Load Average
- PID
- User

Quit

```text
q
```

---

# 📈 htop Command

`htop` is an improved version of `top`.

Features

- Colorful interface
- Easy navigation
- Search processes
- Kill processes directly

Install

Ubuntu

```bash
sudo apt install htop
```

RHEL / Amazon Linux

```bash
sudo yum install htop
```

Run

```bash
htop
```

---

# 🔍 pgrep Command

Search processes by name.

Syntax

```bash
pgrep process_name
```

Example

```bash
pgrep sshd
```

---

# 🔎 pidof Command

Displays the PID of a running program.

Example

```bash
pidof sshd
```

---

# ❌ Killing Processes

## kill Command

Terminates a process using its PID.

Syntax

```bash
kill PID
```

Example

```bash
kill 2456
```

---

## Force Kill

```bash
kill -9 PID
```

Example

```bash
kill -9 2456
```

Signal **9 (SIGKILL)** immediately stops the process.

---

## killall Command

Kills all processes with the same name.

Syntax

```bash
killall process_name
```

Example

```bash
killall firefox
```

---

## pkill Command

Kill process by name.

```bash
pkill apache2
```

---

# 🚦 Process Priorities

Linux schedules processes using **Priority**.

Lower priority processes receive less CPU time.

---

# nice Command

Start a process with a custom priority.

Syntax

```bash
nice -n value command
```

Example

```bash
nice -n 10 tar -czf backup.tar.gz Backup/
```

---

# renice Command

Change the priority of a running process.

Syntax

```bash
renice priority PID
```

Example

```bash
renice 5 2456
```

---

# 📂 Background Jobs

View jobs.

```bash
jobs
```

---

Run process in background.

```bash
command &
```

Example

```bash
sleep 100 &
```

---

Move foreground process to background.

Press

```text
Ctrl + Z
```

Then

```bash
bg
```

---

Bring process back.

```bash
fg
```

---

# ⏸️ Suspend a Process

Press

```text
Ctrl + Z
```

The process is paused.

Resume

Foreground

```bash
fg
```

Background

```bash
bg
```

---

# 📌 Process Signals

Signals are messages sent to a process.

| Signal | Number | Purpose |
|---------|--------|---------|
| SIGTERM | 15 | Gracefully terminate |
| SIGKILL | 9 | Force kill |
| SIGSTOP | 19 | Pause process |
| SIGCONT | 18 | Resume process |
| SIGHUP | 1 | Reload configuration |
| SIGINT | 2 | Interrupt (Ctrl + C) |

---

# 🔍 Process Tree

Display parent-child relationship.

```bash
pstree
```

Example

```text
systemd
 ├── sshd
 ├── nginx
 ├── mysqld
 └── docker
```

---

# 🌍 Real-world Examples

## Find Apache Process

```bash
ps -ef | grep httpd
```

---

## Kill a Hanging Process

```bash
kill -9 3521
```

---

## Monitor CPU Usage

```bash
top
```

---

## Find Docker Process

```bash
pgrep docker
```

---

## Run Backup in Background

```bash
tar -czf backup.tar.gz Backup/ &
```

---

# ⭐ Best Practices

- ✔ Use `ps -ef` to view running processes.
- ✔ Use `top` or `htop` for real-time monitoring.
- ✔ Use `kill` before using `kill -9`.
- ✔ Avoid killing system processes unless necessary.
- ✔ Run long tasks in the background using `&`.
- ✔ Monitor CPU and memory usage regularly.
- ✔ Use `nice` and `renice` to optimize system performance.
- ✔ Use `pstree` to understand process relationships.

---

# 📝 Quick Summary

| Command | Description |
|----------|-------------|
| `ps` | Display current processes |
| `ps -ef` | Show all running processes |
| `ps aux` | BSD-style process list |
| `top` | Real-time process monitor |
| `htop` | Interactive process viewer |
| `pgrep` | Find PID by process name |
| `pidof` | Display process ID |
| `kill PID` | Terminate process |
| `kill -9 PID` | Force kill process |
| `killall name` | Kill all matching processes |
| `pkill name` | Kill process by name |
| `jobs` | Display background jobs |
| `bg` | Resume process in background |
| `fg` | Bring process to foreground |
| `nice` | Start process with custom priority |
| `renice` | Change running process priority |
| `pstree` | Display process hierarchy |

---