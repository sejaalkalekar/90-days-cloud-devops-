# 📂 Linux File Management

Linux file management is one of the most essential skills for Linux Administrators, Cloud Engineers, and DevOps Engineers. Almost every daily task involves creating, organizing, navigating, copying, moving, searching, or deleting files and directories.

This guide covers the fundamental Linux commands required for efficient file management.

---

# 🎯 Learning Objectives

After completing these notes, you will be able to:

- Navigate the Linux file system
- Create files and directories
- List files and folders
- Understand file permissions
- Manage files efficiently
- Prepare for Linux interview questions

---

# 📍 pwd Command

## 📖 What is it?

`pwd` stands for **Print Working Directory**.

It displays the absolute path of the current directory you are working in.

---

## 📝 Syntax

```bash
pwd
```

---

## 💻 Examples

Display the current directory

```bash
pwd
```

Example Output

```text
/home/sejal/projects
```

---

## 🌍 Real-World Use Case

Before creating, deleting, or moving files, administrators often run `pwd` to verify they are in the correct directory.

This helps prevent accidental modifications in the wrong location.

---

## 💼 Interview Question

### What is the purpose of the `pwd` command?

**Answer:**

The `pwd` command displays the absolute path of the current working directory.

---

## ⚠️ Common Mistake

Executing commands like `rm -rf` without checking the current directory using `pwd`.

---

## 💡 Best Practice

Always verify your current directory before performing file operations.

---

# 📂 ls Command

## 📖 What is it?

The `ls` command lists files and directories in the current directory.

It is one of the most frequently used Linux commands.

---

## 📝 Syntax

```bash
ls
```

---

## 💻 Examples

List files

```bash
ls
```

List files inside another directory

```bash
ls Documents
```

List hidden files

```bash
ls -a
```

Human-readable file sizes

```bash
ls -lh
```

---

## 🌍 Real-World Use Case

After deploying an application, Linux administrators use `ls` to verify that required files have been copied successfully.

---

## 💼 Interview Question

### What does `ls` do?

**Answer:**

It displays files and directories in the current directory.

---

## ⚠️ Common Mistake

Assuming hidden files are missing because `ls` doesn't display them.

Use:

```bash
ls -a
```

---

## 💡 Best Practice

Use `ls -lh` when checking large files because it displays file sizes in KB, MB, and GB.

---

# 📋 ls -l Command

## 📖 What is it?

`ls -l` displays a detailed (long) listing of files and directories.

It provides important information like:

- Permissions
- Owner
- Group
- File Size
- Last Modified Date
- File Name

---

## 📝 Syntax

```bash
ls -l
```

---

## 💻 Example

```bash
ls -l
```

Output

```text
-rw-r--r-- 1 ubuntu ubuntu 1024 Jul 30 notes.txt
```

Explanation

| Field | Description |
|--------|-------------|
| -rw-r--r-- | File Permissions |
| 1 | Number of Links |
| ubuntu | Owner |
| ubuntu | Group |
| 1024 | File Size |
| Jul 30 | Last Modified Date |
| notes.txt | File Name |

---

## 🌍 Real-World Use Case

System administrators use `ls -l` to verify ownership and permissions of configuration files before deploying applications.

---

## 💼 Interview Question

### Why is `ls -l` useful?

**Answer:**

It provides detailed information about files, including permissions, ownership, size, and modification date.

---

## 💡 Best Practice

Use `ls -lh` for human-readable file sizes.

---

# 📁 cd Command

## 📖 What is it?

`cd` stands for **Change Directory**.

It is used to navigate between directories.

---

## 📝 Syntax

```bash
cd directory_name
```

---

## 💻 Examples

Move into a directory

```bash
cd Documents
```

Go to home directory

```bash
cd
```

Go to previous directory

```bash
cd ..
```

Go to root directory

```bash
cd /
```

Go to previous working directory

```bash
cd -
```

---

## 🌍 Real-World Use Case

Before editing application configuration files, administrators navigate to the configuration directory using `cd`.

---

## 💼 Interview Question

### What is the difference between `cd ..` and `cd -`?

**Answer:**

`cd ..` moves one directory up.

`cd -` returns to the previous working directory.

---

## ⚠️ Common Mistake

Trying to access a directory with spaces without using quotes.

Incorrect

```bash
cd My Folder
```

Correct

```bash
cd "My Folder"
```

---

## 💡 Best Practice

Use `pwd` after changing directories to confirm your current location.

---

# 📁 mkdir Command

## 📖 What is it?

`mkdir` stands for **Make Directory**.

It creates one or more directories.

---

## 📝 Syntax

```bash
mkdir directory_name
```

---

## 💻 Examples

Create one directory

```bash
mkdir project
```

Create multiple directories

```bash
mkdir HR Finance IT
```

Create nested directories

```bash
mkdir -p company/projects/backend
```

---

## 🌍 Real-World Use Case

While setting up a web server, you may create directories such as:

```text
logs/
config/
backup/
application/
```

using a single command.

---

## 💼 Interview Question

### What does the `-p` option do?

**Answer:**

It creates parent directories automatically if they don't already exist.

Example

```bash
mkdir -p company/projects/backend
```

---

## ⚠️ Common Mistake

Trying to create nested directories without using `-p`.

---

## 💡 Best Practice

Use meaningful directory names without spaces.

Example

```text
project_backup
```

instead of

```text
Project Backup
```

---

# 📄 touch Command

## 📖 What is it?

The `touch` command is used to create empty files.

It can also update the timestamp of an existing file.

---

## 📝 Syntax

```bash
touch filename
```

---

## 💻 Examples

Create one file

```bash
touch notes.txt
```

Create multiple files

```bash
touch app.log config.conf report.txt
```

Create different file types

```bash
touch index.html style.css script.js
```

Update timestamp

```bash
touch notes.txt
```

---

## 🌍 Real-World Use Case

Developers often create project files before writing code.

Example

```text
index.html
style.css
app.js
README.md
```

---

## 💼 Interview Question

### Does `touch` only create files?

**Answer:**

No.

If the file already exists, `touch` updates its last modified timestamp.

---

## ⚠️ Common Mistake

Expecting `touch` to create directories.

It only creates files.

---

## 💡 Best Practice

Use `touch` to quickly create multiple files during project setup.

Example

```bash
touch index.html style.css app.js README.md
```

---

## 🔗 Related Resources

> *(Update these links after creating the files in your repository.)*

- 📅 Daily Progress: `../../daily-progress/month-01/day-06-linux-file-management.md`
- 🚀 Project: `../../projects/linux-system-administration/linux-file-management-challenge/README.md`
- 📖 Linux Command Cheat Sheet: `../../resources/linux-command-cheatsheet.md`

---