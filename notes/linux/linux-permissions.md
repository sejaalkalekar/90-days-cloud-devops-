# 🔐 Linux Permissions

## 📖 Introduction

Linux is a **multi-user operating system**, where multiple users can access the same system. To protect files and directories from unauthorized access, Linux uses a **permission system**.

Linux permissions define:

- 👀 Who can view a file
- ✏️ Who can modify a file
- ▶️ Who can execute a file
- 📁 Who can access a directory

Proper permission management is essential for **system security**, **data protection**, and **server administration**.

---

# 🎯 Why Permissions are Important

Linux permissions help to:

- Prevent unauthorized access
- Protect sensitive files
- Secure applications and servers
- Control who can read, write, or execute files
- Improve overall system security

---

# 👥 Permission Categories

Every file and directory has permissions assigned to three categories of users.

| Category | Symbol | Description |
|----------|--------|-------------|
| Owner (User) | `u` | The user who owns the file |
| Group | `g` | Members of the file's group |
| Others | `o` | All other users on the system |

Example

```text
-rwxr-xr--
```

```
Owner   Group   Others
 rwx      r-x      r--
```

---

# 🔑 Permission Types

Linux has three basic permissions.

| Permission | Symbol | Numeric Value | Meaning |
|------------|--------|---------------|---------|
| Read | r | 4 | View file contents |
| Write | w | 2 | Modify the file |
| Execute | x | 1 | Run the file as a program |

---

# 📂 File Permissions

For **files**, permissions work as follows.

| Permission | Meaning |
|------------|----------|
| r | Read the file |
| w | Edit or modify the file |
| x | Execute the file |

Example

```
-rwxr-xr--
```

Owner

```
rwx
```

Can read, write and execute.

Group

```
r-x
```

Can read and execute.

Others

```
r--
```

Can only read.

---

# 📁 Directory Permissions

Directory permissions work differently.

| Permission | Meaning |
|------------|----------|
| r | View directory contents |
| w | Create/Delete/Rename files |
| x | Enter the directory using `cd` |

Example

```
drwxr-xr-x
```

---

# 📋 Viewing Permissions

Use

```bash
ls -l
```

Example

```text
-rwxr-xr-- 1 sejal developers 2048 Jul 25 app.sh
```

Explanation

```
-

↓

File

rwx

↓

Owner

r-x

↓

Group

r--

↓

Others
```

---

# 📁 File Types

| Symbol | Meaning |
|----------|---------|
| - | Regular File |
| d | Directory |
| l | Symbolic Link |
| c | Character Device |
| b | Block Device |

Example

```
drwxr-xr-x
```

The first letter **d** means Directory.

---

# 🔢 Numeric Permission Method

Linux converts permissions into numbers.

| Permission | Value |
|------------|-------|
| Read | 4 |
| Write | 2 |
| Execute | 1 |

Examples

| Permission | Value |
|------------|-------|
| rwx | 7 |
| rw- | 6 |
| r-x | 5 |
| r-- | 4 |
| -wx | 3 |
| -w- | 2 |
| --x | 1 |
| --- | 0 |

---

# 🔢 Common Permission Values

| Numeric | Symbolic | Meaning |
|----------|----------|---------|
| 777 | rwxrwxrwx | Full access to everyone |
| 755 | rwxr-xr-x | Owner full, others read & execute |
| 700 | rwx------ | Only owner has access |
| 644 | rw-r--r-- | Owner read/write, others read |
| 600 | rw------- | Private file |
| 666 | rw-rw-rw- | Read & write for everyone |

---

# 🔧 chmod Command

## 📖 What is it?

The `chmod` command is used to change file and directory permissions.

---

## 📝 Syntax

```bash
chmod [permissions] filename
```

---

# Using Numeric Mode

Give full permissions to owner and read/execute to others.

```bash
chmod 755 app.sh
```

---

Private file

```bash
chmod 600 secrets.txt
```

---

Read-only file

```bash
chmod 444 report.txt
```

---

# Using Symbolic Mode

Add execute permission

```bash
chmod +x backup.sh
```

---

Remove write permission

```bash
chmod -w file.txt
```

---

Add write permission for owner

```bash
chmod u+w file.txt
```

---

Remove execute permission from group

```bash
chmod g-x file.sh
```

---

Give read permission to others

```bash
chmod o+r file.txt
```

---

Give execute permission to everyone

```bash
chmod a+x script.sh
```

---

# Symbolic Operators

| Symbol | Meaning |
|----------|---------|
| + | Add Permission |
| - | Remove Permission |
| = | Assign Exact Permission |

---

# User Symbols

| Symbol | Meaning |
|----------|---------|
| u | Owner |
| g | Group |
| o | Others |
| a | All Users |

---

# Recursive Permissions

Change permissions for an entire directory.

```bash
chmod -R 755 Project
```

---

# umask Command

## 📖 What is it?

`umask` defines the **default permissions** for newly created files and directories.

Check current umask

```bash
umask
```

Example Output

```text
0022
```

---

Default Permissions

| Item | Default | With umask 022 |
|------|----------|---------------|
| File | 666 | 644 |
| Directory | 777 | 755 |

---

# 🌍 Real-world Examples

## Make Script Executable

```bash
chmod +x deploy.sh
```

---

## Secure SSH Private Key

```bash
chmod 600 id_rsa
```

---

## Give Website Folder Permissions

```bash
chmod -R 755 /var/www/html
```

---

## Make Configuration File Private

```bash
chmod 600 config.ini
```

---

## Remove Write Permission

```bash
chmod a-w report.pdf
```

---

# 📌 Common Permission Commands

| Command | Description |
|----------|-------------|
| `ls -l` | View permissions |
| `chmod 755 file` | Change permissions using numbers |
| `chmod +x file` | Add execute permission |
| `chmod -R 755 dir` | Recursive permissions |
| `umask` | Display default permission mask |

---

# ⚠️ Common Mistakes

❌ Giving full permissions to everyone

```bash
chmod 777 file.txt
```

This is insecure and should be avoided unless absolutely necessary.

---

❌ Forgetting execute permission

```bash
./backup.sh
```

Permission denied?

Fix

```bash
chmod +x backup.sh
```

---

❌ Changing permissions recursively on system directories

Always verify the directory before using:

```bash
chmod -R
```

---

# ⭐ Best Practices

- ✔ Follow the **Principle of Least Privilege**.
- ✔ Avoid using `777` unless absolutely necessary.
- ✔ Use `755` for executable directories.
- ✔ Use `644` for normal files.
- ✔ Use `600` for sensitive files such as SSH keys.
- ✔ Verify permissions with `ls -l` after making changes.
- ✔ Use recursive permission changes carefully.
- ✔ Combine proper permissions with correct ownership (`chown`) for better security.

---

# 📝 Quick Summary

| Task | Command |
|------|---------|
| View Permissions | `ls -l` |
| Change Permissions | `chmod` |
| Add Execute Permission | `chmod +x file` |
| Remove Write Permission | `chmod -w file` |
| Recursive Permission Change | `chmod -R 755 dir` |
| View Default umask | `umask` |
| Private File | `chmod 600 file` |
| Executable Script | `chmod 755 script.sh` |

---
