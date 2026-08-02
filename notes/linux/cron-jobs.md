# ⏰ Cron Jobs: Automating Tasks in Linux

## 📖 Introduction

A **Cron Job** is a scheduled task that runs automatically at a specified time or interval in Linux.

Instead of running commands manually every day, Linux can execute them automatically using the **cron service**.

Cron Jobs are commonly used for:

- 💾 Taking backups
- 📝 Generating reports
- 🧹 Cleaning temporary files
- 📧 Sending emails
- 📊 Monitoring servers
- 🔄 Running scripts automatically

---

# 🤔 What is Cron?

**Cron** is a background service (daemon) that executes scheduled tasks automatically.

The cron service continuously checks the **crontab** file every minute and executes scheduled commands.

Service Name

```text
crond
```

Check Cron Service Status

```bash
systemctl status crond
```

Start Cron Service

```bash
sudo systemctl start crond
```

Enable Cron Service at Boot

```bash
sudo systemctl enable crond
```

---

# 📋 What is Crontab?

**Crontab (Cron Table)** is a configuration file that stores scheduled cron jobs.

Each user can have their own crontab.

---

# 📝 Crontab Syntax

```text
* * * * * command_to_execute
│ │ │ │ │
│ │ │ │ └── Day of Week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of Month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

---

## Cron Time Fields

| Field | Values |
|---------|---------|
| Minute | 0 – 59 |
| Hour | 0 – 23 |
| Day of Month | 1 – 31 |
| Month | 1 – 12 |
| Day of Week | 0 – 7 (0 & 7 = Sunday) |

---

# 📌 Special Characters in Cron

| Symbol | Meaning |
|---------|----------|
| `*` | Every value |
| `,` | Multiple values |
| `-` | Range |
| `/` | Interval |
| `@` | Special schedules |

---

# 📖 Common Cron Expressions

## Every Minute

```text
* * * * *
```

---

## Every Hour

```text
0 * * * *
```

---

## Every Day at 2 AM

```text
0 2 * * *
```

---

## Every Sunday

```text
0 0 * * 0
```

---

## Every Monday at 9 AM

```text
0 9 * * 1
```

---

## Every 5 Minutes

```text
*/5 * * * *
```

---

## Every 10 Minutes

```text
*/10 * * * *
```

---

## Every Month on the 1st

```text
0 0 1 * *
```

---

## Every Year (January 1st)

```text
0 0 1 1 *
```

---

# ⚙️ Crontab Commands

## View Current Cron Jobs

```bash
crontab -l
```

---

## Edit Cron Jobs

```bash
crontab -e
```

This opens the default editor.

---

## Remove All Cron Jobs

```bash
crontab -r
```

⚠️ Deletes all scheduled jobs permanently.

---

## Prompt Before Deleting

```bash
crontab -i -r
```

---

## View Another User's Cron Jobs

```bash
sudo crontab -u username -l
```

Example

```bash
sudo crontab -u sejal -l
```

---

## Edit Another User's Cron Jobs

```bash
sudo crontab -u username -e
```

---

# 📂 System Cron Files

| File | Purpose |
|------|----------|
| `/etc/crontab` | System-wide cron table |
| `/etc/cron.hourly/` | Runs every hour |
| `/etc/cron.daily/` | Runs daily |
| `/etc/cron.weekly/` | Runs weekly |
| `/etc/cron.monthly/` | Runs monthly |

---

# 🌍 Real-world Examples

## Backup Every Day at Midnight

```text
0 0 * * * /home/sejal/scripts/backup.sh
```

---

## Every 5 Minutes

```text
*/5 * * * * /home/sejal/check_disk.sh
```

---

## Every Sunday

```text
0 8 * * 0 /home/sejal/report.sh
```

---

## Reboot Every Day at 3 AM

```text
0 3 * * * reboot
```

---

## Log Current Date Every Minute

```text
* * * * * date >> /home/sejal/date.log
```

---

## Delete Old Log Files Every Week

```text
0 1 * * 0 find /var/log -name "*.log" -mtime +30 -delete
```

---

# 🚀 Special Cron Keywords

Instead of writing time values, Linux supports predefined keywords.

| Keyword | Meaning |
|----------|----------|
| `@reboot` | Run once after system boot |
| `@yearly` | Once every year |
| `@annually` | Same as yearly |
| `@monthly` | Once every month |
| `@weekly` | Once every week |
| `@daily` | Once every day |
| `@midnight` | Every midnight |
| `@hourly` | Every hour |

---

## Examples

Run after every reboot

```text
@reboot /home/sejal/startup.sh
```

---

Run every day

```text
@daily /home/sejal/backup.sh
```

---

Run every hour

```text
@hourly /home/sejal/check.sh
```

---

# 📄 Logging Cron Output

Save output to a log file.

```text
0 * * * * /home/sejal/script.sh >> /home/sejal/script.log
```

---

Save both output and errors.

```text
0 * * * * /home/sejal/script.sh >> /home/sejal/script.log 2>&1
```

---

# ⚠️ Common Cron Mistakes

❌ Forgetting full file paths

Wrong

```text
backup.sh
```

Correct

```text
/home/sejal/scripts/backup.sh
```

---

❌ Script is not executable

Give execute permission.

```bash
chmod +x backup.sh
```

---

❌ Cron service not running

Check

```bash
systemctl status crond
```

---

❌ Environment variables are different

Cron does not load your shell environment automatically.

Always use full paths.

---

# 📌 Common Cron Commands

| Command | Description |
|----------|-------------|
| `crontab -e` | Edit cron jobs |
| `crontab -l` | List cron jobs |
| `crontab -r` | Remove all cron jobs |
| `systemctl status crond` | Check cron service |
| `systemctl start crond` | Start cron service |
| `systemctl enable crond` | Enable cron at boot |

---

# ⭐ Best Practices

- ✔ Use absolute paths for commands and scripts.
- ✔ Test your script manually before scheduling it.
- ✔ Redirect output to log files for troubleshooting.
- ✔ Keep cron jobs simple and well documented.
- ✔ Verify the `crond` service is running.
- ✔ Avoid scheduling too many jobs at the same time.
- ✔ Regularly review and remove unused cron jobs.
- ✔ Store automation scripts in a dedicated folder (e.g., `/home/user/scripts/`).

---

# 📝 Quick Summary

| Task | Command |
|------|---------|
| Edit Cron Jobs | `crontab -e` |
| List Cron Jobs | `crontab -l` |
| Delete Cron Jobs | `crontab -r` |
| Check Cron Service | `systemctl status crond` |
| Start Cron Service | `systemctl start crond` |
| Enable at Boot | `systemctl enable crond` |
| Every 5 Minutes | `*/5 * * * *` |
| Every Day at 2 AM | `0 2 * * *` |
| Run After Reboot | `@reboot` |

---
