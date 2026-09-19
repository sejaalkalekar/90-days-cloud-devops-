# 🔍 AWS CloudTrail & AWS CLI

## 📖 Introduction

AWS provides many services to manage and monitor your cloud infrastructure.

Two important tools/services are:

### 🔍 AWS CloudTrail

CloudTrail helps you **record and audit activity in your AWS account**.

It helps answer:

> **Who did what, when, and from where?**

### 💻 AWS CLI

AWS CLI (Command Line Interface) allows you to **manage AWS resources using commands from a terminal**.

It helps answer:

> **How can I manage AWS resources without using the AWS Console?**

---

# 🔍 Part 1: AWS CloudTrail

## 🧠 1. What is AWS CloudTrail?

**AWS CloudTrail** is a service that records activity and API calls made in your AWS account.

For example:

```text
User
 ↓
AWS Console
 ↓
Delete S3 Bucket
 ↓
CloudTrail
 ↓
Activity Recorded
```

CloudTrail can help you identify:

* Who performed an action
* What action was performed
* When it happened
* Which AWS resource was involved
* Where the request came from
* Whether the request succeeded or failed

---

# 🎯 2. Why Do We Need CloudTrail?

Imagine an S3 bucket was accidentally deleted.

You may ask:

```text
Who deleted it?
When was it deleted?
Which account/user performed the action?
From which IP address?
```

CloudTrail can help investigate these questions.

Example:

```text
S3 Bucket Deleted
       ↓
   CloudTrail
       ↓
User: cloud-devops-user
Action: DeleteBucket
Time: 10:30 AM
Source IP: xxx.xxx.xxx.xxx
```

---

# 📝 3. What Does CloudTrail Record?

CloudTrail records information about AWS API activity.

A typical event can contain information such as:

```text
Event Name
User Identity
Event Time
AWS Service
Resource
Source IP Address
Region
Request Details
Response Details
```

Example:

```text
Event Name:
RunInstances

Service:
EC2

Region:
ap-south-1

User:
IAM User / Role
```

---

# 🧩 4. CloudTrail Events

CloudTrail mainly deals with events representing activity in your AWS environment.

Important event categories include:

### Management Events

These relate to management operations performed on AWS resources.

Examples:

```text
CreateBucket
DeleteBucket
RunInstances
TerminateInstances
CreateUser
CreateRole
```

These events are useful for understanding changes made to your AWS environment.

---

### Data Events

Data events provide more detailed activity for supported resources.

For example, with S3 they can include object-level operations such as:

```text
GetObject
PutObject
DeleteObject
```

Data events can generate a large amount of activity, so enable them based on your monitoring and auditing requirements.

---

# 🔐 5. CloudTrail and IAM

CloudTrail works closely with IAM.

Example:

```text
IAM User
   ↓
AWS API Request
   ↓
AWS Service
   ↓
CloudTrail records activity
```

This helps you audit actions performed by:

* IAM users
* IAM roles
* AWS services
* Other supported identities

---

# 🌐 6. CloudTrail and AWS Console

When you perform an action through the AWS Console, AWS makes API requests behind the scenes.

For example:

```text
AWS Console
     ↓
Launch EC2
     ↓
AWS API
     ↓
CloudTrail
     ↓
Event Recorded
```

So CloudTrail is not limited to actions performed through the CLI.

---

# 💻 7. CloudTrail and AWS CLI

Actions performed through the AWS CLI also generate API activity.

Example:

```bash id="n6g9kz"
aws s3 mb s3://my-cloudtrail-demo-bucket
```

The CLI sends an AWS API request.

Conceptually:

```text
AWS CLI
   ↓
AWS API
   ↓
S3
   ↓
CloudTrail
```

CloudTrail can record the API activity.

---

# 📦 8. CloudTrail Trails

A **Trail** allows you to configure how CloudTrail activity is collected and delivered.

For example:

```text
AWS Account
     ↓
CloudTrail Trail
     ↓
S3 Bucket
     ↓
Long-term storage
```

A trail can be configured to deliver logs to an S3 bucket.

---

# 🪣 9. CloudTrail Logs in S3

CloudTrail can store log files in an S3 bucket.

Example:

```text
CloudTrail
    ↓
S3 Bucket
    ↓
AWS Account Logs
```

This is useful for:

* Long-term auditing
* Security investigations
* Compliance
* Historical analysis

---

# 📊 10. CloudTrail and CloudWatch

CloudTrail and CloudWatch are different but can work together.

```text
CloudTrail
    ↓
Records AWS activity

CloudWatch
    ↓
Monitors metrics and logs
```

### Easy Way to Remember

> **CloudTrail → Who did what?**

> **CloudWatch → Is my system healthy?**

Example:

```text
EC2 CPU = 95%
       ↓
CloudWatch
       ↓
Performance Alert


EC2 Instance Terminated
       ↓
CloudTrail
       ↓
Find who terminated it
```

---

# 🆚 11. CloudTrail vs CloudWatch

| Feature           | CloudTrail                   | CloudWatch                 |
| ----------------- | ---------------------------- | -------------------------- |
| Main purpose      | Auditing & activity tracking | Monitoring & observability |
| API activity      | ✅                            | ❌                          |
| Metrics           | ❌                            | ✅                          |
| Logs              | ✅                            | ✅                          |
| Alarms            | ❌                            | ✅                          |
| Troubleshooting   | ✅                            | ✅                          |
| Security auditing | ✅                            | Supporting role            |

### Simple Memory Trick

```text
CloudTrail → "Who did it?"

CloudWatch → "How is it performing?"
```

---

# 🧪 12. CloudTrail Hands-on Lab

### Step 1: Open CloudTrail

Go to:

```text
AWS Console
 ↓
CloudTrail
 ↓
Event history
```

---

### Step 2: Check Recent Events

You can see recent AWS activity.

For example:

```text
Event Name
User
Event Time
AWS Service
Region
Resource
```

---

### Step 3: Perform an AWS Action

For example, create an S3 bucket or perform another harmless test action.

Then return to:

```text
CloudTrail
 ↓
Event history
```

Search for the event.

---

### Step 4: Inspect the Event

Open the event and check information such as:

```text
Who performed the action?
What API call was made?
When did it happen?
Which Region?
Which resource?
Source IP?
```

---

# 💻 Part 2: AWS CLI

# 🧠 13. What is AWS CLI?

**AWS CLI** stands for:

> **AWS Command Line Interface**

It allows you to interact with AWS services from a terminal.

Instead of:

```text
AWS Console
 ↓
Click EC2
 ↓
Click Instances
 ↓
Select Instance
```

You can use:

```bash id="u5pl0j"
aws ec2 describe-instances
```

---

# 🎯 14. Why Use AWS CLI?

AWS CLI is useful for:

* Automation
* DevOps tasks
* Scripting
* Troubleshooting
* Resource management
* CI/CD pipelines
* Repetitive operations

Example:

```text
Manual:
Create 10 resources one by one

CLI:
Use a script/commands
```

---

# 🖥️ 15. Installing AWS CLI

AWS CLI is available for:

* Windows
* Linux
* macOS

After installation, verify it:

```bash id="09m6b8"
aws --version
```

Example output:

```text
aws-cli/2.x.x
```

The exact version may differ.

---

# 🔑 16. Configure AWS CLI

Use:

```bash id="r4s3p0"
aws configure
```

It asks for:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

Example:

```text
AWS Access Key ID: YOUR_ACCESS_KEY
AWS Secret Access Key: YOUR_SECRET_KEY
Default region: ap-south-1
Output format: json
```

⚠️ **Never share your access keys publicly.**

Do not upload them to GitHub.

---

# 🔐 17. Better Authentication with AWS CLI

For AWS resources running inside AWS, prefer **IAM roles** where possible.

For example:

```text
EC2
 ↓
IAM Role
 ↓
AWS Services
```

This avoids storing long-term access keys on the server.

For local development, AWS CLI can also use configured profiles and other supported credential mechanisms.

---

# 🌍 18. AWS CLI Region

You can specify a default Region during configuration:

```text
ap-south-1
```

You can also specify a Region in a command:

```bash id="o2j1y7"
aws ec2 describe-instances --region ap-south-1
```

This is useful when working with resources in different Regions.

---

# 📤 19. AWS CLI Output Formats

AWS CLI supports output formats such as:

```text
json
text
table
yaml
yaml-stream
```

Example:

```bash id="l9i2xv"
aws ec2 describe-instances --output table
```

For scripts and automation, JSON is commonly useful.

---

# 👤 20. Check Your AWS Identity

A very useful command is:

```bash id="rqj3c7"
aws sts get-caller-identity
```

It shows information about the identity being used by the CLI.

Example:

```text
Account
Arn
UserId
```

This is one of the first commands you should run when troubleshooting AWS CLI authentication.

---

# 🪣 21. AWS CLI with S3

### List Buckets

```bash id="jqf3yc"
aws s3 ls
```

### List Objects

```bash id="6f4q4m"
aws s3 ls s3://my-bucket
```

### Upload File

```bash id="d3v5hs"
aws s3 cp file.txt s3://my-bucket/
```

### Download File

```bash id="w8myf1"
aws s3 cp s3://my-bucket/file.txt .
```

### Synchronize Directory

```bash id="42q7jz"
aws s3 sync ./website s3://my-bucket/website
```

---

# 🖥️ 22. AWS CLI with EC2

### List EC2 Instances

```bash id="l5q9h0"
aws ec2 describe-instances
```

### Start an Instance

```bash id="8b7nqk"
aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```

### Stop an Instance

```bash id="0j8vcm"
aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```

### Terminate an Instance

```bash id="p9x2s8"
aws ec2 terminate-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```

⚠️ Be extremely careful with `terminate-instances` because termination can permanently delete an EC2 instance and associated resources depending on configuration.

---

# 🔐 23. AWS CLI with IAM

You can use AWS CLI to interact with IAM.

For example:

```bash id="9t0lqf"
aws iam list-users
```

To list roles:

```bash id="2f4k8a"
aws iam list-roles
```

IAM commands require appropriate permissions.

---

# 🌐 24. AWS CLI with VPC

You can also work with VPC resources.

Example:

```bash id="q4r5k7"
aws ec2 describe-vpcs
```

List subnets:

```bash id="8qz1dm"
aws ec2 describe-subnets
```

List route tables:

```bash id="z7p6ss"
aws ec2 describe-route-tables
```

---

# 📊 25. AWS CLI with CloudWatch

You can retrieve CloudWatch metrics using the CLI.

Example:

```bash id="r5b2k6"
aws cloudwatch list-metrics
```

You can also query metric statistics with:

```bash id="9w5h4n"
aws cloudwatch get-metric-statistics
```

This is useful when automating monitoring and troubleshooting tasks.

---

# 🔍 26. AWS CLI Troubleshooting

When an AWS CLI command fails, check these first:

```text
1. AWS credentials
2. IAM permissions
3. AWS Region
4. Resource name/ID
5. AWS CLI command syntax
6. Network connectivity
```

---

### ❌ AccessDenied

Usually means the current identity does not have the required permission.

Check:

```bash id="1q9h8v"
aws sts get-caller-identity
```

Then check the IAM policies attached to that identity.

---

### ❌ Resource Not Found

Check:

```text
AWS Region
Resource ID
Resource name
AWS account
```

For example:

```bash id="0q8q2a"
aws ec2 describe-instances --region ap-south-1
```

---

### ❌ Invalid Credentials

Run:

```bash id="5l8w3d"
aws sts get-caller-identity
```

If authentication fails, check your configured credentials/profile.

---

# 👥 27. AWS CLI Profiles

You may work with multiple AWS accounts or environments.

You can create named profiles.

Example:

```bash id="d5d1l4"
aws configure --profile development
```

Then use:

```bash id="h3x1az"
aws sts get-caller-identity --profile development
```

Another profile:

```bash id="j7b8g2"
aws configure --profile production
```

This helps separate environments.

---

# 🔄 28. AWS CLI in DevOps

AWS CLI is very useful in DevOps workflows.

Example:

```text
Developer
    ↓
GitHub
    ↓
CI/CD Pipeline
    ↓
AWS CLI
    ↓
AWS Resources
```

For example, a deployment pipeline might use AWS CLI commands to:

```text
Upload files to S3
Update infrastructure
Start/stop resources
Retrieve deployment information
```

---

# 🧪 29. Simple AWS CLI Practice Lab

Try these commands in order.

### Step 1: Check CLI Installation

```bash id="8w1s9m"
aws --version
```

### Step 2: Check Identity

```bash id="c4q3z1"
aws sts get-caller-identity
```

### Step 3: Check Region

```bash id="w7y2ka"
aws configure get region
```

### Step 4: List S3 Buckets

```bash id="2v4m9x"
aws s3 ls
```

### Step 5: List VPCs

```bash id="m5f6t8"
aws ec2 describe-vpcs
```

### Step 6: List EC2 Instances

```bash id="y1k8z5"
aws ec2 describe-instances
```

These commands give you practice interacting with AWS without using the Console.

---

# 🆚 30. AWS Console vs AWS CLI

| Feature             | AWS Console | AWS CLI           |
| ------------------- | ----------- | ----------------- |
| Interface           | Graphical   | Command line      |
| Beginner friendly   | ✅           | Requires practice |
| Automation          | Limited     | ✅                 |
| Scripting           | ❌           | ✅                 |
| DevOps pipelines    | Less common | ✅                 |
| Repetitive tasks    | Manual      | Automatable       |
| Resource management | ✅           | ✅                 |

### Simple Example

Console:

```text
Click → Click → Click → Create
```

CLI:

```bash
aws <service> <command>
```

---

# 🧠 31. Important AWS CLI Command Structure

Most AWS CLI commands follow this pattern:

```bash id="j8p6qv"
aws <service> <operation> [options]
```

Example:

```bash id="3z5v7q"
aws ec2 describe-instances
```

Breakdown:

```text
aws
 ↓
CLI command

ec2
 ↓
AWS service

describe-instances
 ↓
Operation
```

Another example:

```bash id="4m1s8p"
aws s3 ls
```

```text
aws
 ↓
s3
 ↓
ls
```

---

# 🔐 32. AWS CLI Security Best Practices

### 🔑 1. Never expose access keys

Never put credentials in:

```text
GitHub
README files
Scripts
Screenshots
Public posts
```

### 👤 2. Use least privilege

Give IAM identities only the permissions they need.

### 🏷️ 3. Use profiles

Separate development and production environments when necessary.

### 🖥️ 4. Prefer IAM roles on AWS resources

For example:

```text
EC2
 ↓
IAM Role
 ↓
AWS Services
```

### 🔄 5. Rotate long-term credentials when they are used

Prefer temporary credentials and role-based access where possible.

---

# 🧠 33. Quick Revision

| Term                      | Simple Meaning                                              |
| ------------------------- | ----------------------------------------------------------- |
| CloudTrail                | Records AWS account activity                                |
| Event                     | A recorded AWS activity/API request                         |
| Management Event          | Management operation on AWS resources                       |
| Data Event                | Detailed data-level activity for supported resources        |
| Trail                     | Configuration for collecting/delivering CloudTrail activity |
| AWS CLI                   | Command-line tool for AWS                                   |
| `aws configure`           | Configures CLI credentials/settings                         |
| `sts get-caller-identity` | Shows current AWS identity                                  |
| Profile                   | Separate CLI configuration                                  |
| IAM                       | Controls permissions                                        |
| CloudWatch                | Monitoring and observability                                |

---

# ⭐ Remember These Things

```text
CloudTrail
    ↓
"Who did what in AWS?"
```

```text
AWS CLI
    ↓
"Manage AWS using commands"
```

```text
CloudWatch
    ↓
"How is my system performing?"
```

### The Big Picture

```text
                 AWS Environment
                       │
          ┌────────────┼────────────┐
          ↓            ↓            ↓
       Console        CLI         Services
          │            │            │
          └────────────┼────────────┘
                       ↓
                  AWS API Calls
                       │
                       ↓
                  CloudTrail
                       │
                       ↓
                  Audit History
```
