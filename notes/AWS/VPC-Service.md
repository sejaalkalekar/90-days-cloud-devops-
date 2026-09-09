# 🌐 AWS VPC (Virtual Private Cloud)

## 📖 Introduction

**Amazon VPC (Virtual Private Cloud)** allows you to create your own private network inside AWS.

Think of a VPC like a **private office building** in the AWS cloud.

Inside this building, you can create:

* 🏢 Subnets
* 🚪 Route Tables
* 🔐 Security Groups
* 🛡️ Network ACLs
* 🌍 Internet Gateway
* 🔄 NAT Gateway
* 🖥️ EC2 instances
* 🗄️ RDS databases

### Simple Example

Imagine you have a company office:

```text
Company Office
│
├── Development Department
├── Testing Department
├── Production Department
└── Database Department
```

Similarly, in AWS:

```text
VPC
│
├── Public Subnet
├── Private Subnet
├── Database Subnet
└── Security & Routing
```

---

# 🧠 1. What is AWS VPC?

**VPC = Virtual Private Cloud**

A VPC is an isolated virtual network that you create inside AWS.

It allows you to control:

* IP addresses
* Subnets
* Routing
* Internet access
* Network security
* Communication between resources

### Example

You can create:

```text
VPC
CIDR: 10.0.0.0/16
```

This gives your VPC a private IP address range.

---

# 🏠 2. Why Do We Need a VPC?

Most AWS applications need a network where their resources can communicate securely.

For example:

```text
Users
  ↓
Load Balancer
  ↓
Web Servers
  ↓
Application Servers
  ↓
Database
```

You don't want your database directly exposed to the internet.

A VPC allows you to separate these resources.

Example:

```text
                    Internet
                       │
                       ↓
              ┌─────────────────┐
              │  Public Subnet  │
              │ Load Balancer   │
              └────────┬────────┘
                       │
                       ↓
              ┌─────────────────┐
              │ Private Subnet  │
              │ Application     │
              │ Servers         │
              └────────┬────────┘
                       │
                       ↓
              ┌─────────────────┐
              │ Database Subnet │
              │ RDS             │
              └─────────────────┘
```

---

# 🧱 3. Main Components of a VPC

A typical VPC contains:

```text
VPC
│
├── CIDR Block
│
├── Subnets
│   ├── Public Subnet
│   └── Private Subnet
│
├── Route Tables
│
├── Internet Gateway
│
├── NAT Gateway
│
├── Security Groups
│
└── Network ACLs
```

Let's understand each one.

---

# 🔢 4. VPC CIDR Block

CIDR defines the IP address range available inside your VPC.

Example:

```text
10.0.0.0/16
```

This is the network range for the VPC.

You can divide this range into smaller subnet ranges.

Example:

```text
VPC
10.0.0.0/16
│
├── Public Subnet
│   10.0.1.0/24
│
├── Private Subnet
│   10.0.2.0/24
│
└── Database Subnet
    10.0.3.0/24
```

### Simple Idea

Think of:

```text
10.0.0.0/16
```

as a large apartment building.

Each subnet is like a separate floor.

---

# 🧩 5. What is a Subnet?

A **subnet** is a smaller network inside a VPC.

Example:

```text
VPC: 10.0.0.0/16

Subnet 1: 10.0.1.0/24
Subnet 2: 10.0.2.0/24
Subnet 3: 10.0.3.0/24
```

Each subnet belongs to one Availability Zone.

### Why use subnets?

To separate resources.

For example:

```text
Public Subnet
    ↓
Load Balancer

Private Subnet
    ↓
EC2 Application Server

Database Subnet
    ↓
RDS
```

---

# 🌍 6. Public Subnet

A subnet is generally considered **public** when its route table has a route to an **Internet Gateway**.

Example:

```text
Public Subnet
     │
     ↓
Internet Gateway
     │
     ↓
Internet
```

Resources such as:

* Load Balancers
* Public web servers
* Bastion hosts

may be placed in public subnets when appropriate.

---

# 🔒 7. Private Subnet

A private subnet does **not** have a direct route to an Internet Gateway.

Example:

```text
Private Subnet
     │
     ↓
NAT Gateway
     │
     ↓
Internet
```

Private subnets are commonly used for:

* Application servers
* Backend servers
* Internal services

---

# 🗄️ 8. Database Subnet

Databases are commonly placed in private subnets.

Example:

```text
Internet
   ↓
Load Balancer
   ↓
Web/Application Servers
   ↓
Private Database Subnets
   ↓
RDS
```

The database does not need to accept connections directly from the public internet.

---

# 🌎 9. Availability Zones

An AWS Region contains multiple **Availability Zones (AZs)**.

Example:

```text
AWS Region: ap-south-1

├── ap-south-1a
├── ap-south-1b
└── ap-south-1c
```

A subnet exists in **one Availability Zone**.

For high availability, you can create subnets across multiple AZs.

Example:

```text
VPC
│
├── AZ 1
│   └── Public Subnet
│
├── AZ 2
│   └── Public Subnet
│
└── AZ 3
    └── Public Subnet
```

---

# 🚪 10. Internet Gateway (IGW)

An **Internet Gateway** allows communication between a VPC and the internet.

Example:

```text
EC2
 ↓
Route Table
 ↓
Internet Gateway
 ↓
Internet
```

### Important

Creating an Internet Gateway alone does **not** make a subnet public.

You also need a route in the subnet's route table pointing internet traffic to the Internet Gateway.

Example:

```text
0.0.0.0/0 → Internet Gateway
```

---

# 🔄 11. NAT Gateway

**NAT Gateway** allows resources in private subnets to access the internet for outbound connections.

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

### Example

A private EC2 server may need to download software:

```text
Private EC2
     ↓
NAT Gateway
     ↓
Internet
     ↓
Package Repository
```

The outside internet cannot directly start a connection to that private EC2 through the NAT Gateway.

---

# 🛣️ 12. Route Table

A **Route Table** tells AWS where network traffic should go.

Think of it like a **GPS for network traffic**.

Example:

```text
Destination       Target

10.0.0.0/16       local
0.0.0.0/0         Internet Gateway
```

This means:

* Traffic inside the VPC → stay inside the VPC
* Other traffic → send to the Internet Gateway

---

# 🏠 13. Local Route

When you create a VPC, AWS automatically creates a local route.

Example:

```text
10.0.0.0/16 → local
```

This allows resources inside the VPC to communicate with other resources in the VPC, subject to their security controls.

---

# 🔐 14. Security Groups

A **Security Group (SG)** acts like a firewall for resources such as EC2.

Example:

```text
Internet
   ↓
Security Group
   ↓
EC2
```

You can control:

* Inbound traffic
* Outbound traffic
* Ports
* Protocols
* Sources/destinations

Example:

```text
HTTP   80    → 0.0.0.0/0
HTTPS  443   → 0.0.0.0/0
SSH    22    → Your IP
```

Security Groups are **stateful**.

---

# 🛡️ 15. Network ACL

A **Network ACL (NACL)** is another layer of network security.

It works at the **subnet level**.

Example:

```text
VPC
 │
 └── Subnet
      │
      └── Network ACL
            │
            └── EC2
```

NACLs support:

* Allow rules
* Deny rules

They are **stateless**, unlike Security Groups.

---

# 🆚 16. Security Group vs NACL

| Feature        | Security Group        | Network ACL                |
| -------------- | --------------------- | -------------------------- |
| Works at       | Resource/ENI level    | Subnet level               |
| Rules          | Allow only            | Allow + Deny               |
| Stateful       | ✅ Yes                 | ❌ No                       |
| Return traffic | Automatically allowed | Must be explicitly allowed |
| Common use     | EC2/RDS protection    | Subnet-level filtering     |

### Easy way to remember

```text
Security Group → Resource firewall
NACL            → Subnet firewall
```

---

# 📍 17. Public IP vs Private IP

### Private IP

Used for communication inside private networks.

Example:

```text
10.0.1.10
```

### Public IP

Used for communication over the public internet.

Example:

```text
13.x.x.x
```

An EC2 instance can have both:

```text
Private IP → Communication inside VPC

Public IP → Internet communication
```

---

# 🔗 18. Elastic IP

An **Elastic IP** is a static public IPv4 address that you can associate with an AWS resource.

Useful when you need a public IPv4 address that should remain stable.

However, avoid using public IPs when they are not necessary.

---

# 🔌 19. VPC Endpoints

A **VPC Endpoint** allows resources in a VPC to communicate with supported AWS services without requiring internet access.

Example:

```text
Private EC2
    │
    ↓
VPC Endpoint
    │
    ↓
Amazon S3
```

This can help keep traffic within the AWS network and reduce the need for internet/NAT access for supported services.

Common endpoint types include:

* Gateway endpoints
* Interface endpoints

---

# 🔗 20. VPC Peering

**VPC Peering** allows two VPCs to communicate privately.

Example:

```text
VPC A
10.0.0.0/16
    │
    │ VPC Peering
    │
VPC B
10.1.0.0/16
```

The VPCs must have non-overlapping IP ranges for straightforward routing.

---

# 🌐 21. VPC and DNS

A VPC can provide DNS functionality for resources inside the network.

DNS helps convert names into IP addresses.

Example:

```text
database.example.com
        ↓
     IP Address
```

VPC DNS settings are important for services such as EC2 and RDS.

---

# 🏗️ 22. Simple VPC Architecture

A common production-style architecture looks like this:

```text
                         Internet
                            │
                            ↓
                  ┌──────────────────┐
                  │ Internet Gateway │
                  └────────┬─────────┘
                           │
             ┌─────────────┴─────────────┐
             │                           │
             ↓                           ↓
       Public Subnet 1            Public Subnet 2
       AZ-1                       AZ-2
             │                           │
             └──────────┬────────────────┘
                        ↓
                 Load Balancer
                        │
             ┌──────────┴──────────┐
             ↓                     ↓
      Private Subnet 1      Private Subnet 2
        EC2/App Server        EC2/App Server
             │                     │
             └──────────┬──────────┘
                        ↓
                 Database Subnets
                     RDS
```

---

# 🔄 23. How Internet Traffic Works

### Public EC2

```text
User
 ↓
Internet
 ↓
Internet Gateway
 ↓
Route Table
 ↓
Public Subnet
 ↓
Security Group
 ↓
EC2
```

### Private EC2 → Internet

```text
Private EC2
 ↓
Private Route Table
 ↓
NAT Gateway
 ↓
Internet Gateway
 ↓
Internet
```

---

# 🧪 24. Hands-on VPC Lab

Let's create a simple VPC.

### Step 1: Create VPC

Example:

```text
Name: devops-vpc
IPv4 CIDR: 10.0.0.0/16
```

---

### Step 2: Create Public Subnet

```text
Name: public-subnet
CIDR: 10.0.1.0/24
```

---

### Step 3: Create Private Subnet

```text
Name: private-subnet
CIDR: 10.0.2.0/24
```

---

### Step 4: Create Internet Gateway

Create:

```text
devops-igw
```

Attach it to:

```text
devops-vpc
```

---

### Step 5: Create Public Route Table

Example:

```text
Destination       Target

10.0.0.0/16       local
0.0.0.0/0         Internet Gateway
```

Associate it with:

```text
public-subnet
```

---

### Step 6: Create Private Route Table

Example:

```text
Destination       Target

10.0.0.0/16       local
```

Associate it with:

```text
private-subnet
```

---

### Step 7: Launch EC2

Launch one EC2 instance in the public subnet.

Then verify:

```text
EC2
 ↓
Public Subnet
 ↓
Internet Gateway
 ↓
Internet
```

---

# 🔍 25. How to Check VPC Configuration

From the AWS Console, check:

### VPC

```text
VPC → Your VPCs
```

### Subnets

```text
VPC → Subnets
```

### Route Tables

```text
VPC → Route Tables
```

### Internet Gateway

```text
VPC → Internet Gateways
```

### Security Groups

```text
VPC → Security Groups
```

---

# 🐛 26. Common VPC Problems

### EC2 cannot access the internet

Check:

```text
1. Does the subnet have the correct route?
2. Is the Internet Gateway attached?
3. Does the EC2 have a public IPv4 address if needed?
4. Is the Security Group allowing required traffic?
5. Is the Network ACL blocking traffic?
```

---

### Private EC2 cannot access the internet

Check:

```text
Private EC2
     ↓
Private Route Table
     ↓
NAT Gateway
     ↓
Internet Gateway
```

Make sure the route table and NAT Gateway configuration are correct.

---

### EC2 cannot connect to another EC2

Check:

```text
Security Group
NACL
Route Table
IP addresses
```

---

# 🛡️ 27. VPC Best Practices

### 🔐 1. Keep databases private

Do not expose databases directly to the internet.

### 🔐 2. Use multiple Availability Zones

For important workloads, design for high availability.

### 🔐 3. Use private subnets

Keep application and database resources private when public access is unnecessary.

### 🔐 4. Restrict Security Groups

Avoid:

```text
0.0.0.0/0
```

for sensitive ports such as SSH and database ports unless there is a specific reason.

### 🔐 5. Plan CIDR ranges

Choose IP ranges carefully before building a large network.

### 🔐 6. Use meaningful names

Example:

```text
production-vpc
public-subnet-1
private-subnet-1
database-subnet-1
```

### 🔐 7. Monitor network traffic

Use AWS monitoring and logging services where appropriate.

---

# 🧠 28. Quick Revision

| Term              | Simple Meaning                               |
| ----------------- | -------------------------------------------- |
| VPC               | Your private network in AWS                  |
| CIDR              | IP address range                             |
| Subnet            | Smaller network inside VPC                   |
| Public Subnet     | Subnet with route to Internet Gateway        |
| Private Subnet    | No direct route to Internet Gateway          |
| Route Table       | Controls where traffic goes                  |
| Internet Gateway  | Connects VPC to internet                     |
| NAT Gateway       | Allows private resources to access internet  |
| Security Group    | Firewall for resources                       |
| NACL              | Firewall at subnet level                     |
| VPC Endpoint      | Private connection to supported AWS services |
| VPC Peering       | Private connection between VPCs              |
| Availability Zone | Isolated location inside an AWS Region       |

---

# ⭐ Remember These 5 Things

If you are new to VPC, remember this first:

```text
VPC
 ↓
Subnets
 ↓
Route Tables
 ↓
Internet/NAT Gateway
 ↓
Security Groups
```

And remember:

> **VPC = Network**
> **Subnet = Section of the network**
> **Route Table = Traffic direction**
> **Gateway = Connection**
> **Security Group = Firewall**

---