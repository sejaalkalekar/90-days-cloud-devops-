# 👥 User & Group Management in Linux

## 📖 Introduction

User and Group Management is the process of creating, modifying, deleting, and managing users and groups in a Linux operating system.

It helps administrators control:

- 👤 Who can log in to the system
- 🔒 What files and directories users can access
- 👥 Which users belong to which groups
- 🛡️ What permissions users have on the system

Proper user and group management is one of the most important responsibilities of a Linux Administrator because it improves system security and simplifies permission management.

---

## 🎯 Why is User & Group Management Important?

- Prevent unauthorized access
- Secure sensitive files and directories
- Manage multiple users efficiently
- Assign permissions using groups
- Follow the Principle of Least Privilege (PoLP)

---

# 👤 Types of Users

Linux mainly has three types of users.

---

## 1️⃣ Root User

The **Root User** is the superuser of Linux.

It has complete control over the entire operating system.

### Features

- Full administrative privileges
- Can access and modify any file
- Can install or remove software
- Can create, modify, or delete users
- Can change system configuration

### UID

```
0
```

### Prompt

```bash
[root@server ~]#
```

The `#` symbol indicates the root user.

> ⚠️ Avoid using the root account for daily work. Use `sudo` whenever possible.

---

## 2️⃣ System User

System users are created automatically by Linux to run background services and system processes.

These accounts are **not meant for interactive login**.

### Examples

- apache
- mysql
- nginx
- daemon
- nobody

### UID Range

```
1 - 999
```

*(May vary slightly depending on the Linux distribution.)*

---

## 3️⃣ Normal User

A Normal User is created for everyday work.

This account has limited permissions and cannot modify system settings without administrative privileges.

### Examples

- sejal
- john
- ubuntu

### UID Range

```
1000 and above
```

### Prompt

```bash
[sejal@server ~]$
```

The `$` symbol indicates a normal user.

---

# 🆔 UID & GID

Every user and group in Linux has a unique numeric ID.

---

## UID (User ID)

UID uniquely identifies a user.

Examples:

| User | UID |
|------|----:|
| root | 0 |
| System Users | 1–999 |
| Normal Users | 1000+ |

Check UID using:

```bash
id username
```

Example:

```bash
id sejal
```

Output:

```bash
uid=1001(sejal)
gid=1001(sejal)
groups=1001(sejal)
```

---

## GID (Group ID)

GID uniquely identifies a group.

Every user belongs to at least one **Primary Group** and may belong to multiple **Secondary Groups**.

Example:

```
User
│
├── UID = 1001
│
├── Primary Group
│      GID = 1001
│
└── Secondary Groups
       docker
       developers
       awsadmins
```

---

## Primary Group

- Automatically created when a new user is created.
- Every user has exactly one primary group.

Example:

```bash
sejal
```

Primary Group:

```bash
sejal
```

---

## Secondary Groups

A user can belong to multiple secondary groups.

Example:

```
docker
developers
awsadmins
```

This allows users to share permissions across teams.

---

# 📁 Important User Files

Linux stores user and password information inside the **/etc** directory.

---

## 1️⃣ /etc/passwd

This file stores user account information.

It does **not** store passwords.

View the file:

```bash
cat /etc/passwd
```

Example:

```text
sejal:x:1001:1001:Sejal Kalekar:/home/sejal:/bin/bash
```

### Fields in /etc/passwd

| Field | Description |
|--------|-------------|
| Username | Login name |
| Password | Placeholder (`x`) |
| UID | User ID |
| GID | Primary Group ID |
| Comment | User description (GECOS) |
| Home Directory | User's home directory |
| Login Shell | Default shell |

Example:

```text
sejal : x : 1001 : 1001 : Sejal Kalekar : /home/sejal : /bin/bash
```

---

## 2️⃣ /etc/shadow

Stores encrypted user passwords and password aging information.

Only the **root user** can access this file.

View the file:

```bash
sudo cat /etc/shadow
```

Example:

```text
sejal:$6$Qh4....:19446:0:99999:7:::
```

### Information Stored

- Encrypted Password
- Last Password Change
- Minimum Password Age
- Maximum Password Age
- Warning Period
- Inactive Period
- Account Expiration Date

---

## 3️⃣ /etc/group

Stores information about Linux groups.

View:

```bash
cat /etc/group
```

Example:

```text
developers:x:1002:sejal,john
```

### Fields

| Field | Description |
|--------|-------------|
| Group Name | Name of the group |
| Password | Usually `x` |
| GID | Group ID |
| Members | Users belonging to the group |

---

## 4️⃣ /etc/gshadow

Stores encrypted group passwords and group administrator information.

Only root can access this file.

View:

```bash
sudo cat /etc/gshadow
```

Example:

```text
developers:!::
```

---

## 5️⃣ /etc/sudoers

Defines which users or groups are allowed to execute commands using `sudo`.

This file should **never** be edited directly.

Instead, use:

```bash
sudo visudo
```

---

## 📌 Summary

| File | Purpose |
|------|---------|
| `/etc/passwd` | User account information |
| `/etc/shadow` | Encrypted passwords & password aging |
| `/etc/group` | Group information |
| `/etc/gshadow` | Group passwords and administrators |
| `/etc/sudoers` | Sudo privileges |

---

## ⭐ Best Practices

- ✔ Never log in as the **root** user for daily tasks.
- ✔ Use `sudo` for administrative commands.
- ✔ Create separate user accounts for each person.
- ✔ Assign permissions through groups instead of individual users.
- ✔ Regularly remove unused user accounts.
- ✔ Protect `/etc/shadow` and `/etc/sudoers` from unauthorized access.

---

# 👤 User Management Commands

User management commands are used to create, modify, manage, and remove user accounts in Linux.

---

# 👤 useradd Command

## 📖 What is it?

The `useradd` command is used to create a new user account in Linux.

---

## 📝 Syntax

```bash
useradd [OPTIONS] username
```

---

## 💡 Example

Create a new user:

```bash
sudo useradd sejal
```

Create a user with a home directory:

```bash
sudo useradd -m sejal
```

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-m` | Create home directory |
| `-d` | Specify home directory |
| `-s` | Specify login shell |
| `-u` | Specify User ID (UID) |
| `-g` | Specify Primary Group |
| `-c` | Add user description |

---

## 📌 Notes

- Root privileges are required.
- By default, the password is not set.
- Use the `passwd` command after creating the user.

---

# 🔑 passwd Command

## 📖 What is it?

The `passwd` command is used to set or change a user's password.

---

## 📝 Syntax

```bash
passwd username
```

---

## 💡 Example

Set password for user:

```bash
sudo passwd sejal
```

Change your own password:

```bash
passwd
```

---

## 📌 Notes

- Passwords are stored in encrypted format inside `/etc/shadow`.
- Only the root user can change another user's password.

---

# 👤 whoami Command

## 📖 What is it?

Displays the username of the currently logged-in user.

---

## 📝 Syntax

```bash
whoami
```

---

## 💡 Example

```bash
whoami
```

Output:

```text
sejal
```

---

## 📌 Notes

Useful when switching between users using the `su` command.

---

# 🆔 id Command

## 📖 What is it?

Displays detailed information about a user.

---

## 📝 Syntax

```bash
id
```

Current user:

```bash
id
```

Specific user:

```bash
id username
```

---

## 💡 Example

```bash
id sejal
```

Output

```text
uid=1001(sejal)
gid=1001(sejal)
groups=1001(sejal),1002(developers)
```

---

## 📌 Information Displayed

- UID (User ID)
- GID (Primary Group ID)
- Secondary Groups

---

# 👥 groups Command

## 📖 What is it?

Displays all groups that a user belongs to.

---

## 📝 Syntax

Current user:

```bash
groups
```

Specific user:

```bash
groups username
```

---

## 💡 Example

```bash
groups sejal
```

Output

```text
sejal : sejal developers docker
```

---

## 📌 Notes

A user can belong to multiple groups.

---

# 👤 who Command

## 📖 What is it?

Displays all users currently logged into the system.

---

## 📝 Syntax

```bash
who
```

---

## 💡 Example

```bash
who
```

Output

```text
sejal pts/0 2026-08-02 09:30
john  pts/1 2026-08-02 10:05
```

---

## 📌 Notes

Useful on multi-user Linux servers.

---

# 🕒 last Command

## 📖 What is it?

Displays the login history of users.

---

## 📝 Syntax

```bash
last
```

---

## 💡 Example

```bash
last
```

Output

```text
sejal pts/0 192.168.1.10 Sun Aug 2 09:20 still logged in
```

---

## 📌 Notes

Useful for auditing and troubleshooting login activity.

---

# 🔄 su Command

## 📖 What is it?

The `su` (Switch User) command allows you to switch from one user account to another.

---

## 📝 Syntax

Switch user:

```bash
su username
```

Switch with full login environment:

```bash
su - username
```

Switch to root:

```bash
su -
```

---

## 💡 Example

```bash
su - sejal
```

Output

```text
Password:
```

After entering the password:

```bash
[sejal@server ~]$
```

---

## 📌 Notes

- `su username` keeps the current environment.
- `su - username` loads the user's login environment.
- Root privileges or the target user's password are required.

---

# ❌ userdel Command

## 📖 What is it?

The `userdel` command is used to delete an existing user account.

---

## 📝 Syntax

```bash
userdel username
```

Delete user and home directory:

```bash
userdel -r username
```

---

## 💡 Example

Delete only the user account:

```bash
sudo userdel sejal
```

Delete user along with the home directory:

```bash
sudo userdel -r sejal
```

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-r` | Remove home directory and mail spool |
| `-f` | Force deletion (Use carefully) |

---

## 📌 Notes

Without `-r`:

- User account is deleted.
- Home directory remains.

With `-r`:

- User account is deleted.
- Home directory is deleted.
- Mail spool is removed.

---

# 🔄 usermod Command

## 📖 What is it?

The `usermod` command is used to **modify an existing user account** in Linux.

It allows administrators to change various user properties such as:

- Username
- User ID (UID)
- Primary Group (GID)
- Home Directory
- Login Shell
- User Description
- Lock/Unlock User Account

---

## 📝 Syntax

```bash
usermod [OPTIONS] username
```

> ⚠️ Root or sudo privileges are required.

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-u` | Change User ID (UID) |
| `-g` | Change Primary Group (GID) |
| `-G` | Add Secondary Groups |
| `-c` | Change User Description (Comment) |
| `-d` | Change Home Directory |
| `-m` | Move existing files to new home directory (used with `-d`) |
| `-s` | Change Login Shell |
| `-l` | Change Username |
| `-L` | Lock User Account |
| `-U` | Unlock User Account |

---

## 💡 Examples

### Change UID

```bash
sudo usermod -u 2001 sejal
```

---

### Change Primary Group

```bash
sudo usermod -g developers sejal
```

---

### Add User to Secondary Groups

```bash
sudo usermod -aG docker,awsadmins sejal
```

> ✅ Always use **`-aG`** when adding a user to existing groups.

---

### Change User Description

```bash
sudo usermod -c "AWS Cloud Engineer" sejal
```

---

### Change Home Directory

```bash
sudo usermod -d /home/clouduser -m sejal
```

---

### Change Login Shell

First check available shells:

```bash
cat /etc/shells
```

Then change shell:

```bash
sudo usermod -s /bin/bash sejal
```

---

### Rename User

```bash
sudo usermod -l clouduser sejal
```

---

### Lock User Account

```bash
sudo usermod -L sejal
```

---

### Unlock User Account

```bash
sudo usermod -U sejal
```

---

## 📌 Notes

- Use `-aG` while adding secondary groups.
- Avoid changing UID on production servers unless necessary.
- Use `-m` with `-d` to move user files to the new home directory.

---

# 📄 User-related Fields (/etc/passwd)

The `/etc/passwd` file stores **user account information**.

View the file:

```bash
cat /etc/passwd
```

Example:

```text
sejal:x:1001:1001:Sejal Kalekar:/home/sejal:/bin/bash
```

---

## 📋 Fields in /etc/passwd

| Field | Description |
|--------|-------------|
| Username | Login name |
| Password | Placeholder (`x`) |
| UID | User ID |
| GID | Primary Group ID |
| Comment | User description (GECOS) |
| Home Directory | User's home directory |
| Login Shell | Default shell |

---

### Field Breakdown

```text
sejal:x:1001:1001:Sejal Kalekar:/home/sejal:/bin/bash
│     │ │    │      │              │             │
│     │ │    │      │              │             └── Login Shell
│     │ │    │      │              └──────────── Home Directory
│     │ │    │      └─────────────────────────── Comment
│     │ │    └────────────────────────────────── GID
│     │ └─────────────────────────────────────── UID
│     └───────────────────────────────────────── Password Placeholder
└─────────────────────────────────────────────── Username
```

---

# 🔐 Password-related Fields (/etc/shadow)

The `/etc/shadow` file stores **encrypted passwords** and **password aging information**.

Only the **root user** can access this file.

View:

```bash
sudo cat /etc/shadow
```

Example:

```text
sejal:$6$abc123...:19446:0:99999:7:::
```

---

## 📋 Fields in /etc/shadow

| Field | Description |
|--------|-------------|
| Username | User account name |
| Encrypted Password | Password stored in hashed format |
| Last Password Change | Number of days since Jan 1, 1970 |
| Minimum Days | Minimum days before password can be changed |
| Maximum Days | Password expiry period |
| Warning Days | Days before password expiry to warn the user |
| Inactive Days | Days after password expiry before account is disabled |
| Expiry Date | Account expiration date |
| Reserved | Reserved for future use |

---

# 🔑 chage Command

## 📖 What is it?

The `chage` command is used to manage **password aging policies** for Linux users.

It controls:

- Password expiration
- Minimum password age
- Maximum password age
- Warning period
- Account expiration
- Inactive period

---

## 📝 Syntax

```bash
chage [OPTIONS] username
```

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-l` | Display password aging information |
| `-m` | Set minimum password age |
| `-M` | Set maximum password age |
| `-W` | Set warning days |
| `-I` | Set inactive days |
| `-E` | Set account expiration date |

---

## 💡 Examples

### Display Password Aging Information

```bash
sudo chage -l sejal
```

Output:

```text
Last password change          : Aug 02, 2026
Password expires              : never
Password inactive             : never
Account expires               : never
Minimum number of days        : 0
Maximum number of days        : 99999
Warning days                  : 7
```

---

### Set Minimum Password Age

```bash
sudo chage -m 3 sejal
```

User cannot change the password again for **3 days**.

---

### Set Maximum Password Age

```bash
sudo chage -M 90 sejal
```

Password expires after **90 days**.

---

### Set Warning Days

```bash
sudo chage -W 7 sejal
```

Warn the user **7 days** before password expiry.

---

### Set Inactive Days

```bash
sudo chage -I 15 sejal
```

Disable the account **15 days after password expiry**.

---

### Set Account Expiration Date

```bash
sudo chage -E 2026-12-31 sejal
```

The account expires on **31 December 2026**.

---

# 🔐 Password Aging

Password Aging is a security feature that forces users to change passwords periodically.

It helps:

- Improve account security
- Reduce the risk of compromised passwords
- Enforce password policies
- Meet organizational compliance requirements

---

## Password Aging Parameters

| Parameter | Description |
|-----------|-------------|
| Minimum Days | Number of days before a password can be changed again |
| Maximum Days | Number of days a password remains valid |
| Warning Days | Days before expiry when users receive a warning |
| Inactive Days | Grace period after password expiry before disabling the account |
| Expiry Date | Date when the user account expires |

---

# 👥 Group Management

## 📖 What is Group Management?

Group Management is the process of **creating, modifying, deleting, and managing groups** in Linux.

A group is a collection of users. Instead of assigning permissions to each user individually, permissions can be assigned to a group, making administration easier.

### ✅ Benefits

- Simplifies permission management
- Makes administration easier
- Improves security
- Allows multiple users to share access to files and directories

---

## 📄 Important Group File

Linux stores group information in the following files.

### 📁 /etc/group

Stores group account information.

View the file:

```bash
cat /etc/group
```

Example:

```text
developers:x:1001:sejal,rahul
```

---

### 📋 Fields in /etc/group

| Field | Description |
|--------|-------------|
| Group Name | Name of the group |
| Password | Placeholder (`x`) |
| GID | Group ID |
| Members | Users belonging to the group |

---

### 📁 /etc/gshadow

Stores encrypted group passwords and group administrators.

View:

```bash
sudo cat /etc/gshadow
```

Example:

```text
developers:!:sejal:rahul,neha
```

---

## 👥 groupadd Command

### 📖 What is it?

The `groupadd` command is used to create a new group.

---

### 📝 Syntax

```bash
groupadd groupname
```

---

### 💡 Example

Create a group named **developers**

```bash
sudo groupadd developers
```

Verify

```bash
cat /etc/group
```

Output

```text
developers:x:1001:
```

---

## 👥 groupmod Command

### 📖 What is it?

The `groupmod` command is used to modify an existing group.

---

### 📝 Syntax

```bash
groupmod [OPTION] groupname
```

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-n` | Rename group |
| `-g` | Change Group ID (GID) |
| `-p` | Change group password *(rarely used)* |

---

### 💡 Rename a Group

```bash
sudo groupmod -n cloudteam developers
```

---

### 💡 Change Group ID

```bash
sudo groupmod -g 2001 cloudteam
```

---

### 💡 Change Group Password

```bash
sudo groupmod -p newpassword cloudteam
```

> ⚠️ Rarely used in modern Linux systems.

---

## 👥 groupdel Command

### 📖 What is it?

The `groupdel` command is used to delete an existing group.

---

### 📝 Syntax

```bash
groupdel groupname
```

---

### 💡 Example

```bash
sudo groupdel developers
```

Verify

```bash
cat /etc/group
```

---

## 👥 gpasswd Command

### 📖 What is it?

The `gpasswd` command is used to manage group memberships, administrators, and passwords.

---

## 📝 Syntax

```bash
gpasswd [OPTION] groupname
```

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-a` | Add a user to a group |
| `-d` | Remove a user from a group |
| `-A` | Assign group administrator(s) |
| `-M` | Replace all group members |
| `-r` | Remove group password |

---

### 💡 Add User to Group

```bash
sudo gpasswd -a sejal developers
```

Output

```text
Adding user sejal to group developers
```

---

### 💡 Remove User from Group

```bash
sudo gpasswd -d sejal developers
```

---

### 💡 Add Multiple Users

```bash
sudo gpasswd -M sejal,rahul,neha developers
```

> ⚠️ This replaces the existing member list.

---

### 💡 Assign Group Administrator

```bash
sudo gpasswd -A sejal developers
```

---

### 💡 Set Group Password

```bash
sudo gpasswd developers
```

You'll be prompted to enter a password twice.

---

### 💡 Remove Group Password

```bash
sudo gpasswd -r developers
```

---

## 👥 newgrp Command

### 📖 What is it?

The `newgrp` command allows a user to **switch to another group** without logging out.

It starts a new shell with the specified group as the current primary group.

---

### 📝 Syntax

```bash
newgrp groupname
```

---

### 💡 Example

```bash
newgrp developers
```

Check current group

```bash
id
```

or

```bash
groups
```

---

## 📌 Useful Group Commands

| Command | Purpose |
|----------|----------|
| `groups` | Show groups of current user |
| `groups username` | Show groups of a specific user |
| `id` | Display UID, GID and group information |
| `cat /etc/group` | View all groups |
| `cat /etc/gshadow` | View encrypted group information |

---

## ⭐ Best Practices

- ✔ Create groups based on job roles (developers, admins, testers).
- ✔ Assign permissions to groups instead of individual users.
- ✔ Use `gpasswd -a` to add users without modifying configuration files manually.
- ✔ Avoid assigning passwords to groups unless absolutely necessary.
- ✔ Review group memberships regularly using `groups` and `id`.
- ✔ Remove unused groups to keep the system organized.

---

# 🔐 Ownership

In Linux, every file and directory belongs to:

- **One User (Owner)**
- **One Group**

Ownership determines **who can access, modify, or execute** files and directories.

You can check ownership using:

```bash
ls -l
```

Example Output

```text
-rw-r--r-- 1 sejal developers 256 Aug 3 10:30 project.txt
```

Here,

- **Owner:** sejal
- **Group:** developers

---

# 👤 chown Command

## 📖 What is it?

The `chown` (Change Owner) command is used to change the **owner** or **owner and group** of a file or directory.

---

## 📝 Syntax

```bash
chown [OPTION] OWNER FILE
```

or

```bash
chown OWNER:GROUP FILE
```

---

## 💡 Examples

### Change Owner

```bash
sudo chown sejal project.txt
```

---

### Change Owner and Group

```bash
sudo chown sejal:developers project.txt
```

---

### Change Ownership Recursively

```bash
sudo chown -R sejal:developers Projects/
```

`-R` changes ownership of all files and subdirectories.

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-R` | Change ownership recursively |
| `-v` | Display every processed file |
| `--reference=file` | Copy ownership from another file |

---

# 👥 chgrp Command

## 📖 What is it?

The `chgrp` (Change Group) command is used to change the **group ownership** of files and directories.

---

## 📝 Syntax

```bash
chgrp GROUP FILE
```

---

## 💡 Examples

### Change Group

```bash
sudo chgrp developers project.txt
```

---

### Change Group Recursively

```bash
sudo chgrp -R developers Projects/
```

---

## 🔹 Common Options

| Option | Description |
|---------|-------------|
| `-R` | Change group recursively |
| `-v` | Display processed files |

---

# 🛡️ Sudo & Privileges

Linux follows the **Principle of Least Privilege**, meaning users only receive the permissions they need.

Administrative tasks require **superuser (root)** privileges.

---

# ⚡ sudo Command

## 📖 What is it?

The `sudo` command allows a permitted user to execute commands as the **root user** or another user.

Instead of logging in as root, Linux recommends using `sudo`.

---

## 📝 Syntax

```bash
sudo command
```

---

## 💡 Examples

Install a package

```bash
sudo yum install httpd
```

---

Restart a service

```bash
sudo systemctl restart httpd
```

---

Create a new user

```bash
sudo useradd clouduser
```

---

## Why Use sudo?

- Prevents accidental system damage
- Provides better security
- Logs administrative actions
- Allows controlled root access

---

# ⚙️ visudo Command

## 📖 What is it?

The `visudo` command is used to safely edit the **sudoers** configuration file.

Instead of editing `/etc/sudoers` directly, always use `visudo`.

---

## 📝 Syntax

```bash
sudo visudo
```

---

## Example

Allow user **sejal** to use sudo.

```text
sejal ALL=(ALL) ALL
```

---

Allow passwordless sudo

```text
sejal ALL=(ALL) NOPASSWD:ALL
```

> ⚠️ Use passwordless sudo carefully, as it grants administrative privileges without requiring authentication.

---

## Verify Sudo Access

```bash
sudo -l
```

Displays all commands the current user is allowed to execute.

---

# ⭐ Best Practices

- ✔ Create separate users for each administrator.
- ✔ Never use the **root** account for daily work.
- ✔ Grant sudo access only to trusted users.
- ✔ Prefer groups for permission management instead of assigning permissions individually.
- ✔ Use `sudo` instead of logging in directly as root.
- ✔ Always edit the sudoers file using `visudo`.
- ✔ Regularly review user accounts and remove inactive users.
- ✔ Follow the Principle of Least Privilege (PoLP).
- ✔ Use strong passwords and enable password aging policies.
- ✔ Verify file ownership before changing permissions.

---

## 🔗 Related Resources

| Resource | Link |
|----------|------|
| 🚀 Project | [User & Group Management Lab](../../projects/linux-system-administration/user-group-management/README.md) |
| 📖 Cheat Sheet | [Linux Command Cheat Sheet](../../resources/linux-command-cheatsheet.md) |
| 📚 Interview Questions | [Linux Interview Questions](../../resources/interview-questions.md) |