# 💾 AWS EBS & Snapshots

## 📖 Introduction

When you create an EC2 instance, you need **storage** to keep things like:

- Operating system files
- Applications
- Configuration files
- Logs
- User data
- Database files

AWS provides **Amazon EBS (Elastic Block Store)** to give EC2 instances persistent storage.

Think of EBS like a **hard disk attached to your EC2 server**.

```text
🖥️ EC2 Instance
      │
      │ Attached Storage
      ↓
💾 EBS Volume
````

EBS also provides **Snapshots**, which are backups of EBS volumes.

```text
💾 EBS Volume
      │
      │ Backup
      ↓
📸 EBS Snapshot
```

---

# 💾 1. What is Amazon EBS?

**Amazon Elastic Block Store (EBS)** is a block storage service designed to be used with EC2 instances.

In simple words:

> **EBS is like a virtual hard drive for your EC2 instance.**

Example:

```text
🖥️ EC2
   │
   └── 💾 EBS Volume
          │
          ├── OS files
          ├── Application
          ├── Logs
          └── Data
```

The important point is that EBS storage exists separately from the EC2 instance itself.

---

# 🧠 2. Why Do We Need EBS?

An EC2 instance needs storage to run its operating system and applications.

For example, when you launch an EC2 instance:

```text
EC2
 │
 └── Root EBS Volume
       │
       ├── Linux OS
       ├── Applications
       └── Configuration
```

You can also attach additional EBS volumes.

```text
EC2
 │
 ├── Root Volume
 │
 ├── Data Volume
 │
 └── Backup/Data Volume
```

This allows you to separate the operating system from application data.

---

# 🧱 3. What is an EBS Volume?

An **EBS Volume** is a block storage device that can be attached to an EC2 instance.

Think of it as:

```text
EBS Volume = Virtual Hard Disk
```

For example:

```text
EC2 Instance
      │
      ├── Root Volume
      │     └── 20 GB
      │
      └── Data Volume
            └── 100 GB
```

The root volume contains the operating system.

The data volume can store application or user data.

---

# 🔑 4. Root Volume vs Additional Volume

An EC2 instance can have multiple EBS volumes.

## 🖥️ Root Volume

The root volume contains the operating system.

Example:

```text
/dev/xvda
```

or on newer Nitro-based instances:

```text
/dev/nvme0n1
```

You normally don't need to memorize the device names as a beginner.

---

## 💾 Additional EBS Volume

You can attach another EBS volume for application data.

Example:

```text
EC2
 │
 ├── Root EBS
 │     └── Operating System
 │
 └── Data EBS
       └── Application Data
```

This is useful when you want to keep application data separate from the operating system.

---

# 📦 5. EBS is Persistent Storage

One of the most important things to understand:

> **EBS is persistent block storage.**

This means your data can remain available even when the EC2 instance is stopped.

Example:

```text
Running EC2
     │
     ↓
💾 EBS
     │
     ↓
EC2 Stopped
     │
     ↓
💾 EBS Data remains
```

So:

```text
Stop EC2 → EBS data remains ✅
```

However, storage behavior depends on how the volume and instance termination settings are configured.

---

# 🔄 6. What Happens When an EC2 Instance is Terminated?

When an EC2 instance is terminated, the **root EBS volume is commonly configured to be deleted automatically**.

Additional EBS volumes may remain depending on their **Delete on Termination** setting.

Example:

```text
EC2
 │
 ├── Root Volume
 │     └── Delete on Termination: Yes
 │
 └── Data Volume
       └── Delete on Termination: No
```

After termination:

```text
EC2 → Deleted ❌

Root Volume → Deleted ❌
Data Volume → Remains ✅
```

### 💡 Important

Always check the **Delete on termination** setting before terminating an EC2 instance when the data is important.

---

# 📏 7. EBS Volume Size

When creating an EBS volume, you choose its size.

Example:

```text
Volume Size: 20 GB
```

You could also create:

```text
Volume Size: 100 GB
```

or:

```text
Volume Size: 500 GB
```

The required size depends on your workload.

---

# ⚙️ 8. EBS Volume Types

AWS provides different EBS volume types for different workloads.

The commonly used types include:

| Volume Type | Simple Description        |
| ----------- | ------------------------- |
| gp3         | General-purpose SSD       |
| gp2         | Older general-purpose SSD |
| io2         | High-performance SSD      |
| st1         | Throughput-optimized HDD  |
| sc1         | Cold HDD                  |

### ⭐ For Beginners

The most important one to understand first is:

```text
gp3
```

**gp3** is a general-purpose SSD volume type suitable for many common workloads.

---

# 🚀 9. General Purpose SSD (gp3)

`gp3` is commonly used for:

* EC2 operating systems
* Applications
* Development environments
* Web servers
* General workloads

Example:

```text
EC2
 │
 └── gp3 EBS
       │
       ├── OS
       ├── Application
       └── Files
```

You can configure storage size and performance characteristics according to your workload.

---

# ⚡ 10. Provisioned IOPS SSD

Some applications require very high and consistent I/O performance.

For these workloads, AWS provides EBS volume types such as:

```text
io2
```

These are designed for workloads requiring high IOPS and low-latency storage.

Examples can include:

* Large databases
* Critical applications
* High-performance workloads

### Simple idea

```text
Normal workload
     ↓
   gp3

High I/O workload
     ↓
   io2
```

You don't need to use `io2` for every EC2 instance.

Choose the volume type based on your workload.

---

# 🗄️ 11. HDD-Based EBS Volumes

AWS also provides HDD-based volume types.

### st1

Designed for workloads that need high throughput.

Example:

```text
Large sequential data
        ↓
       st1
```

### sc1

Designed for infrequently accessed data where low cost is important.

```text
Infrequently accessed data
        ↓
       sc1
```

For most beginner EC2 labs, you will usually work with `gp3`.

---

# 📸 12. What is an EBS Snapshot?

An **EBS Snapshot** is a point-in-time backup of an EBS volume.

Think of it like taking a **photo of your EBS volume's data**.

```text
💾 EBS Volume
      │
      │ Snapshot
      ↓
📸 EBS Snapshot
```

The snapshot can be used later to create another EBS volume.

---

# 💡 13. Why Do We Need Snapshots?

Suppose your EC2 server contains important application data.

```text
EC2
 │
 └── EBS
      │
      └── Important Data
```

You can create a snapshot:

```text
EBS
 │
 ↓
Snapshot
 │
 ↓
Backup
```

If you later need another volume containing that data, you can create a new EBS volume from the snapshot.

---

# 🔄 14. Snapshot to New EBS Volume

The basic process is:

```text
💾 EBS Volume
      │
      │ Create Snapshot
      ↓
📸 Snapshot
      │
      │ Create Volume
      ↓
💾 New EBS Volume
```

This is useful for:

* Backup
* Disaster recovery
* Creating test environments
* Creating copies of data
* Recovering data

---

# 🧪 15. Simple Snapshot Example

Suppose you have:

```text
EC2
 │
 └── EBS Volume
       └── Application Data
```

Create a snapshot:

```text
EBS
 ↓
📸 Snapshot-01
```

Later:

```text
Snapshot-01
     ↓
New EBS Volume
     ↓
Attach to EC2
```

You now have a new volume created from the snapshot.

---

# 🏗️ 16. Creating an EBS Volume

You can create an EBS volume from the AWS Console.

### Step 1: Open EC2

Go to:

```text
AWS Console
→ EC2
→ Volumes
```

---

### Step 2: Create Volume

Choose:

```text
Volume Type: gp3
Size: 10 GiB
Availability Zone: Same AZ as EC2
```

### ⚠️ Important

An EBS volume must generally be in the **same Availability Zone** as the EC2 instance you want to attach it to.

Example:

```text
EC2
Availability Zone: ap-south-1a

EBS
Availability Zone: ap-south-1a

Result:
Can attach ✅
```

But:

```text
EC2
ap-south-1a

EBS
ap-south-1b

Result:
Cannot directly attach ❌
```

---

# 🔗 17. Attaching an EBS Volume to EC2

After creating the volume:

```text
EC2
→ Volumes
→ Select Volume
→ Actions
→ Attach Volume
```

Choose the EC2 instance.

Then AWS attaches the volume to the instance.

```text
🖥️ EC2
   │
   ├── Root EBS
   │
   └── Additional EBS
```

---

# 🖥️ 18. EBS Volume Inside Linux

After attaching a new EBS volume, Linux needs to recognize it.

You can check available disks using:

```bash
lsblk
```

Example:

```text
NAME        SIZE
nvme0n1      20G
├─nvme0n1p1  20G
└─
nvme1n1     10G
```

Here:

```text
nvme0n1 → Existing/root disk
nvme1n1 → Newly attached disk
```

---

# 📁 19. Formatting and Mounting an EBS Volume

A new EBS volume may need to be:

1. Detected
2. Formatted
3. Mounted

Example:

```bash
lsblk
```

Create a filesystem:

```bash
sudo mkfs -t ext4 /dev/nvme1n1
```

Create a mount directory:

```bash
sudo mkdir /data
```

Mount the volume:

```bash
sudo mount /dev/nvme1n1 /data
```

Check:

```bash
df -h
```

You should now see the mounted storage.

```text
/dev/nvme1n1
      ↓
    /data
```

### ⚠️ Warning

`mkfs` formats the disk and can erase existing data.

Never run it on a disk containing important data without verifying the device.

---

# 🔄 20. Mounting After Reboot

A manually mounted volume may not automatically mount after a reboot.

To make the mount persistent, you can configure:

```text
/etc/fstab
```

A safer approach is to use the volume's UUID.

First find the UUID:

```bash
sudo blkid
```

Then add the appropriate entry to:

```text
/etc/fstab
```

This is an important Linux storage concept to learn alongside EBS.

---

# 📸 21. Creating an EBS Snapshot

To create a snapshot:

```text
AWS Console
→ EC2
→ Volumes
→ Select EBS Volume
→ Actions
→ Create Snapshot
```

Provide a description.

Example:

```text
Before application update
```

Then create the snapshot.

---

# 📋 22. Snapshot States

A snapshot may have different states.

For example:

```text
pending
completed
error
```

When you create a snapshot, it may initially show:

```text
pending
```

After AWS finishes creating it:

```text
completed
```

You should check the snapshot status before relying on it as a completed backup.

---

# 💰 23. EBS and Snapshot Costs

EBS and snapshots can create additional AWS costs.

You may be charged for:

* EBS volume storage
* Snapshot storage
* Provisioned performance where applicable
* Data transfer in certain scenarios

### 💡 Cost Optimization

Delete resources that you no longer need.

For example:

```text
Unused EBS Volume
        ↓
Additional Cost
```

Similarly, old snapshots can continue to consume storage.

Always review unused volumes and snapshots.

---

# 🧹 24. Delete Unused EBS Volumes

An EBS volume can continue to exist even after an EC2 instance is terminated, depending on its configuration.

Check:

```text
AWS Console
→ EC2
→ Volumes
```

Look for volumes that are:

```text
State: available
```

An `available` volume is not currently attached to an EC2 instance.

If you no longer need it, delete it.

### ⚠️ Warning

Deleting an EBS volume permanently removes its data.

Create a snapshot first if you need a backup.

---

# 🔐 25. EBS Encryption

EBS volumes can be encrypted.

Encryption helps protect data stored on the volume.

```text
Application
     ↓
🔐 Encrypted EBS
     ↓
Stored Data
```

EBS encryption can help protect:

* Data at rest
* Snapshots
* Data copied between volumes

AWS KMS keys are used for EBS encryption.

### Beginner Rule

For production workloads:

> Prefer encrypted EBS volumes unless there is a specific reason not to.

---

# 🆚 26. EBS vs EBS Snapshot

This is an important difference.

| Feature               | EBS Volume    | EBS Snapshot               |
| --------------------- | ------------- | -------------------------- |
| Purpose               | Store data    | Backup/copy of volume data |
| Used directly by EC2  | Yes           | No                         |
| Storage type          | Block storage | Snapshot backup            |
| Can attach to EC2     | Yes           | No                         |
| Can create new volume | No            | Yes                        |
| Persistent            | Yes           | Yes                        |

### Easy way to remember

```text
💾 EBS Volume
= Working Storage

📸 Snapshot
= Backup
```

---

# 🆚 27. EBS vs Instance Store

EC2 can also use **Instance Store** storage.

The basic difference:

| Feature                     | EBS             | Instance Store |
| --------------------------- | --------------- | -------------- |
| Persistent                  | Yes             | No             |
| Can exist independently     | Yes             | No             |
| Snapshot support            | Yes             | No             |
| Data survives instance stop | Yes             | No             |
| Typical use                 | Persistent data | Temporary data |

### Easy way to remember

```text
EBS
↓
Persistent Storage

Instance Store
↓
Temporary Storage
```

Instance Store data is lost when the underlying instance is stopped or terminated, depending on the event and instance behavior.

---

# 🧪 28. Hands-on Lab

## 🎯 Objective

Create an EBS volume, attach it to an EC2 instance, store data, and create a snapshot.

### Step 1: Create EBS Volume

Example:

```text
Type: gp3
Size: 10 GiB
AZ: Same as EC2
```

---

### Step 2: Attach the Volume

Attach it to your EC2 instance.

```text
EC2
 │
 ├── Root EBS
 │
 └── Data EBS
```

---

### Step 3: Check the Disk

Connect to EC2 and run:

```bash
lsblk
```

---

### Step 4: Format the Disk

Only if it is a new empty volume:

```bash
sudo mkfs -t ext4 /dev/nvme1n1
```

---

### Step 5: Create Mount Point

```bash
sudo mkdir /data
```

---

### Step 6: Mount the Volume

```bash
sudo mount /dev/nvme1n1 /data
```

---

### Step 7: Verify

```bash
df -h
```

---

### Step 8: Create a Test File

```bash
echo "EBS Storage Test" | sudo tee /data/test.txt
```

Check:

```bash
cat /data/test.txt
```

---

### Step 9: Create a Snapshot

From the AWS Console:

```text
EC2
→ Volumes
→ Select Volume
→ Actions
→ Create Snapshot
```

---

### Step 10: Verify Snapshot

Go to:

```text
EC2
→ Snapshots
```

Wait until the snapshot status becomes:

```text
completed
```

---

# 🔍 29. Troubleshooting

## ❌ EBS Volume Cannot Be Attached

Check whether:

```text
EC2 Availability Zone
        =
EBS Availability Zone
```

They generally need to be in the same Availability Zone.

---

## ❌ Volume Not Visible in Linux

Run:

```bash
lsblk
```

If necessary, check:

```bash
sudo fdisk -l
```

---

## ❌ Mount Command Fails

Check whether the volume has a filesystem:

```bash
sudo blkid
```

If it is a new empty volume, format it before mounting.

---

## ❌ Data Disappeared

Check:

* Did you attach the correct volume?
* Was the volume deleted?
* Was the EC2 instance terminated?
* Was **Delete on Termination** enabled?
* Was the data stored on Instance Store instead of EBS?
* Do you have an EBS Snapshot?

---

# 🛡️ 30. Best Practices

### ✅ Use the right EBS volume type

For many general workloads:

```text
gp3
```

is a good starting point.

---

### ✅ Encrypt EBS volumes

Use encryption for sensitive and production workloads.

---

### ✅ Create snapshots for important data

Snapshots can help with backup and recovery.

---

### ✅ Check Delete on Termination

Before terminating EC2, understand what happens to attached EBS volumes.

---

### ✅ Delete unused volumes

Unused EBS volumes can continue to cost money.

---

### ✅ Clean up old snapshots

Delete snapshots that are no longer required according to your backup policy.

---

### ✅ Don't format the wrong disk

Always verify the device name before running:

```bash
mkfs
```

---

### ✅ Monitor storage usage

Use:

```bash
df -h
```

to check filesystem usage.

Use:

```bash
lsblk
```

to view disks and partitions.

---

# 🧠 31. Quick Revision

### What is EBS?

```text
EBS
 ↓
Virtual Hard Disk
 ↓
Used by EC2
 ↓
Persistent Storage
```

### What is a Snapshot?

```text
EBS Volume
     ↓
   📸 Snapshot
     ↓
Backup / Recovery
```

### Important concepts

```text
💾 EBS Volume
→ Working storage

📸 Snapshot
→ Backup of EBS volume

🔐 Encryption
→ Protects stored data

📏 Volume Size
→ Amount of storage

⚡ Volume Type
→ Determines storage performance characteristics

📍 Availability Zone
→ EBS volume and EC2 generally need to be in the same AZ for attachment
```

### Most important commands

```bash
lsblk
df -h
sudo blkid
sudo fdisk -l
```

### Basic flow

```text
Create EBS
     ↓
Attach to EC2
     ↓
Check with lsblk
     ↓
Format
     ↓
Mount
     ↓
Store Data
     ↓
Create Snapshot
```

---

# ⭐ Best Practices

* 💾 Use EBS for persistent EC2 storage
* 📸 Create snapshots for important volumes
* 🔐 Enable encryption
* 📍 Keep EC2 and EBS in the appropriate Availability Zone
* 🧹 Delete unused volumes and old snapshots
* ⚠️ Check Delete on Termination before terminating EC2
* 🔍 Always verify the disk before formatting
* 📊 Monitor disk usage
* 🛡️ Test your backup and recovery process

