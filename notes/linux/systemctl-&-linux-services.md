# ⚙️ systemctl & Linux Services

## 📖 Introduction

In Linux, a **Service** is a program that runs in the background to perform a specific task. These services usually start automatically when the system boots and continue running until they are stopped.

Examples of Linux services:

- 🌐 Apache (httpd)
- 🔐 SSH (sshd)
- 🐳 Docker
- 🗄️ MySQL
- 📊 Cron

Modern Linux distributions use **systemd** to manage these services.

The **systemctl** command is used to start, stop, restart, enable, disable, and monitor services.

---

# 🏗️ What is systemd?

**systemd** is the first process started when Linux boots.

It has:

```text
PID = 1
```

Its responsibilities include:

- Starting system services
- Managing background processes
- Handling system startup
- Managing logs
- Managing dependencies between services

Check PID 1

```bash
ps -p 1
```

Output

```text
PID TTY      TIME CMD
1   ?        systemd
```

---

# ⚙️ What is systemctl?

The **systemctl** command is used to manage services controlled by **systemd**.

General Syntax

```bash
systemctl [COMMAND] SERVICE_NAME
```

Example

```bash
sudo systemctl status sshd
```

---

# 📋 Check Service Status

Displays whether a service is running, stopped, enabled, or failed.

Syntax

```bash
systemctl status service_name
```

Example

```bash
systemctl status sshd
```

Output

```text
Active: active (running)
```

---

# ▶️ Start a Service

Starts a stopped service.

Syntax

```bash
sudo systemctl start service_name
```

Example

```bash
sudo systemctl start httpd
```

Verify

```bash
systemctl status httpd
```

---

# ⏹️ Stop a Service

Stops a running service.

Syntax

```bash
sudo systemctl stop service_name
```

Example

```bash
sudo systemctl stop httpd
```

---

# 🔄 Restart a Service

Stops and starts the service again.

Useful after configuration changes.

Syntax

```bash
sudo systemctl restart service_name
```

Example

```bash
sudo systemctl restart sshd
```

---

# 🔁 Reload a Service

Reloads configuration without stopping the service.

Syntax

```bash
sudo systemctl reload service_name
```

Example

```bash
sudo systemctl reload httpd
```

---

# 🔄 Reload or Restart

If reload is supported, reloads the configuration.

Otherwise, restarts the service.

Syntax

```bash
sudo systemctl reload-or-restart service_name
```

---

# 🚀 Enable a Service

Configures the service to start automatically during system boot.

Syntax

```bash
sudo systemctl enable service_name
```

Example

```bash
sudo systemctl enable docker
```

---

# 🚫 Disable a Service

Prevents the service from starting automatically during boot.

Syntax

```bash
sudo systemctl disable service_name
```

Example

```bash
sudo systemctl disable docker
```

---

# 🔍 Check Whether a Service is Enabled

Syntax

```bash
systemctl is-enabled service_name
```

Example

```bash
systemctl is-enabled docker
```

Output

```text
enabled
```

or

```text
disabled
```

---

# 🟢 Check Whether a Service is Running

Syntax

```bash
systemctl is-active service_name
```

Example

```bash
systemctl is-active sshd
```

Output

```text
active
```

---

# 📋 List All Running Services

Syntax

```bash
systemctl list-units --type=service
```

---

# 📋 List All Services

Syntax

```bash
systemctl list-unit-files --type=service
```

---

# ❌ Mask a Service

Masking completely prevents a service from being started, even manually.

Syntax

```bash
sudo systemctl mask service_name
```

Example

```bash
sudo systemctl mask httpd
```

---

# ✅ Unmask a Service

Removes the mask from a service.

Syntax

```bash
sudo systemctl unmask service_name
```

Example

```bash
sudo systemctl unmask httpd
```

---

# 🔄 Restart Failed Services

Reload all systemd configuration.

```bash
sudo systemctl daemon-reload
```

Reload and re-execute systemd.

```bash
sudo systemctl daemon-reexec
```

---

# 📄 View Service Logs

Use **journalctl**.

View logs for a service.

```bash
journalctl -u sshd
```

Latest logs

```bash
journalctl -xe
```

Follow logs in real time

```bash
journalctl -f
```

---

# 📂 Service Files

Systemd service files are stored in:

```text
/usr/lib/systemd/system/
```

or

```text
/etc/systemd/system/
```

Example

```bash
ls /usr/lib/systemd/system
```

---

# 📌 Common Linux Services

| Service | Description |
|----------|-------------|
| sshd | SSH Server |
| httpd | Apache Web Server |
| nginx | Nginx Web Server |
| docker | Docker Engine |
| mysqld | MySQL Database |
| mariadb | MariaDB Database |
| crond | Cron Scheduler |
| NetworkManager | Network Management |
| firewalld | Firewall Service |

---

# 🌍 Real-world Examples

## Start Apache

```bash
sudo systemctl start httpd
```

---

## Enable Apache at Boot

```bash
sudo systemctl enable httpd
```

---

## Restart SSH

```bash
sudo systemctl restart sshd
```

---

## Check Docker Status

```bash
systemctl status docker
```

---

## View Apache Logs

```bash
journalctl -u httpd
```

---

## Stop Docker

```bash
sudo systemctl stop docker
```

---

## Disable Firewall

```bash
sudo systemctl disable firewalld
```

---

# ⚡ Frequently Used Commands

| Command | Description |
|----------|-------------|
| `systemctl status` | Check service status |
| `systemctl start` | Start a service |
| `systemctl stop` | Stop a service |
| `systemctl restart` | Restart a service |
| `systemctl reload` | Reload configuration |
| `systemctl enable` | Enable at boot |
| `systemctl disable` | Disable at boot |
| `systemctl is-active` | Check if running |
| `systemctl is-enabled` | Check boot status |
| `systemctl list-units` | Running services |
| `systemctl list-unit-files` | All installed services |
| `systemctl mask` | Prevent service from starting |
| `systemctl unmask` | Remove mask |
| `journalctl -u` | View service logs |

---

# ⭐ Best Practices

- ✔ Always check service status before troubleshooting.
- ✔ Use `restart` after changing configuration files.
- ✔ Prefer `reload` if supported to avoid downtime.
- ✔ Enable only required services at boot.
- ✔ Disable unnecessary services to improve security.
- ✔ Monitor logs using `journalctl`.
- ✔ Use `systemctl is-active` in shell scripts to verify service health.
- ✔ Run service management commands with `sudo` when required.

---

# 📝 Quick Summary

| Task | Command |
|------|---------|
| Check Status | `systemctl status service` |
| Start Service | `systemctl start service` |
| Stop Service | `systemctl stop service` |
| Restart Service | `systemctl restart service` |
| Reload Configuration | `systemctl reload service` |
| Enable at Boot | `systemctl enable service` |
| Disable at Boot | `systemctl disable service` |
| Check Running | `systemctl is-active service` |
| Check Boot Status | `systemctl is-enabled service` |
| List Running Services | `systemctl list-units --type=service` |
| List Installed Services | `systemctl list-unit-files --type=service` |
| View Logs | `journalctl -u service` |

---
