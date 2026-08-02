# 🔐 Linux Special Permissions (SUID, SGID & Sticky Bit)

## 📖 Introduction

Apart from the normal **Read (r), Write (w), and Execute (x)** permissions, Linux provides **Special Permissions** to handle advanced security and access control.

There are **three special permissions**:

- 🔑 SUID (Set User ID)
- 👥 SGID (Set Group ID)
- 📌 Sticky Bit

These permissions allow users to execute programs with elevated privileges, share files securely, and protect shared directories.

---

# 🎯 Why Do We Need Special Permissions?

Normally,

- Programs run with the permissions of the **user who executes them**.
- Files can only be modified based on normal permissions.

Special permissions allow Linux to:

- Execute programs as another user.
- Share files safely between multiple users.
- Protect files in shared directories.

---

# 🔑 SUID (Set User ID)

## 📖 What is SUID?

SUID allows a user to execute a program with the **permissions of the file owner** instead of the current user.

Most commonly, the owner is the **root user**.

---

## 📝 Syntax

```bash
chmod u+s filename
```

Numeric Method

```bash
chmod 4XXX filename
```

---

## 💡 Example

Suppose the file belongs to root.

```bash
ls -l myscript
```

Output

```text
-rwxr-xr-x
```

Enable SUID

```bash
sudo chmod u+s myscript
```

or

```bash
sudo chmod 4755 myscript
```

Check

```bash
ls -l myscript
```

Output

```text
-rwsr-xr-x
```

Notice:

```text
rws
```

Instead of

```text
rwx
```

The **`s`** indicates that SUID is enabled.

---

## 🔍 Real-world Example

The **passwd** command updates the `/etc/shadow` file.

Normal users cannot modify `/etc/shadow`.

Check:

```bash
ls -l /usr/bin/passwd
```

Output

```text
-rwsr-xr-x
```

The SUID bit allows normal users to change **only their own password** while the program temporarily runs with **root privileges**.

---

## 📌 Key Points

- Applies only to executable files.
- Runs with the owner's privileges.
- Commonly owned by root.
- Displayed as **s** in the owner's execute field.

---

# 👥 SGID (Set Group ID)

## 📖 What is SGID?

SGID allows a program to run with the **group permissions** of the file instead of the user's primary group.

When applied to a **directory**, all newly created files inherit the directory's group.

---

## 📝 Syntax

```bash
chmod g+s filename
```

Numeric Method

```bash
chmod 2XXX filename
```

---

## 💡 Example (File)

Enable SGID

```bash
sudo chmod g+s script.sh
```

or

```bash
sudo chmod 2755 script.sh
```

Check

```bash
ls -l script.sh
```

Output

```text
-rwxr-sr-x
```

Notice the **s** in the group section.

---

## 💡 Example (Directory)

Create directory

```bash
mkdir developers
```

Assign group

```bash
sudo chgrp developers developers
```

Enable SGID

```bash
sudo chmod 2775 developers
```

Now every new file created inside the directory automatically belongs to the **developers** group.

---

## 📌 Key Points

- Works on files and directories.
- Files execute with group permissions.
- Directories inherit group ownership.
- Displayed as **s** in the group execute field.

---

# 📌 Sticky Bit

## 📖 What is Sticky Bit?

Sticky Bit protects files inside a shared directory.

Even if users have write permission, they **cannot delete files owned by other users**.

Only these users can delete a file:

- File Owner
- Directory Owner
- Root User

---

## 📝 Syntax

```bash
chmod +t directory
```

Numeric Method

```bash
chmod 1XXX directory
```

---

## 💡 Example

Enable Sticky Bit

```bash
sudo chmod +t shared
```

or

```bash
sudo chmod 1777 shared
```

Check

```bash
ls -ld shared
```

Output

```text
drwxrwxrwt
```

Notice

```text
t
```

at the end.

---

## 🔍 Real-world Example

The `/tmp` directory.

Check

```bash
ls -ld /tmp
```

Output

```text
drwxrwxrwt
```

Everyone can create files.

But users cannot delete files created by other users.

---

## 📌 Key Points

- Applies only to directories.
- Prevents accidental deletion.
- Used on shared folders.
- Displayed as **t** in Others execute field.

---

# 🔢 Numeric Values

| Special Permission | Value |
|--------------------|------:|
| SUID | 4 |
| SGID | 2 |
| Sticky Bit | 1 |

---

## Combined Permission Examples

| Permission | Numeric |
|------------|---------|
| SUID + 755 | 4755 |
| SGID + 755 | 2755 |
| Sticky + 777 | 1777 |
| SUID + SGID + 755 | 6755 |
| All Special Permissions | 7777 |

---

# 🔍 Checking Special Permissions

View permissions

```bash
ls -l
```

Example

```text
-rwsr-sr-t
```

Meaning

| Symbol | Description |
|--------|-------------|
| s (Owner) | SUID |
| s (Group) | SGID |
| t (Others) | Sticky Bit |

---

# ❌ Removing Special Permissions

Remove SUID

```bash
chmod u-s file
```

Remove SGID

```bash
chmod g-s file
```

Remove Sticky Bit

```bash
chmod -t directory
```

Numeric Method

```bash
chmod 755 filename
```

---

# 🌍 Real-world Uses

| Permission | Common Usage |
|------------|--------------|
| SUID | passwd, sudo, ping |
| SGID | Shared project directories |
| Sticky Bit | /tmp directory |
| SGID Directory | Development team collaboration |
| SUID Programs | Administrative utilities |

---

# ⚠️ Security Considerations

- Avoid enabling SUID on unnecessary programs.
- Regularly audit SUID files.
- Use Sticky Bit for shared directories.
- Limit SGID directories to trusted groups.
- Remove unused special permissions.

---

# ⭐ Best Practices

- ✔ Use SUID only when absolutely necessary.
- ✔ Never assign SUID to custom scripts unless required.
- ✔ Use SGID on shared project directories.
- ✔ Enable Sticky Bit on publicly writable directories.
- ✔ Periodically review special permissions using:

```bash
find / -perm /6000
```

List Sticky Bit directories

```bash
find / -perm -1000
```

- ✔ Follow the Principle of Least Privilege.

---

# 📝 Quick Summary

| Feature | SUID | SGID | Sticky Bit |
|---------|------|------|------------|
| Numeric Value | 4 | 2 | 1 |
| Symbol | s | s | t |
| Applied To | Files | Files & Directories | Directories |
| Purpose | Run as Owner | Run as Group / Inherit Group | Prevent File Deletion |
| Common Example | passwd | Shared Team Folder | /tmp |

---
