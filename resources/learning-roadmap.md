# 🔐 Linux Permissions 

## 📖 Introduction

Linux is a **multi-user operating system**, so it uses a permission system to control who can read, write, or execute files and directories.

Permissions help protect files from unauthorized access and improve system security.

Every file and directory in Linux has:

- 👤 Owner (User)
- 👥 Group
- 🌍 Others (Everyone else)

---

# 👥 Permission Categories

There are three types of users for every file.

| Category | Symbol | Description |
|----------|--------|-------------|
| Owner | u | The user who owns the file |
| Group | g | Users belonging to the file's group |
| Others | o | Everyone else |
| All | a | User + Group + Others |

---

# 🔑 Permission Types

Linux has three basic permissions.

| Permission | Symbol | Value | Description |
|------------|--------|-------|-------------|
| Read | r | 4 | View file contents |
| Write | w | 2 | Modify file contents |
| Execute | x | 1 | Execute a file or access a directory |

---

# 📂 Understanding Permission Output

Use:

```bash
ls -l
```

Example:

```text
-rwxr-xr--
```

Breakdown

```text
- rwx r-x r--
│ │   │   │
│ │   │   └── Others
│ │   └────── Group
│ └────────── Owner
└──────────── File Type
```

---

## 📌 File Type

| Symbol | Meaning |
|---------|----------|
| - | Regular File |
| d | Directory |
| l | Symbolic Link |
| c | Character Device |
| b | Block Device |

---

## 📌 Permission Meaning

Example:

```text
-rwxr-xr--
```

| User | Permission |
|------|------------|
| Owner | Read + Write + Execute |
| Group | Read + Execute |
| Others | Read Only |

---

# 🔢 Numeric (Octal) Permissions

Each permission has a number.

| Permission | Value |
|------------|-------|
| Read | 4 |
| Write | 2 |
| Execute | 1 |

Add them together.

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

## Example

```text
755
```

Means

```text
Owner  = rwx = 7
Group  = r-x = 5
Others = r-x = 5
```

---

## Common Permission Values

| Number | Permission | Meaning |
|---------|------------|---------|
| 777 | rwxrwxrwx | Full access to everyone |
| 775 | rwxrwxr-x | Owner & Group full access |
| 755 | rwxr-xr-x | Standard executable permission |
| 744 | rwxr--r-- | Owner full access |
| 700 | rwx------ | Private file |
| 644 | rw-r--r-- | Standard file permission |
| 600 | rw------- | Private file |

---

# 🔧 chmod Command

## 📖 What is it?

The `chmod` command is used to change file and directory permissions.

---

## 📝 Syntax

```bash
chmod [OPTION] PERMISSION FILE
```

---

# Symbolic Mode

### Give Execute Permission

```bash
chmod +x script.sh
```

---

### Remove Write Permission

```bash
chmod -w file.txt
```

---

### Add Read Permission to Group

```bash
chmod g+r file.txt
```

---

### Remove Execute Permission from Others

```bash
chmod o-x script.sh
```

---

### Give Read & Write to Owner

```bash
chmod u+rw file.txt
```

---

# Numeric Mode

### Read/Write for Owner

```bash
chmod 600 file.txt
```

---

### Standard File Permission

```bash
chmod 644 file.txt
```

---

### Executable Script

```bash
chmod 755 script.sh
```

---

### Private Directory

```bash
chmod 700 private/
```

---

### Recursive Permission

```bash
chmod -R 755 Project/
```

---

# 📁 Directory Permissions

Directory permissions behave slightly differently.

## Read (r)

Allows listing directory contents.

```bash
ls
```

---

## Write (w)

Allows creating, deleting, and renaming files.

---

## Execute (x)

Allows entering the directory.

```bash
cd directory
```

---

# 🔍 Checking Permissions

View permissions

```bash
ls -l
```

View directory permissions

```bash
ls -ld foldername
```

---

# 🔐 Default Permissions

When new files are created:

Files

```text
666
```

Directories

```text
777
```

The system then subtracts the **umask** value.

Example

```
File:
666 - 022 = 644

Directory:
777 - 022 = 755
```

---

# 🎭 umask Command

## 📖 What is it?

The `umask` command sets the default permissions for newly created files and directories.

---

## View Current umask

```bash
umask
```

Example

```text
0022
```

---

## Set New umask

```bash
umask 027
```

---

# 🚨 Common Permission Errors

## Permission Denied

```text
Permission denied
```

Possible reasons:

- No execute permission
- No read permission
- File owned by another user
- Missing sudo privileges

---

## Fix

```bash
chmod +x script.sh
```

or

```bash
sudo chmod 755 script.sh
```

---

# ⭐ Best Practices

- ✔ Follow the Principle of Least Privilege.
- ✔ Avoid using `777` unless absolutely necessary.
- ✔ Use `755` for executable scripts and directories.
- ✔ Use `644` for regular files.
- ✔ Keep sensitive files with `600` or `700`.
- ✔ Regularly review file permissions using `ls -l`.
- ✔ Use groups instead of giving permissions to everyone.
- ✔ Use recursive permissions (`-R`) carefully.

---
