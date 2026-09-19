# 🪣 AWS S3 (Simple Storage Service)

## 📖 Introduction

**Amazon S3 (Simple Storage Service)** is an AWS service used to **store and retrieve files and data over the internet**.

You can use S3 to store:

* 🖼️ Images
* 📄 Documents
* 🎥 Videos
* 📦 Backups
* 📊 Logs
* 💻 Website files
* 📁 Application data

### Simple Example

Think of S3 like a **storage room in the cloud**.

Instead of keeping files only on your computer:

```text
Your Computer
     ↓
   Upload
     ↓
    S3
     ↓
Your files are stored in AWS
```

---

# 🧠 1. What is Amazon S3?

S3 is an **object storage service**.

It stores data as **objects** inside **buckets**.

The basic structure is:

```text
S3
│
└── Bucket
      │
      ├── Object
      ├── Object
      └── Object
```

For example:

```text
my-company-bucket
│
├── logo.png
├── resume.pdf
├── report.pdf
└── website/
    ├── index.html
    └── style.css
```

---

# 🪣 2. What is an S3 Bucket?

A **bucket** is a container used to store objects.

Example:

```text
Bucket Name:
my-company-data
```

Inside the bucket:

```text
my-company-data
│
├── image.jpg
├── backup.zip
├── report.pdf
└── logs/
    └── application.log
```

### Important

Before uploading an object to S3, you normally create a bucket.

```text
Bucket → stores Objects
```

---

# 📦 3. What is an S3 Object?

An **object** is a file stored in an S3 bucket.

Examples:

```text
photo.jpg
resume.pdf
video.mp4
index.html
backup.zip
```

An S3 object consists of:

* Object data
* Object key
* Metadata

---

# 🔑 4. What is an Object Key?

The **key** is the name used to identify an object inside a bucket.

Example:

```text
Bucket:
company-data

Object:
reports/2026/sales.pdf
```

The object key is:

```text
reports/2026/sales.pdf
```

S3 uses a **flat object namespace**. What looks like folders are actually part of the object's key.

For example:

```text
photos/2026/january/image.jpg
```

is an object key containing prefixes that look like folders.

---

# 📁 5. S3 Folders

S3 does not work like a traditional file system with real folders.

Instead, folders are represented using prefixes in object keys.

Example:

```text
photos/
    2026/
        image1.jpg
        image2.jpg
```

The object keys are:

```text
photos/2026/image1.jpg
photos/2026/image2.jpg
```

The AWS Console displays these prefixes like folders to make them easier to manage.

---

# 🌍 6. S3 Region

When creating an S3 bucket, you select an AWS Region.

Example:

```text
Bucket
Name: sejal-project-data
Region: ap-south-1
```

The bucket is associated with that Region.

Choose a Region based on factors such as:

* Application location
* Data residency requirements
* Latency
* Cost
* Compliance

---

# 🔐 7. S3 Security

S3 provides several ways to control access to your data.

Common security mechanisms include:

* IAM policies
* Bucket policies
* Block Public Access
* Access Points
* Encryption

### Simple Example

Suppose you have:

```text
S3 Bucket
    ↓
company-data
```

You may want:

```text
Admin → Full Access
Developer → Read Access
Public → No Access
```

Access policies help control this.

---

# 👤 8. IAM and S3

**IAM** controls who can perform actions on AWS resources.

For example, an IAM user or role may have permission to:

```text
s3:GetObject
s3:PutObject
s3:ListBucket
```

### Example

A developer needs to upload a file:

```text
Developer
    ↓
IAM Permission
    ↓
S3
    ↓
Upload Object
```

Without the required permission, the operation is denied.

---

# 📜 9. S3 Bucket Policy

A **Bucket Policy** is a resource-based policy attached to an S3 bucket.

It can control who can access the bucket and what they can do.

Example concept:

```text
Allow
User/Role
    ↓
GetObject
    ↓
S3 Bucket
```

Bucket policies are written in JSON.

---

# 🚫 10. S3 Block Public Access

S3 provides **Block Public Access** settings to help prevent unintended public access.

For private company data, it is generally a good practice to keep public access blocked unless public access is specifically required.

Example:

```text
Company Data
     ↓
S3
     ↓
Block Public Access
     ↓
Not publicly accessible
```

---

# 🌐 11. Public S3 Bucket

Sometimes objects need to be publicly accessible.

For example:

```text
Website Images
     ↓
S3
     ↓
Public Access
     ↓
Internet Users
```

However, public access should only be enabled when it is intentionally required.

For many modern applications, you can keep the bucket private and provide controlled access using other mechanisms.

---

# 🔗 12. S3 Object URL

An S3 object can have a URL through which it can be accessed when permissions allow it.

Conceptually:

```text
S3 Bucket
   ↓
Object
   ↓
Object URL
   ↓
Client
```

Having an object URL does **not automatically mean that the object is publicly accessible**.

The required permissions must allow access.

---

# 💾 13. S3 Storage Classes

S3 provides different **storage classes** for different access patterns and cost requirements.

Common storage classes include:

| Storage Class                 | Typical Use                                   |
| ----------------------------- | --------------------------------------------- |
| S3 Standard                   | Frequently accessed data                      |
| S3 Intelligent-Tiering        | Data with changing or unknown access patterns |
| S3 Standard-IA                | Infrequently accessed data                    |
| S3 One Zone-IA                | Infrequently accessed, re-creatable data      |
| S3 Glacier Instant Retrieval  | Archive data that still needs fast retrieval  |
| S3 Glacier Flexible Retrieval | Long-term archive data                        |
| S3 Glacier Deep Archive       | Very long-term archive                        |

### Simple Idea

```text
Frequently used
      ↓
S3 Standard

Less frequently used
      ↓
S3 Standard-IA

Archive
      ↓
S3 Glacier
```

---

# 🔄 14. S3 Storage Class Selection

Choose a storage class based on how often the data is accessed.

### Example

Website files:

```text
Frequently accessed
        ↓
S3 Standard
```

Old backups:

```text
Rarely accessed
        ↓
Glacier storage class
```

The exact choice depends on access patterns, retrieval requirements, and cost.

---

# 📸 15. S3 Versioning

**Versioning** allows S3 to keep multiple versions of an object.

Example:

```text
report.pdf
     ↓
Version 1

report.pdf
     ↓
Version 2

report.pdf
     ↓
Version 3
```

If someone accidentally overwrites or deletes an object, previous versions can help recover the data.

### Example

```text
Before:
website/index.html → Version 1

After update:
website/index.html → Version 2
```

Both versions can be retained when versioning is enabled.

---

# 🔄 16. Why Use Versioning?

Versioning is useful for:

* Accidental deletion recovery
* Accidental overwrites
* Data protection
* Maintaining object history

### Important

Versioning does not replace backups completely. It should be used as part of a broader data-protection strategy.

---

# ♻️ 17. S3 Lifecycle Rules

**Lifecycle rules** automatically manage objects as they become older.

For example:

```text
Day 0
 ↓
S3 Standard

After 30 days
 ↓
S3 Standard-IA

After 90 days
 ↓
Glacier

After 1 year
 ↓
Delete
```

This can help automate storage management and reduce costs.

---

# 🗑️ 18. Object Deletion

You can delete objects from an S3 bucket.

Example:

```text
Bucket
│
├── file1.txt
├── file2.txt
└── file3.txt
```

Delete:

```text
file2.txt
```

Result:

```text
Bucket
│
├── file1.txt
└── file3.txt
```

When versioning is enabled, deleting an object can create a **delete marker**, while previous versions may remain.

---

# 📸 19. S3 Encryption

S3 supports encryption to protect stored data.

There are two broad approaches:

### Server-Side Encryption

AWS encrypts the object when storing it.

Common options include:

```text
SSE-S3
SSE-KMS
SSE-C
```

### Client-Side Encryption

The application encrypts the data before uploading it to S3.

```text
Application
    ↓
Encrypt Data
    ↓
S3
```

---

# 🔐 20. SSE-S3

With **SSE-S3**, Amazon S3 manages the encryption keys for server-side encryption.

Simple flow:

```text
Upload Object
      ↓
S3 encrypts object
      ↓
Encrypted storage
```

---

# 🔑 21. SSE-KMS

With **SSE-KMS**, AWS Key Management Service (KMS) is used to manage encryption keys.

```text
Application
     ↓
S3
     ↓
AWS KMS
     ↓
Encrypted Object
```

SSE-KMS can be useful when you need additional control and auditing around encryption keys.

---

# 🛡️ 22. S3 Durability vs Availability

These two terms are different.

### Durability

Durability means:

> How likely your data is to remain intact over time.

### Availability

Availability means:

> How easily the service is available when you need to access it.

Remember:

```text
Durability ≠ Availability
```

S3 is designed for very high durability, while availability depends on the chosen storage class and service design.

---

# 🌐 23. S3 and Static Website Hosting

S3 can host static websites.

A static website may contain:

```text
index.html
style.css
script.js
images/
```

Example:

```text
User
 ↓
S3
 ↓
index.html
 ↓
Website
```

S3 is suitable for static content because there is no server-side application running on the bucket itself.

---

# 🏗️ 24. S3 Static Website Architecture

A simple setup:

```text
              Internet
                  │
                  ↓
            Static Website
                  │
                  ↓
             Amazon S3
                  │
        ┌─────────┼─────────┐
        ↓         ↓         ↓
    index.html  CSS       Images
```

For production architectures, services such as **Amazon CloudFront** are often used in front of private S3 content for CDN delivery and additional security.

---

# 🔄 25. S3 Replication

S3 supports automatic replication of objects between buckets.

Two common types are:

* **Same-Region Replication (SRR)**
* **Cross-Region Replication (CRR)**

Example:

```text
Mumbai Bucket
     │
     │ Replication
     ↓
Singapore Bucket
```

Replication can be useful for:

* Disaster recovery
* Compliance
* Data locality
* Separate copies of data

---

# 📊 26. S3 Monitoring

AWS provides several ways to monitor S3.

You can use:

* Amazon CloudWatch
* AWS CloudTrail
* S3 access logs
* S3 server access logging
* CloudTrail data events

### Example

```text
User
 ↓
S3
 ↓
CloudTrail
 ↓
API activity
```

CloudTrail can help identify actions performed on S3 resources.

---

# 📝 27. S3 Event Notifications

S3 can send notifications when certain events happen.

Example:

```text
File uploaded
      ↓
S3 Event
      ↓
Lambda
      ↓
Process File
```

For example, when an image is uploaded:

```text
Image Upload
     ↓
S3
     ↓
Lambda
     ↓
Image Processing
```

S3 events can integrate with services such as Lambda, SNS, and SQS.

---

# 📦 28. Multipart Upload

For large objects, S3 supports **multipart upload**.

Instead of uploading one large file:

```text
Large File
    ↓
Single Upload
```

It can be divided into parts:

```text
Large File
   │
   ├── Part 1
   ├── Part 2
   ├── Part 3
   └── Part 4
          ↓
       S3
```

The parts are uploaded separately and then assembled into the final object.

This can improve upload performance and reliability for large files.

---

# 💻 29. Uploading Files Using AWS CLI

You can use the AWS CLI to work with S3.

### List Buckets

```bash
aws s3 ls
```

### List Objects

```bash
aws s3 ls s3://my-bucket
```

### Upload a File

```bash
aws s3 cp file.txt s3://my-bucket/
```

### Download a File

```bash
aws s3 cp s3://my-bucket/file.txt .
```

### Upload a Folder

```bash
aws s3 cp my-folder/ s3://my-bucket/my-folder/ --recursive
```

### Download a Folder

```bash
aws s3 cp s3://my-bucket/my-folder/ ./my-folder/ --recursive
```

---

# 🔄 30. AWS CLI Sync

The `sync` command synchronizes files between locations.

Example:

```bash
aws s3 sync ./website s3://my-bucket/website
```

This is useful when uploading website files or synchronizing directories.

---

# 🧪 31. Hands-on S3 Lab

Let's create a simple S3 project.

### Step 1: Create a Bucket

Example:

```text
Bucket Name:
my-s3-learning-bucket
```

Choose your required AWS Region.

---

### Step 2: Keep Public Access Blocked

For a normal private storage bucket:

```text
Block all public access → ON
```

---

### Step 3: Upload a File

Upload:

```text
sample.txt
```

Your bucket becomes:

```text
my-s3-learning-bucket
│
└── sample.txt
```

---

### Step 4: Enable Versioning

Go to:

```text
Bucket
 ↓
Properties
 ↓
Bucket Versioning
 ↓
Enable
```

---

### Step 5: Upload the Same File Again

Change the content and upload:

```text
sample.txt
```

S3 now maintains different versions.

---

### Step 6: Test AWS CLI

List the bucket:

```bash
aws s3 ls s3://my-s3-learning-bucket
```

Upload another file:

```bash
aws s3 cp test.txt s3://my-s3-learning-bucket/
```

Verify:

```bash
aws s3 ls s3://my-s3-learning-bucket
```

---

# 🔍 32. Common S3 Troubleshooting

### ❌ AccessDenied

Check:

```text
1. IAM permissions
2. Bucket policy
3. Block Public Access
4. Object permissions
5. KMS permissions if using SSE-KMS
```

---

### ❌ Bucket Not Found

Check:

```text
1. Bucket name
2. AWS account
3. AWS Region
4. CLI configuration
```

---

### ❌ Cannot Upload Object

Check:

```text
IAM permissions
Bucket policy
KMS permissions
Bucket configuration
```

---

### ❌ Website Is Not Loading

Check:

```text
1. Website configuration
2. Index document
3. Access permissions
4. Object existence
5. CloudFront configuration if used
```

---

# 🛡️ 33. S3 Best Practices

### 🔐 1. Keep buckets private by default

Do not make a bucket public unless it is intentionally required.

### 🔐 2. Use IAM least privilege

Give users and applications only the permissions they need.

### 🔐 3. Enable encryption

Protect sensitive data using appropriate S3 encryption options.

### 🔄 4. Enable versioning when useful

Versioning helps recover from accidental overwrites and deletions.

### ♻️ 5. Use lifecycle rules

Automatically transition or delete objects according to your data-retention needs.

### 🌍 6. Choose the correct storage class

Select storage based on how frequently data is accessed.

### 📊 7. Monitor access

Use CloudTrail and appropriate S3 monitoring/logging features.

### 🧹 8. Delete unused data

Old objects can continue generating storage costs.

### 🔑 9. Never store secrets carelessly

Avoid storing passwords, access keys, private keys, or other sensitive credentials as ordinary files in S3.

---

# 🆚 34. S3 vs EBS

| Feature         | S3                         | EBS             |
| --------------- | -------------------------- | --------------- |
| Type            | Object storage             | Block storage   |
| Mainly used for | Files/data                 | EC2 disk        |
| Attached to EC2 | ❌ No                       | ✅ Yes           |
| Access          | API/HTTP/CLI               | Mounted as disk |
| Example         | Images, backups, documents | OS/data disk    |

### Easy way to remember

```text
S3  → Store objects/files
EBS → Store data on an EC2 disk
```

---

# 🆚 35. S3 vs EFS

| Feature           | S3                             | EFS                |
| ----------------- | ------------------------------ | ------------------ |
| Storage type      | Object                         | File               |
| Access            | API                            | File system        |
| Mount on Linux    | ❌                              | ✅                  |
| Use case          | Files, backups, static content | Shared file system |
| Shared across EC2 | Through APIs                   | Yes                |

---

# 🧠 36. Quick Revision

| Term                | Simple Meaning                                    |
| ------------------- | ------------------------------------------------- |
| S3                  | AWS object storage service                        |
| Bucket              | Container for objects                             |
| Object              | File stored in S3                                 |
| Object Key          | Name/path-like identifier of an object            |
| Storage Class       | Determines how S3 stores/accesses data            |
| Versioning          | Keeps multiple object versions                    |
| Lifecycle           | Automatically manages object transitions/deletion |
| Bucket Policy       | Controls access to a bucket                       |
| Block Public Access | Helps prevent unintended public access            |
| Encryption          | Protects stored data                              |
| Replication         | Copies objects between buckets                    |
| Multipart Upload    | Uploads large objects in parts                    |
| Event Notification  | Triggers actions when S3 events occur             |

---

# ⭐ Remember These 5 Things

```text
S3
│
├── Bucket
│     └── Objects
│
├── Security
│     ├── IAM
│     ├── Bucket Policy
│     └── Block Public Access
│
├── Storage Classes
│
├── Versioning & Lifecycle
│
└── Static Website & Application Storage
```

### Most Important Concept

> **S3 is object storage.**

Remember:

```text
Bucket → Container
Object → File
Key → Object identifier
Policy → Access control
Versioning → Object history
Lifecycle → Automatic storage management
```

