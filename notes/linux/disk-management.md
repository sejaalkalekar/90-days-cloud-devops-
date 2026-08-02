# 💽 Disk Management in Linux (df, du & mount)

## 📖 Introduction

Disk Management in Linux is the process of managing **storage devices**, **partitions**, and **file systems**. It helps administrators monitor disk usage, mount storage devices, and ensure there is enough free space for applications and services.

Common tasks include:

- Checking available disk space
- Monitoring directory sizes
- Mounting and unmounting storage devices
- Managing file systems

Linux provides several commands for disk management, with the most commonly used being:

- 📊 `df` – Display filesystem disk space usage
- 📁 `du` – Display directory and file disk usage
- 💾 `mount` – Mount a filesystem
- 🔓 `umount` – Unmount a filesystem

---

# 💽 File System

A **File System** is the method Linux uses to organize and store data on a storage device.

Common Linux File Systems:

| File System | Description |
|------------|-------------|
| ext4 | Default Linux file system |
| xfs | High-performance file system (Amazon Linux, RHEL) |
| btrfs | Advanced Linux file system |
| vfat | Windows FAT filesystem |
| ntfs | Windows NT filesystem |

---

# 📊 df Command

## 📖 What is it?

The `df` (Disk Free) command displays the available and used disk space of mounted file systems.

---

## 📝 Syntax

```bash
df [OPTION]
```

---

## Display Disk Usage

```bash
df
```

Example Output

```text
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/xvda1      20961280 4234567 16726713  21% /
```

---

## Human Readable Format

```bash
df -h
```

Example

```text
Filesystem      Size Used Avail Use% Mounted on
/dev/xvda1       20G  4G   16G   21% /
```

---

## Display File System Type

```bash
df -Th
```

Output

```text
Filesystem     Type  Size Used Avail Use%
/dev/xvda1     xfs   20G   4G   16G   21%
```

---

## Check Specific Directory

```bash
df -h /home
```

---

# 📁 du Command

## 📖 What is it?

The `du` (Disk Usage) command displays the disk space used by files and directories.

Unlike `df`, which shows total filesystem usage, `du` shows the size of individual files and folders.

---

## 📝 Syntax

```bash
du [OPTION] FILE_OR_DIRECTORY
```

---

## Check Current Directory Size

```bash
du
```

---

## Human Readable Format

```bash
du -h
```

---

## Show Total Size Only

```bash
du -sh
```

Example

```bash
du -sh Projects
```

Output

```text
1.2G Projects
```

---

## Show All Subdirectories

```bash
du -ah
```

---

## Show Largest Files

```bash
du -ah | sort -rh | head
```

---

## Compare Folder Sizes

```bash
du -sh *
```

Example

```text
450M Downloads
2.3G Docker
120M Documents
```

---

# 💾 mount Command

## 📖 What is it?

The `mount` command is used to attach a storage device or file system to a directory so that Linux can access its contents.

Every mounted device is attached to a **Mount Point**.

---

## 📝 Syntax

```bash
mount [DEVICE] [MOUNT_POINT]
```

---

## View Mounted File Systems

```bash
mount
```

---

## Mount a Device

```bash
sudo mount /dev/xvdb1 /mnt
```

Now the contents of `/dev/xvdb1` are accessible through:

```text
/mnt
```

---

## Check Mounted Devices

```bash
df -h
```

or

```bash
mount | grep /mnt
```

---

# 🔓 umount Command

## 📖 What is it?

The `umount` command safely disconnects a mounted file system.

> **Note:** The command is `umount` (without the letter **n**).

---

## 📝 Syntax

```bash
sudo umount MOUNT_POINT
```

Example

```bash
sudo umount /mnt
```

---

## Unmount Using Device Name

```bash
sudo umount /dev/xvdb1
```

---

# 📂 Mount Points

A **Mount Point** is a directory where a storage device becomes accessible.

Example

```text
Storage Device
      │
      ▼
/dev/xvdb1
      │
      ▼
Mounted At
      │
      ▼
/mnt
```

---

# 📌 Check Mounted Devices

```bash
lsblk
```

Example Output

```text
NAME    SIZE TYPE MOUNTPOINT
xvda     20G disk /
xvdb     10G disk
└─xvdb1  10G part /mnt
```

---

## Display UUID

```bash
blkid
```

Example

```text
/dev/xvdb1:
UUID="1ab2-3cd4"
TYPE="xfs"
```

---

# 📂 Persistent Mounting (/etc/fstab)

Linux uses the **/etc/fstab** file to automatically mount file systems during system boot.

View the file:

```bash
cat /etc/fstab
```

Example Entry

```text
UUID=1ab2-3cd4 /mnt xfs defaults 0 0
```

---

# 📊 Useful Disk Commands

## List Block Devices

```bash
lsblk
```

---

## Display Disk Partitions

```bash
fdisk -l
```

---

## Display Filesystem UUID

```bash
blkid
```

---

## Show Mounted Devices

```bash
mount
```

---

## Show Free Inodes

```bash
df -i
```

---

# 🌍 Real-world Examples

## Check Free Disk Space

```bash
df -h
```

---

## Find Large Directories

```bash
du -sh *
```

---

## Find Top 10 Largest Files

```bash
du -ah | sort -rh | head -10
```

---

## Mount a New EBS Volume

```bash
sudo mount /dev/xvdb1 /mnt
```

---

## Unmount Before Removing Disk

```bash
sudo umount /mnt
```

---

## Check Mounted Volumes

```bash
lsblk
```

---

# ⚡ Frequently Used Commands

| Command | Description |
|----------|-------------|
| `df` | Display disk space |
| `df -h` | Human-readable disk usage |
| `df -Th` | Show filesystem type |
| `df -i` | Display inode usage |
| `du` | Directory disk usage |
| `du -sh` | Total directory size |
| `du -ah` | File and directory sizes |
| `du -sh *` | Compare folder sizes |
| `mount` | Display mounted filesystems |
| `mount device mountpoint` | Mount a device |
| `umount` | Unmount filesystem |
| `lsblk` | Display block devices |
| `blkid` | Show UUID information |
| `fdisk -l` | List partitions |
| `cat /etc/fstab` | View persistent mount configuration |

---

# ⭐ Best Practices

- ✔ Check disk space regularly using `df -h`.
- ✔ Use `du -sh` to identify large directories.
- ✔ Always unmount a device before disconnecting it.
- ✔ Use UUID instead of device names in `/etc/fstab`.
- ✔ Monitor disk usage to prevent storage from filling up.
- ✔ Remove unnecessary log files and backups regularly.
- ✔ Verify mounted devices using `lsblk` after mounting.
- ✔ Ensure proper permissions on mounted storage devices.

---

# 📝 Quick Summary

| Task | Command |
|------|---------|
| Check Disk Space | `df -h` |
| Show Filesystem Type | `df -Th` |
| Check Inode Usage | `df -i` |
| Check Directory Size | `du -sh` |
| Compare Folder Sizes | `du -sh *` |
| Show Largest Files | `du -ah \| sort -rh \| head` |
| Mount Device | `mount /dev/xvdb1 /mnt` |
| Unmount Device | `umount /mnt` |
| View Mounted Devices | `mount` |
| List Block Devices | `lsblk` |
| View Partitions | `fdisk -l` |
| View UUID | `blkid` |
| View Auto Mount Configuration | `cat /etc/fstab` |

---
