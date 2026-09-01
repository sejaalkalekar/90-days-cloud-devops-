# 🖥️ AWS EC2

## 📖 Introduction

**Amazon EC2 (Elastic Compute Cloud)** is an AWS service that allows you to create and run **virtual servers in the cloud**.

These virtual servers are called **EC2 Instances**.

Instead of purchasing and maintaining a physical server, you can launch an EC2 instance in AWS and use it like a normal computer/server.

### Simple Example

```text
Physical Server
      ↓
AWS EC2
      ↓
Virtual Server
      ↓
Run Applications
```

You can use EC2 to run:

* Websites
* APIs
* Backend applications
* Docker containers
* Development environments
* Automation tools
* CI/CD tools
* Application servers

---

# 🏗️ EC2 Basics

## What is an EC2 Instance?

An **EC2 instance** is a virtual server running inside AWS.

For example:

```text
EC2 Instance
│
├── Operating System
├── CPU
├── Memory
├── Storage
└── Network
```

You can choose the resources according to your application requirements.

---

## Why Use EC2?

With EC2, you can:

* Launch servers within minutes
* Choose the operating system
* Choose CPU and memory
* Attach storage
* Configure networking
* Install required software
* Increase or decrease capacity
* Stop or terminate servers when no longer needed

---

# 💿 AMI

**AMI (Amazon Machine Image)** is a template used to launch an EC2 instance.

An AMI can contain:

* Operating system
* Pre-installed software
* Configuration
* Application settings

Examples:

```text
Amazon Linux
Ubuntu
Red Hat
Windows Server
```

### Simple Flow

```text
AMI
 ↓
Launch Instance
 ↓
EC2 Instance
```

You can also create a **custom AMI** from an existing EC2 instance.

---

# ⚙️ Instance Types

An **EC2 instance type** determines the resources available to the instance.

It mainly defines things such as:

* vCPU
* Memory
* Network performance
* Storage characteristics

Examples:

```text
t3.micro
t3.small
t3.medium
```

## Common Instance Families

| Family | Common Purpose                      |
| ------ | ----------------------------------- |
| `t`    | Burstable/general-purpose workloads |
| `m`    | General-purpose workloads           |
| `c`    | Compute-intensive workloads         |
| `r`    | Memory-intensive workloads          |
| `i`    | Storage-intensive workloads         |
| `g`    | GPU workloads                       |

> The available instance types and specifications can change. Always check current AWS documentation when selecting an instance for real workloads.

---

# 🧠 vCPU & Memory

Every EC2 instance provides computing resources.

The two basic resources to understand are:

### vCPU

Virtual CPU used to process workloads.

### Memory

RAM used by applications and the operating system.

Simple concept:

```text
Instance Type
      ↓
 ┌─────────────┐
 │    vCPU     │
 │   Memory    │
 │  Networking │
 └─────────────┘
```

A larger instance generally provides more resources, but also costs more.

---

# 🔑 Key Pairs

A **key pair** is commonly used to securely connect to Linux EC2 instances using SSH.

A key pair consists of:

```text
Public Key
Private Key
```

AWS places the public key on the instance, while you keep the private key.

Example:

```bash
ssh -i my-key.pem ec2-user@<public-ip>
```

### ⚠️ Important

Never upload your private key to:

* GitHub
* GitLab
* Public storage
* Public repositories

Keep the private key secure.

---

# 🌐 EC2 Networking

EC2 instances run inside an AWS **VPC**.

The basic networking structure is:

```text
AWS Region
    ↓
VPC
    ↓
Subnet
    ↓
EC2 Instance
```

An EC2 instance can have:

* Private IP
* Public IPv4 address
* Elastic IP
* IPv6 address, depending on configuration

---

# 📍 VPC & Subnet

A **VPC (Virtual Private Cloud)** is your logically isolated network in AWS.

A **subnet** is a smaller network range inside the VPC.

Example:

```text
VPC
10.0.0.0/16
│
├── Public Subnet
│   10.0.1.0/24
│
└── Private Subnet
    10.0.2.0/24
```

EC2 instances are launched inside subnets.

---

# 🌍 Public vs Private EC2

## Public EC2

A public EC2 instance can have a public IP and appropriate routing to communicate with the Internet.

Example:

```text
Internet
   ↓
Internet Gateway
   ↓
Public Subnet
   ↓
EC2
```

Common use:

* Web server
* Public application server
* Learning/lab environments

---

## Private EC2

A private EC2 instance does not have direct inbound Internet access through a public IP.

Example:

```text
Internet
   X
   │
Private Subnet
   ↓
EC2
```

Private instances are commonly used for:

* Backend applications
* Internal services
* Application servers
* Private workloads

For administration, **AWS Systems Manager Session Manager** can be used where appropriate instead of exposing SSH to the Internet.

---

# 🔒 Security Groups

A **Security Group** acts as a virtual firewall for EC2 instances.

It controls network traffic using rules.

Example:

```text
Internet
   ↓
Security Group
   ↓
EC2
```

### Common Ports

| Service    | Port |
| ---------- | ---: |
| SSH        |   22 |
| HTTP       |   80 |
| HTTPS      |  443 |
| PostgreSQL | 5432 |
| MySQL      | 3306 |

Example SSH rule:

```text
Type: SSH
Port: 22
Source: Your IP
```

Example HTTP rule:

```text
Type: HTTP
Port: 80
Source: 0.0.0.0/0
```

### Important

Security Groups are **stateful**.

A Security Group should allow only the traffic that is actually required.

Avoid unnecessarily allowing:

```text
SSH → 0.0.0.0/0
```

Prefer restricting SSH to your IP or using SSM where suitable.

---

# 📡 Public & Private IP

## Private IP

Used for communication inside the VPC and connected networks.

Example:

```text
10.0.1.25
```

## Public IP

Used for Internet communication when the instance and network are configured for it.

Example:

```text
203.x.x.x
```

A public IPv4 address can change when an instance is stopped and started in certain configurations.

For a stable public IPv4 address, an **Elastic IP** can be used.

---

# 💾 EC2 Storage

EC2 can use different types of storage.

The most important one for beginners is:

**EBS (Elastic Block Store)**

EBS provides persistent block storage for EC2.

Think of EBS as a virtual hard disk.

```text
EC2
 │
 ├── Root EBS Volume
 │
 └── Additional EBS Volume
```

---

# 💿 Root EBS Volume

The root volume contains the operating system.

Example:

```text
EC2
 ↓
Root Volume
 ↓
Linux OS
```

The root volume's behavior after instance termination depends on its **Delete on termination** setting.

---

# ➕ Additional EBS Volume

You can attach additional EBS volumes to an EC2 instance.

Example:

```text
EC2
│
├── Root Volume
│
└── Data Volume
```

The additional volume can be used for application or data storage.

---

# 📸 EBS Snapshot

An **EBS Snapshot** is a point-in-time backup of an EBS volume.

```text
EBS Volume
    ↓
Snapshot
    ↓
Backup
```

Snapshots can be used to create new EBS volumes and support backup/recovery workflows.

---

# 📝 User Data

**User Data** allows you to automatically run commands when an EC2 instance is initialized.

Example:

```bash
#!/bin/bash

dnf update -y
dnf install -y httpd
systemctl enable --now httpd

echo "Hello from EC2" > /var/www/html/index.html
```

This can automate initial server configuration.

### Common Uses

* Install packages
* Start services
* Configure applications
* Create files
* Run initialization scripts

---

# 🎭 IAM Role for EC2

An EC2 instance can use an **IAM Role** to access AWS services.

Example:

```text
EC2
 ↓
IAM Role
 ↓
S3
```

For example, an application running on EC2 can access an S3 bucket without storing long-term AWS access keys on the server.

### Best Practice

Prefer:

```text
EC2 → IAM Role → AWS Service
```

instead of:

```text
EC2 → Hardcoded Access Keys
```

---

# 🖥️ Connecting to EC2

For Linux EC2 instances, SSH is one common connection method.

Example:

```bash
ssh -i my-key.pem ec2-user@<PUBLIC_IP>
```

For Ubuntu, the username is commonly:

```bash
ubuntu
```

Example:

```bash
ssh -i my-key.pem ubuntu@<PUBLIC_IP>
```

The correct username depends on the AMI.

---

# 🔐 SSH Key Permissions

On Linux/macOS, the private key should have restrictive permissions.

Example:

```bash
chmod 400 my-key.pem
```

Then connect:

```bash
ssh -i my-key.pem ec2-user@<PUBLIC_IP>
```

---

# 🛠️ Basic Linux Commands After Connecting

Check current user:

```bash
whoami
```

Check hostname:

```bash
hostname
```

Check IP address:

```bash
ip addr
```

Check disk usage:

```bash
df -h
```

Check memory:

```bash
free -h
```

Check running processes:

```bash
top
```

Check operating system:

```bash
cat /etc/os-release
```

Check running services:

```bash
systemctl --type=service
```

---

# 🔄 EC2 Instance Lifecycle

An EC2 instance can move through different states.

```text
Pending
   ↓
Running
   ↓
Stopping
   ↓
Stopped
   ↓
Running
```

An instance can eventually be:

```text
Terminated
```

---

# ⏯️ Stop vs Reboot vs Terminate

| Action    | Meaning                          |
| --------- | -------------------------------- |
| Reboot    | Restarts the operating system    |
| Stop      | Stops the instance               |
| Start     | Starts a stopped instance        |
| Terminate | Permanently removes the instance |

### Stop

```text
Instance → Stopped
```

EBS volumes generally remain available.

### Terminate

```text
Instance → Terminated
```

The instance is permanently removed.

EBS deletion depends on the volume's configuration.

---

# 📌 Elastic IP

An **Elastic IP** is a static public IPv4 address allocated to your AWS account.

It can be associated with an EC2 instance.

Example:

```text
Elastic IP
    ↓
EC2
```

Use Elastic IP only when a stable public IPv4 address is actually required.

---

# 🛣️ Route Tables

A route table controls where network traffic is sent.

Example public subnet:

```text
0.0.0.0/0
    ↓
Internet Gateway
```

Example private subnet:

```text
0.0.0.0/0
    ↓
NAT Gateway
```

---

# 🌐 Internet Gateway

An **Internet Gateway (IGW)** provides a path between a VPC and the Internet when appropriate routing and public addressing are configured.

Typical public architecture:

```text
Internet
   ↓
Internet Gateway
   ↓
Route Table
   ↓
Public Subnet
   ↓
EC2
```

---

# 🔄 NAT Gateway

A NAT Gateway allows resources in private subnets to initiate connections to external networks.

Example:

```text
Private EC2
     ↓
NAT Gateway
     ↓
Internet Gateway
     ↓
Internet
```

For example, a private EC2 instance can download software updates without being directly reachable from the Internet.

---

# 📊 EC2 Monitoring

**Amazon CloudWatch** can be used to monitor EC2 resources.

Common metrics include:

* CPU utilization
* Network traffic
* Instance status
* Other operating-system/application metrics when additional monitoring agents are configured

Simple architecture:

```text
EC2
 ↓
CloudWatch
 ↓
Metrics
 ↓
Alarm
```

---

# 🚨 EC2 Status Checks

EC2 provides status checks to help identify certain infrastructure and instance-level problems.

Two important concepts are:

```text
System Status Check
Instance Status Check
```

If a status check fails, investigate:

* Instance health
* Operating system
* Network configuration
* Application
* AWS infrastructure

---

# 📈 Auto Scaling

**EC2 Auto Scaling** automatically adjusts the number of EC2 instances based on configured requirements.

Example:

```text
Low Traffic
    ↓
2 Instances

High Traffic
    ↓
5 Instances
```

A common architecture is:

```text
Users
  ↓
Load Balancer
  ↓
Auto Scaling Group
  ↓
EC2 EC2 EC2
```

---

# ⚖️ Load Balancer

A load balancer distributes incoming traffic across multiple targets.

Example:

```text
             Users
               ↓
        Load Balancer
         ↙     ↓     ↘
       EC2    EC2    EC2
```

Benefits:

* Distributes traffic
* Performs health checks
* Supports high availability
* Works with scalable application architectures

---

# 💰 EC2 Pricing

EC2 provides multiple purchasing options.

## On-Demand

Pay for compute capacity without a long-term commitment.

Useful for:

* Development
* Testing
* Short-term workloads

---

## Reserved Instances

Provide pricing benefits in exchange for a longer-term commitment for eligible EC2 usage.

---

## Savings Plans

Provide discounted pricing in exchange for a commitment to a certain amount of compute usage over a specified term.

---

## Spot Instances

Use spare AWS compute capacity at potentially large discounts.

However, Spot Instances can be interrupted.

Good for:

* Batch processing
* Testing
* Fault-tolerant workloads
* Flexible workloads

---

# 🐳 EC2 + Docker

EC2 can be used as a Docker host.

Example:

```text
EC2
 ↓
Docker
 ↓
Containers
 ├── Web
 ├── API
 └── Worker
```

Useful commands:

```bash
docker --version
docker ps
docker images
```

---

# 🚀 EC2 + CI/CD

EC2 can be used to host applications or CI/CD tools.

Example:

```text
Developer
    ↓
GitHub
    ↓
CI/CD Pipeline
    ↓
EC2
    ↓
Application
```

EC2 can also be used with:

* Jenkins
* GitHub Actions runners
* GitLab runners
* Deployment tools

---

# 🔧 EC2 Troubleshooting

## Cannot Connect Using SSH

Check:

```text
1. Is the instance running?
2. Is the correct public IP being used?
3. Is port 22 allowed?
4. Is the Security Group correct?
5. Is the subnet routing correct?
6. Is the Internet Gateway configured?
7. Is the correct username being used?
8. Is the correct key being used?
9. Are key permissions correct?
```

---

## Website Is Not Opening

Check:

```text
EC2 Running?
      ↓
Security Group?
      ↓
Port 80/443?
      ↓
Web Server Running?
      ↓
Application Listening?
      ↓
Route Table?
      ↓
Internet Gateway?
```

Useful commands:

```bash
sudo systemctl status httpd
```

Check listening ports:

```bash
ss -tulnp
```

---

# 🧪 Basic EC2 Hands-on Lab

## Objective

Launch a Linux EC2 instance and deploy a simple Apache web server.

### Step 1 — Launch EC2

```text
AWS Console
   ↓
EC2
   ↓
Launch Instance
```

Choose a Linux AMI.

---

### Step 2 — Select Instance Type

Choose a small instance type suitable for your lab.

---

### Step 3 — Configure Networking

Select:

```text
VPC
Subnet
Security Group
```

For a public web-server lab, ensure the subnet has appropriate Internet routing.

---

### Step 4 — Configure Security Group

Allow:

```text
SSH
TCP 22
Source: Your IP
```

and:

```text
HTTP
TCP 80
Source: 0.0.0.0/0
```

---

### Step 5 — Select Key Pair

Create or select a key pair.

Keep the private key secure.

---

### Step 6 — Launch

Wait until:

```text
Instance State: Running
```

and status checks pass.

---

### Step 7 — Connect

Example:

```bash
ssh -i my-key.pem ec2-user@PUBLIC_IP
```

---

### Step 8 — Install Apache

On Amazon Linux, for example:

```bash
sudo dnf install -y httpd
```

Start Apache:

```bash
sudo systemctl start httpd
```

Enable Apache at startup:

```bash
sudo systemctl enable httpd
```

Check status:

```bash
sudo systemctl status httpd
```

---

### Step 9 — Create Web Page

```bash
echo "Hello from my EC2 server" | sudo tee /var/www/html/index.html
```

---

### Step 10 — Test

Open:

```text
http://PUBLIC_IP
```

Expected result:

```text
Hello from my EC2 server
```

---

# 🛡️ EC2 Security Best Practices

* Use IAM roles instead of storing AWS access keys on EC2.
* Follow the principle of least privilege.
* Restrict Security Group rules.
* Avoid exposing SSH to the entire Internet.
* Use SSM Session Manager where appropriate.
* Keep the operating system updated.
* Install only required software.
* Encrypt EBS volumes where appropriate.
* Protect SSH private keys.
* Monitor EC2 instances.
* Use private subnets for private workloads where appropriate.
* Delete unused resources to avoid unnecessary costs.

---

# 🧠 Quick Revision

| Concept          | Simple Meaning                                     |
| ---------------- | -------------------------------------------------- |
| EC2              | Virtual server in AWS                              |
| AMI              | Template used to launch an instance                |
| Instance Type    | Defines compute resources                          |
| vCPU             | Virtual CPU                                        |
| Memory           | RAM available to the instance                      |
| Key Pair         | Used for secure authentication                     |
| VPC              | Virtual network in AWS                             |
| Subnet           | Network segment inside a VPC                       |
| Security Group   | Virtual firewall                                   |
| Private IP       | Internal VPC address                               |
| Public IP        | Internet-routable IPv4 address                     |
| Elastic IP       | Static public IPv4 address                         |
| EBS              | Persistent block storage                           |
| Snapshot         | Point-in-time EBS backup                           |
| User Data        | Startup automation                                 |
| IAM Role         | Gives EC2 permissions to AWS services              |
| Route Table      | Controls network routing                           |
| Internet Gateway | Provides VPC-to-Internet connectivity              |
| NAT Gateway      | Provides outbound connectivity for private subnets |
| CloudWatch       | Monitoring service                                 |
| Auto Scaling     | Adjusts EC2 capacity                               |
| Load Balancer    | Distributes traffic                                |
| Spot Instance    | Discounted interruptible capacity                  |

---

# ⭐ Best Practices

1. **Use IAM Roles** instead of hardcoded AWS credentials.
2. **Restrict Security Groups** to required ports and sources.
3. **Use private subnets** for workloads that don't need direct Internet access.
4. **Use SSM** where appropriate instead of exposing SSH.
5. **Monitor EC2** using CloudWatch.
6. **Use Auto Scaling** when application capacity needs to change automatically.
7. **Use Load Balancers** for highly available applications.
8. **Backup important data** using EBS snapshots or appropriate backup solutions.
9. **Keep systems updated**.
10. **Terminate unused instances** to avoid unnecessary AWS costs.

