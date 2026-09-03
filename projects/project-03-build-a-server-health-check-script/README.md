# 🖥️ Server Health Check Script

A simple **Bash-based server health monitoring script** that checks important system resources and displays their current status in a clear and easy-to-read format.

This project is part of my **90-Day AWS Cloud & DevOps Engineering Challenge** and focuses on Linux system administration, Bash scripting, system monitoring, and automation.

---

## 📌 Project Overview

As a Cloud/DevOps Engineer, monitoring the health of servers is an important task.

Instead of manually running multiple Linux commands to check CPU, memory, disk space, uptime, and other system information, this project combines those checks into a single Bash script.

The script provides a quick overview of the server's current health.

---

## 🎯 Objectives

The main objectives of this project are:

* Understand Linux system monitoring
* Practice Bash scripting
* Automate repetitive health-check tasks
* Monitor important server resources
* Use Linux commands inside a Bash script
* Display system information in a user-friendly format
* Identify potential resource issues quickly

---

## 🛠️ Technologies & Tools

* **Linux**
* **Bash Shell Scripting**
* **Linux CLI**
* `uptime`
* `free`
* `df`
* `top`
* `ps`
* `awk`
* `grep`
* `sed`

---

## 📂 Project Structure

```text
server-health-check/
│
├── README.md
├── server-health-check.sh
├── sample-output.txt
│
└── screenshots/
```

---

## 🔍 Health Checks Performed

The script collects important information about the server, including:

### 1. Hostname

Displays the hostname of the system.

### 2. System Uptime

Shows how long the server has been running.

### 3. CPU Usage

Checks the current CPU utilization of the system.

### 4. Memory Usage

Displays:

* Total memory
* Used memory
* Available memory
* Memory utilization

### 5. Disk Usage

Checks filesystem usage and helps identify disks that are approaching their capacity limits.

### 6. Load Average

Displays the system load average to provide an indication of how heavily the server is being utilized.

### 7. Running Processes

Displays information about currently running processes.

---

## 🚀 How to Run the Script

### Step 1: Clone the Repository

```bash
git clone <your-repository-url>
```

Navigate to the project directory:

```bash
cd server-health-check
```

### Step 2: Give Execute Permission

```bash
chmod +x server-health-check.sh
```

### Step 3: Run the Script

```bash
./server-health-check.sh
```

Alternatively:

```bash
bash server-health-check.sh
```

---

## 📊 Example Output

A typical execution displays information similar to:

```text
========================================
       SERVER HEALTH CHECK
========================================

Hostname       : linux-server
Uptime         : 2 days, 4 hours

CPU Usage      : 18%
Memory Usage   : 42%
Disk Usage     : 36%

Load Average   : 0.45 0.38 0.31

Running Processes:
------------------
...

========================================
       HEALTH CHECK COMPLETED
========================================
```

> The exact output will vary depending on the system and its current resource usage.

---

## 🧠 What I Learned

Through this project, I practiced:

* Writing Bash scripts
* Working with Linux commands
* Using variables in Bash
* Using command substitution
* Working with conditional statements
* Processing command output
* Managing file permissions using `chmod`
* Executing shell scripts
* Monitoring CPU, memory, disk, and system load
* Automating multiple Linux health checks with a single script

---

## 💡 Why This Project Matters

Server monitoring is a fundamental part of **Cloud and DevOps engineering**.

In real-world environments, engineers need to quickly identify whether a server is:

* Running normally
* Running low on memory
* Running out of disk space
* Experiencing high CPU usage
* Under heavy system load

This project demonstrates how basic Linux commands and Bash scripting can be combined to automate these checks.

---

## 🔮 Future Improvements

The script can be extended in the future with:

* CPU usage threshold alerts
* Memory usage threshold alerts
* Disk space alerts
* Service availability checks
* Network connectivity checks
* Log file generation
* Email notifications
* Slack/Teams notifications
* Scheduled execution using `cron`
* Integration with AWS CloudWatch
* Centralized monitoring and alerting

---

## ✅ Project Status

**Status:** Completed ✅

**Challenge:** 90-Day AWS Cloud & DevOps Engineering Challenge

**Project:** 3 — Server Health Check Script

---

## 👨‍💻 Author

**Sejal Kalekar**

Aspiring **AWS Cloud & DevOps Engineer**

* GitHub: [sejaalkalekar](https://github.com/sejaalkalekar)
* LinkedIn: [Sejal Kalekar](https://www.linkedin.com/in/sejaalkalekar)
* X: [@sejaalkalekar](https://x.com/sejaalkalekar)

---

⭐ If you find this project useful, feel free to explore the other projects in my **90-Day AWS Cloud & DevOps Engineering Challenge**.
