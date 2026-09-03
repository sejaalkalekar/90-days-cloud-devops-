# 📂 Linux File Management Implementation

## 🏢 Scenario

You have joined **ABC Technologies** as a **Junior Linux Administrator**.

Your manager has asked you to organize files for different departments by creating a structured directory hierarchy, managing files, creating backups, and performing common Linux file operations.

---

# 🚀 Implementation

## Step 1 – Create the Main Project Directory

```bash
mkdir ABC-Technologies
cd ABC-Technologies
pwd
```

Expected Output

```text
/home/ec2-user/ABC-Technologies
```

---

## Step 2 – Create Department Directories

```bash
mkdir HR IT Finance Logs Backup
```

Verify

```bash
ls
```

Expected Output

```text
Backup  Finance  HR  IT  Logs
```

---

## Step 3 – Create Nested Directory

```bash
mkdir -p IT/scripts
```

Verify

```bash
tree
```

---

## Step 4 – Create Required Files

### HR

```bash
touch HR/employees.txt
touch HR/policies.txt
```

### IT

```bash
touch IT/servers.txt
touch IT/passwords.txt
touch IT/scripts/backup.sh
```

### Finance

```bash
touch Finance/salary.xlsx
touch Finance/budget.xlsx
```

### Logs

```bash
touch Logs/app.log
touch Logs/server.log
touch Logs/errors.log
```

Verify

```bash
find .
```

---

## Step 5 – Add Sample Data

```bash
echo "John Doe" > HR/employees.txt
echo "Alice" >> HR/employees.txt
```

View the contents

```bash
cat HR/employees.txt
```

Output

```text
John Doe
Alice
```

---

## Step 6 – View Files

```bash
cat HR/employees.txt
```

View multiple files

```bash
cat HR/employees.txt HR/policies.txt
```

View large files

```bash
less HR/employees.txt
```

---

## Step 7 – Copy Files

Backup employee information

```bash
cp HR/employees.txt Backup/
```

Copy entire Logs directory

```bash
cp -r Logs Backup/
```

Verify

```bash
ls Backup
```

---

## Step 8 – Move Files

Move server log

```bash
mv Logs/server.log Backup/
```

Verify

```bash
tree Backup
```

---

## Step 9 – Rename Files

Rename employee file

```bash
mv HR/employees.txt HR/staff.txt
```

Verify

```bash
ls HR
```

---

## Step 10 – Rename Directory

Rename Finance directory

```bash
mv Finance Accounts
```

Verify

```bash
ls
```

---

## Step 11 – Delete Files

Delete unnecessary log

```bash
rm Logs/errors.log
```

Delete empty directory

```bash
rmdir EmptyFolder
```

> **Note:** Avoid deleting the `Backup` folder so it remains part of the final project structure.

---

## Step 12 – Search Files

Find all text files

```bash
find . -name "*.txt"
```

Find log files

```bash
find . -name "*.log"
```

Find shell scripts

```bash
find . -name "*.sh"
```

---

## Step 13 – Search Text

Search for a specific word

```bash
grep John HR/staff.txt
```

Recursive search

```bash
grep -r "password" .
```

---

## Step 14 – Count Files

Total files

```bash
find . -type f | wc -l
```

Total directories

```bash
find . -type d | wc -l
```

---

## Step 15 – Check Disk Usage

Directory size

```bash
du -sh .
```

Filesystem usage

```bash
df -h
```

---

## Step 16 – Manage Permissions

View permissions

```bash
ls -l
```

Make script executable

```bash
chmod +x IT/scripts/backup.sh
```

Verify

```bash
ls -l IT/scripts
```

---

## Step 17 – Archive the Backup Directory

Create archive

```bash
tar -cvf backup.tar Backup
```

Compress archive

```bash
gzip backup.tar
```

Verify

```bash
ls
```

---

## Step 18 – Verify Final Directory Structure

```bash
tree
```

Expected Output

```text
ABC-Technologies
├── Accounts
│   ├── budget.xlsx
│   └── salary.xlsx
├── Backup
│   ├── employees.txt
│   ├── Logs
│   └── server.log
├── HR
│   ├── policies.txt
│   └── staff.txt
├── IT
│   ├── passwords.txt
│   ├── scripts
│   │   └── backup.sh
│   └── servers.txt
└── Logs
    └── app.log
```

---

# ✅ Project Completed Successfully

You have successfully completed a Linux File Management challenge by:

- Creating and organizing directories
- Managing files
- Copying and moving data
- Renaming files and folders
- Searching files and content
- Managing permissions
- Creating compressed backups
- Verifying the final directory structure

---

## 🔗 Related Resources

| Resource | Link |
|----------|------|
| 📚 Notes |(https://github.com/sejaalkalekar/90-days-cloud-devops-/blob/main/notes/linux/file-management.md) |