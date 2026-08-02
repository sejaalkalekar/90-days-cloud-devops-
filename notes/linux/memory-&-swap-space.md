# 🧠 Memory & Swap Space in Linux

## 📖 Introduction

Memory management is one of the most important responsibilities of the Linux operating system. Linux efficiently manages **RAM (Random Access Memory)** and **Swap Space** to ensure that multiple applications and services can run smoothly without running out of memory.

In Linux:

- **RAM** is the primary memory used by running processes.
- **Swap Space** is secondary memory used when RAM becomes full.

Proper memory management improves system performance, stability, and multitasking.

---

# 🧠 What is RAM?

**RAM (Random Access Memory)** is the physical memory installed in the computer.

It stores:

- Running programs
- Active processes
- Operating system data
- Frequently used information

RAM is much faster than a hard disk or SSD, but it is **volatile**, meaning all data is lost when the system is powered off.

---

## Example

When you open:

- Google Chrome
- VS Code
- Docker
- Apache Server

All these applications are loaded into **RAM**.

---

# 💽 What is Swap Space?

Swap Space is a reserved area on the hard disk or SSD that Linux uses as **virtual memory** when RAM becomes full.

Instead of stopping applications due to insufficient RAM, Linux temporarily moves inactive memory pages from RAM to Swap.

This process is called **Swapping**.

---

## Example

Suppose your system has:

```
RAM = 4 GB
```

You open applications using:

```
6 GB Memory
```

Linux moves approximately **2 GB** of less frequently used data into Swap Space.

---

# 🤔 Why Do We Need Swap?

Without Swap:

- Applications may crash
- System may freeze
- Out of Memory (OOM) errors may occur

With Swap:

- Better system stability
- More running applications
- Reduced risk of crashes
- Supports Hibernate (on many systems)

---

# ⚖️ RAM vs Swap Space

| Feature | RAM | Swap Space |
|----------|-----|------------|
| Location | Physical Memory | Hard Disk / SSD |
| Speed | Very Fast | Much Slower |
| Volatile | Yes | No |
| Purpose | Run Applications | Backup Memory |
| Performance | High | Lower |

---

# 📊 Check Memory Usage

## free Command

Displays RAM and Swap usage.

### Syntax

```bash
free
```

---

### Human Readable Format

```bash
free -h
```

Example Output

```text
              total   used   free   shared   buff/cache   available
Mem:           7.6G   2.4G   3.2G      150M      2.0G        4.8G
Swap:          2.0G      0B   2.0G
```

---

## Understanding the Output

| Field | Description |
|--------|-------------|
| total | Total RAM |
| used | Used RAM |
| free | Completely free RAM |
| shared | Shared memory |
| buff/cache | Memory used for caching |
| available | Memory available for applications |

---

# 📋 vmstat Command

Displays memory, CPU, process, and swap statistics.

### Syntax

```bash
vmstat
```

---

Example

```bash
vmstat 2
```

Updates every 2 seconds.

---

# 📈 top Command

Displays real-time memory usage.

```bash
top
```

Shows:

- RAM Usage
- Swap Usage
- CPU Usage
- Running Processes

Exit

```text
q
```

---

# 📊 htop Command

Improved version of `top`.

```bash
htop
```

Features:

- Interactive interface
- Memory graph
- CPU graph
- Process search

---

# 💾 Check Swap Usage

Display Swap summary.

```bash
swapon --show
```

or

```bash
swapon -s
```

---

# ❌ Disable Swap

Temporarily disable Swap.

```bash
sudo swapoff -a
```

---

# ✅ Enable Swap

Enable Swap.

```bash
sudo swapon -a
```

---

# 📂 View Memory Information

Linux stores memory information here:

```text
/proc/meminfo
```

View

```bash
cat /proc/meminfo
```

Example

```text
MemTotal:
MemFree:
SwapTotal:
SwapFree:
```

---

# 🔍 Check Running Processes Using Memory

Use

```bash
top
```

or

```bash
ps aux --sort=-%mem
```

This lists processes sorted by highest memory usage.

---

# 📊 Check Disk Space Used by Swap File

```bash
ls -lh /swapfile
```

(If your system uses a swap file.)

---

# ⚙️ Swappiness

Linux uses a **Swappiness** value to determine when it should start using Swap.

Value Range

```
0 – 100
```

Lower Value

- Uses RAM longer
- Less swapping

Higher Value

- Uses Swap earlier

---

## Check Swappiness

```bash
cat /proc/sys/vm/swappiness
```

Example

```text
60
```

---

## Temporarily Change Swappiness

```bash
sudo sysctl vm.swappiness=20
```

---

# 📌 Common Memory Commands

| Command | Description |
|----------|-------------|
| `free` | Display memory usage |
| `free -h` | Human-readable memory |
| `vmstat` | Memory statistics |
| `top` | Real-time monitoring |
| `htop` | Interactive monitoring |
| `cat /proc/meminfo` | Detailed memory information |
| `swapon --show` | Display swap usage |
| `swapoff -a` | Disable swap |
| `swapon -a` | Enable swap |
| `ps aux --sort=-%mem` | Memory-heavy processes |

---

# 🌍 Real-world Examples

## Check Available RAM

```bash
free -h
```

---

## Monitor Memory Live

```bash
top
```

---

## Find Highest Memory Consuming Processes

```bash
ps aux --sort=-%mem
```

---

## Check Swap Usage

```bash
swapon --show
```

---

## View Detailed Memory Information

```bash
cat /proc/meminfo
```

---

# ⭐ Best Practices

- ✔ Monitor memory regularly using `free -h`.
- ✔ Use `top` or `htop` to identify high-memory processes.
- ✔ Avoid excessive swapping, as it slows system performance.
- ✔ Keep sufficient free RAM for smooth multitasking.
- ✔ Use Swap as a backup, not as a replacement for RAM.
- ✔ Tune the **Swappiness** value based on your workload.
- ✔ Close unnecessary applications consuming excessive memory.
- ✔ Upgrade physical RAM if swap usage remains consistently high.

---

# 📝 Quick Summary

| Task | Command |
|------|---------|
| Check Memory | `free -h` |
| Monitor Memory | `top` |
| Interactive Monitor | `htop` |
| Memory Statistics | `vmstat` |
| Detailed Memory Info | `cat /proc/meminfo` |
| Check Swap | `swapon --show` |
| Enable Swap | `swapon -a` |
| Disable Swap | `swapoff -a` |
| High Memory Processes | `ps aux --sort=-%mem` |
| Check Swappiness | `cat /proc/sys/vm/swappiness` |

---
