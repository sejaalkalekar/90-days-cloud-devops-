# 🔐 ACL: Giving Access Without Changing Ownership

## 📖 Introduction

**ACL (Access Control List)** is an advanced Linux permission system that allows you to give **specific permissions to individual users or groups** without changing the file owner or group.

Normally, Linux permissions work with only:

- 👤 Owner (User)
- 👥 Group
- 🌍 Others

But what if you want to give **only one specific user** access to a file?

That's where **ACL** comes in.

---

# 🤔 Why Do We Need ACL?

Suppose:

- Owner = **sejal**
- Group = **developers**
- User **rahul** needs access to the file.

Without ACL you have only three options:

- Change Owner ❌
- Change Group ❌
- Give permission to Everyone ❌

ACL solves this problem by allowing **individual permissions**.

---

## Example

Without ACL

```text
project.txt

Owner : sejal
Group : developers

Rahul needs access
```

Normally you cannot give permission only to Rahul.

Using ACL

```text
Owner : sejal
Group : developers

Rahul → Read & Write
Neha → Read Only
```

No ownership changes are required.

---

# 🎯 Benefits of ACL

- Give permissions to individual users
- Give permissions to multiple users
- Give permissions to multiple groups
- No need to change ownership
- Better security
- Flexible permission management

---

# 📦 Installing ACL

Most Linux distributions already include ACL support.

If not, install it.

### Amazon Linux / CentOS / RHEL

```bash
sudo yum install acl
```

### Ubuntu / Debian

```bash
sudo apt install acl
```

---

# 🔍 Check ACL Support

Check mounted filesystem.

```bash
mount | grep acl
```

or

```bash
tune2fs -l /dev/xvda1 | grep acl
```

---

# 📖 getfacl Command

## What is it?

The **getfacl** command displays ACL permissions of files and directories.

---

## Syntax

```bash
getfacl filename
```

---

## Example

```bash
getfacl project.txt
```

Output

```text
# file: project.txt
# owner: sejal
# group: developers

user::rw-
user:rahul:r--
group::r--
mask::r--
other::---
```

---

## Understanding the Output

| Entry | Meaning |
|--------|---------|
| user:: | Owner permissions |
| user:rahul | ACL permission for Rahul |
| group:: | Group permissions |
| mask:: | Maximum effective ACL permission |
| other:: | Others permissions |

---

# ✏️ setfacl Command

## What is it?

The **setfacl** command is used to add, modify, or remove ACL permissions.

---

## Syntax

```bash
setfacl [OPTION] file
```

---

# 👤 Give Permission to a User

### Read Permission

```bash
setfacl -m u:rahul:r project.txt
```

---

### Read & Write

```bash
setfacl -m u:rahul:rw project.txt
```

---

### Read, Write & Execute

```bash
setfacl -m u:rahul:rwx project.txt
```

---

Check

```bash
getfacl project.txt
```

---

# 👥 Give Permission to a Group

```bash
setfacl -m g:developers:rwx project.txt
```

---

# 📁 ACL on Directories

Give Rahul full access to a directory.

```bash
setfacl -m u:rahul:rwx Projects
```

---

### Recursive ACL

Apply permissions to all files and folders.

```bash
setfacl -R -m u:rahul:rwx Projects
```

---

# 📂 Default ACL

Default ACL automatically applies permissions to newly created files inside a directory.

---

## Syntax

```bash
setfacl -d -m u:rahul:rwx Projects
```

Now every new file created inside **Projects** inherits Rahul's permissions.

---

Check

```bash
getfacl Projects
```

Output

```text
default:user:rahul:rwx
```

---

# ❌ Remove ACL

Remove ACL for one user.

```bash
setfacl -x u:rahul project.txt
```

---

Remove ACL for one group.

```bash
setfacl -x g:developers project.txt
```

---

Remove all ACL entries.

```bash
setfacl -b project.txt
```

---

# 📋 View Files Having ACL

Run

```bash
ls -l
```

Example

```text
-rw-rwxr--+
```

Notice the **+**

The plus sign means the file has **ACL permissions**.

---

# 📌 Common ACL Commands

| Command | Description |
|----------|-------------|
| `getfacl file` | View ACL |
| `setfacl -m u:user:rwx file` | Add user ACL |
| `setfacl -m g:group:rwx file` | Add group ACL |
| `setfacl -d -m u:user:rwx dir` | Set default ACL |
| `setfacl -R -m u:user:rwx dir` | Apply ACL recursively |
| `setfacl -x u:user file` | Remove user ACL |
| `setfacl -x g:group file` | Remove group ACL |
| `setfacl -b file` | Remove all ACL entries |

---

# 🌍 Real-world Example

Suppose your project directory looks like this.

```text
Project/

Owner : sejal
Group : developers
```

Requirements

- Rahul → Read & Write
- Neha → Read Only
- Developers Group → Read & Execute

Commands

```bash
setfacl -m u:rahul:rw Project

setfacl -m u:neha:r Project

setfacl -m g:developers:rx Project
```

Verify

```bash
getfacl Project
```

---

# 🆚 Normal Permissions vs ACL

| Feature | Normal Permissions | ACL |
|---------|--------------------|-----|
| Owner | ✅ | ✅ |
| Group | ✅ | ✅ |
| Others | ✅ | ✅ |
| Multiple Users | ❌ | ✅ |
| Multiple Groups | ❌ | ✅ |
| Default ACL | ❌ | ✅ |
| Fine-Grained Control | ❌ | ✅ |

---

# ⭐ Best Practices

- ✔ Use ACL when permissions are needed for specific users.
- ✔ Prefer normal Linux permissions for simple scenarios.
- ✔ Use Default ACL for shared directories.
- ✔ Regularly audit ACLs using `getfacl`.
- ✔ Remove unused ACL entries with `setfacl -b`.
- ✔ Avoid granting unnecessary `rwx` permissions.
- ✔ Use recursive ACLs (`-R`) carefully on production systems.

---

# 📝 Quick Summary

| Command | Purpose |
|----------|---------|
| `getfacl` | View ACL permissions |
| `setfacl -m` | Add or modify ACL |
| `setfacl -d` | Set default ACL |
| `setfacl -R` | Apply ACL recursively |
| `setfacl -x` | Remove specific ACL |
| `setfacl -b` | Remove all ACLs |

---
