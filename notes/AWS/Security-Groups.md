# 🔐 AWS Security Groups

## 📖 Introduction

An **AWS Security Group (SG)** is a **virtual firewall** that controls network traffic to and from an AWS resource.

Think of it like a **security guard** for your EC2 server.

The security guard checks:

- 👤 Who is trying to connect?
- 🚪 Which port are they using?
- 🌐 Where is the traffic coming from?
- 📤 Where is the traffic going?

Based on the rules, the Security Group either:

- ✅ Allows the traffic
- ❌ Blocks the traffic

### Simple Example

Imagine you have an EC2 server:

```text
Internet
   │
   │ Request
   ↓
🔐 Security Group
   │
   ↓
🖥️ EC2 Server
````

The Security Group decides whether the request can reach the EC2 server.

---

# 🧱 1. Why Do We Need Security Groups?

Suppose you launch an EC2 server that runs a website.

Without proper network rules, you don't want everyone to be able to access every service running on that server.

For example:

```text
SSH       → Port 22
HTTP      → Port 80
HTTPS     → Port 443
PostgreSQL → Port 5432
```

You may want:

```text
HTTP  → Everyone can access ✅
HTTPS → Everyone can access ✅
SSH   → Only your IP can access ✅
5432  → Only application server can access ✅
```

Security Groups allow you to create these rules.

---

# 📥 2. Inbound Rules

An **Inbound Rule** controls **incoming traffic**.

In simple words:

> **Who can connect to my AWS resource?**

Example:

```text
Your Computer
     │
     │ SSH : 22
     ↓
🔐 Security Group
     │
     ↓
🖥️ EC2
```

If the Security Group allows:

```text
SSH
Port: 22
Source: Your IP
```

the connection is allowed.

### Example

```text
Type: SSH
Protocol: TCP
Port: 22
Source: My IP
```

This means:

> Allow SSH connections on port 22 from my IP address.

---

# 📤 3. Outbound Rules

An **Outbound Rule** controls **traffic leaving the AWS resource**.

In simple words:

> **Where can my AWS resource connect to?**

Example:

```text
🖥️ EC2
   │
   │ HTTPS : 443
   ↓
🌐 Internet
```

The Security Group checks whether the outbound traffic is allowed.

A newly created Security Group commonly has a default outbound rule that allows all outbound traffic.

Always review outbound access according to your application's security requirements.

---

# 🔄 4. Inbound vs Outbound

The easiest way to remember:

```text
📥 Inbound
Outside → AWS Resource

📤 Outbound
AWS Resource → Outside
```

Example:

```text
                📥 INBOUND
                    ↓
Internet ─────→ Security Group ─────→ EC2
                                      │
                                      │
                                      ↓
                📤 OUTBOUND
EC2 ─────────→ Security Group ─────→ Internet
```

---

# 🔢 5. Ports and Protocols

Before understanding Security Group rules, you need to understand **ports**.

A port identifies a network service.

Think of an IP address as the **building address** and a port as the **specific door**.

For example:

```text
EC2 IP Address
     │
     ├── Port 22  → SSH
     ├── Port 80  → HTTP
     ├── Port 443 → HTTPS
     └── Port 5432 → PostgreSQL
```

### Common Ports

| Service    |  Port | Protocol |
| ---------- | ----: | -------- |
| SSH        |    22 | TCP      |
| HTTP       |    80 | TCP      |
| HTTPS      |   443 | TCP      |
| PostgreSQL |  5432 | TCP      |
| MySQL      |  3306 | TCP      |
| MongoDB    | 27017 | TCP      |
| DNS        |    53 | TCP/UDP  |

You don't need to memorize every port.

Start with the common ones.

---

# 🌍 6. Source: Where Is the Traffic Coming From?

For an inbound rule, the **Source** tells AWS where the traffic is allowed to come from.

There are three common options beginners should understand.

---

## 6.1 Your IP Address

Suppose your public IP is:

```text
203.0.113.10
```

You can allow SSH only from your IP:

```text
SSH
Port: 22
Source: 203.0.113.10/32
```

The `/32` means:

> Only this single IP address.

This is safer than allowing SSH from everyone.

---

## 6.2 CIDR Range

You can also allow an entire network range.

Example:

```text
10.0.0.0/16
```

This represents a network range.

You will learn CIDR more deeply when studying **AWS VPC networking**.

For now, remember:

> CIDR defines a range of IP addresses.

---

## 6.3 Another Security Group

AWS also allows one Security Group to reference another Security Group.

This is very useful for AWS architectures.

Example:

```text
Application Server
       │
       │ PostgreSQL : 5432
       ↓
Database
```

Instead of allowing access from the entire internet, the database can allow traffic from:

```text
Application-SG
```

This means:

> Allow PostgreSQL traffic from resources using Application-SG.

This is a very common AWS design.

---

# 🔐 7. Security Groups Are Stateful

This sounds complicated, but the idea is simple.

**Stateful** means that when a connection is allowed, the response traffic is automatically allowed.

Example:

```text
Your Computer
     │
     │ Request
     ↓
    EC2
     │
     │ Response
     ↓
Your Computer
```

If the incoming connection is allowed, you don't need to create a separate rule just to allow the response.

### Easy way to remember

```text
Security Group = Stateful
```

---

# 🚫 8. Security Groups Allow Traffic

Security Groups use **allow rules**.

You create rules such as:

```text
Allow SSH
Allow HTTP
Allow HTTPS
```

You don't create an explicit deny rule inside a Security Group.

If traffic doesn't match an allowed rule, it is blocked.

### Example

Suppose your Security Group contains:

```text
Allow HTTP : 80
Allow HTTPS : 443
```

A request to:

```text
Port 8080
```

doesn't match an allowed rule.

Result:

```text
Port 8080 → Blocked ❌
```

---

# 🖥️ 9. Security Group with EC2

Let's use a simple EC2 example.

Suppose your EC2 server hosts a website.

```text
             Internet
                 │
                 ↓
          🔐 Web-SG
             │
             ↓
          🖥️ EC2
```

You might configure:

```text
HTTP
Port: 80
Source: 0.0.0.0/0
```

and:

```text
HTTPS
Port: 443
Source: 0.0.0.0/0
```

For SSH:

```text
SSH
Port: 22
Source: Your-IP/32
```

### Result

```text
HTTP  : 80  → Allowed ✅
HTTPS : 443 → Allowed ✅
SSH   : 22  → Your IP only ✅
```

---

# 🗄️ 10. Security Group with RDS

Security Groups are not only used with EC2.

They are also commonly used with databases such as **Amazon RDS**.

Imagine:

```text
🖥️ Application Server
        │
        │ PostgreSQL : 5432
        ↓
🗄️ RDS PostgreSQL
```

Create:

```text
Application-SG
Database-SG
```

Then configure the Database Security Group:

```text
Type: PostgreSQL
Port: 5432
Source: Application-SG
```

Now the application server can communicate with the database.

### Why is this better?

Instead of:

```text
PostgreSQL : 5432
Source: 0.0.0.0/0
```

you allow only the required application resources.

---

# 🔗 11. Security Group to Security Group Communication

This is one of the most useful concepts to understand.

Consider a three-layer application:

```text
Internet
    │
    ↓
Load Balancer
    │
    ↓
Application Server
    │
    ↓
Database
```

You can create three Security Groups:

```text
ALB-SG
App-SG
DB-SG
```

Then create rules like:

```text
ALB-SG
   │
   │ HTTP/HTTPS
   ↓
App-SG
   │
   │ PostgreSQL
   ↓
DB-SG
```

### Example Rules

**App-SG**

```text
HTTP/HTTPS
Source: ALB-SG
```

**DB-SG**

```text
PostgreSQL : 5432
Source: App-SG
```

This allows each layer to communicate only with the required layer.

---

# 🆚 12. Security Group vs Network ACL

You will hear about another AWS networking feature called **Network ACL (NACL)**.

Don't worry about the details yet.

The basic difference is:

| Feature  | Security Group        | Network ACL                  |
| -------- | --------------------- | ---------------------------- |
| Protects | Resource              | Subnet                       |
| Rules    | Allow                 | Allow + Deny                 |
| Stateful | Yes                   | No                           |
| Main use | Resource-level access | Subnet-level traffic control |

### Easy way to remember

```text
Security Group
      ↓
Protects the resource

NACL
      ↓
Protects the subnet
```

For most EC2 and RDS work, you will use Security Groups frequently.

---

# 🧩 13. Security Groups and VPC

Security Groups work inside an AWS **VPC**.

For example:

```text
VPC
│
├── Public Subnet
│     │
│     └── EC2
│          └── Web-SG
│
└── Private Subnet
      │
      └── RDS
           └── DB-SG
```

You will learn VPC, subnets, route tables, Internet Gateway, and NAT Gateway separately.

For now, remember:

> Security Groups control network access to resources inside your AWS networking environment.

---

# 🧪 14. Hands-on Lab

## 🎯 Objective

Create a Security Group for an EC2 web server.

### Step 1: Open EC2

Go to:

```text
AWS Console
→ EC2
→ Security Groups
```

### Step 2: Create Security Group

Example:

```text
Name:
web-server-sg

Description:
Security group for web server
```

Select the required VPC.

---

### Step 3: Add Inbound Rules

Add:

```text
HTTP
Port: 80
Source: 0.0.0.0/0
```

```text
HTTPS
Port: 443
Source: 0.0.0.0/0
```

For SSH:

```text
SSH
Port: 22
Source: My IP
```

---

### Step 4: Review Outbound Rules

Review the default outbound rule.

For a beginner lab, you can leave the default outbound configuration unless you have a specific reason to restrict it.

---

### Step 5: Create the Security Group

Click:

```text
Create security group
```

---

### Step 6: Attach It to EC2

When launching an EC2 instance:

```text
EC2
  ↓
Security Group
  ↓
web-server-sg
```

---

### Step 7: Test

If your EC2 instance has a web server running:

```text
http://EC2-PUBLIC-IP
```

HTTP should work.

If SSH is configured:

```bash
ssh -i key.pem ec2-user@EC2-PUBLIC-IP
```

SSH should work only from the IP allowed in the Security Group.

---

# 🔍 15. Troubleshooting Security Group Issues

If you cannot connect to your EC2 instance, check the following.

### 1️⃣ Check the Security Group

Make sure the correct Security Group is attached to the EC2 instance.

```text
EC2
→ Instance
→ Security
→ Security Groups
```

---

### 2️⃣ Check the Port

Make sure the required port is allowed.

For example:

```text
SSH   → 22
HTTP  → 80
HTTPS → 443
```

---

### 3️⃣ Check the Source

If SSH is allowed from:

```text
Your-IP/32
```

but your public IP changed, the connection may stop working.

---

### 4️⃣ Check Whether the Application Is Running

A Security Group can allow port 80, but if no web server is running, the website still won't work.

For example:

```bash
sudo ss -tulnp
```

---

### 5️⃣ Check Other AWS Networking Components

If the Security Group is correct but the connection still fails, you may need to check:

* Network ACL
* Route Table
* Internet Gateway
* Subnet
* Public/private configuration
* EC2 service/application

---

# 🛡️ 16. Security Group Best Practices

### ✅ 1. Allow Only Required Ports

Don't open ports that your application doesn't need.

---

### ✅ 2. Restrict SSH

Avoid:

```text
SSH : 22
Source: 0.0.0.0/0
```

Prefer:

```text
SSH : 22
Source: Your-IP/32
```

Or use **AWS Systems Manager Session Manager** when appropriate.

---

### ✅ 3. Don't Expose Databases

Avoid making database ports publicly accessible unless there is a strong architectural reason.

For example:

```text
PostgreSQL : 5432
Source: 0.0.0.0/0
```

is generally unsafe.

Prefer:

```text
PostgreSQL : 5432
Source: Application-SG
```

---

### ✅ 4. Use Security Group References

For AWS-to-AWS communication, prefer:

```text
App-SG → DB-SG
```

instead of allowing a large IP range when possible.

---

### ✅ 5. Use Meaningful Names

Good:

```text
web-server-sg
application-server-sg
database-sg
load-balancer-sg
```

Avoid confusing names such as:

```text
sg-1
test-sg
new-sg
```

---

### ✅ 6. Add Descriptions

Example:

```text
Allow PostgreSQL access from application servers
```

Descriptions make your rules easier to understand later.

---

### ✅ 7. Remove Unused Rules

Regularly review your Security Groups and remove rules that are no longer required.

---

# 🧠 17. Quick Revision

### What is a Security Group?

```text
Security Group
      ↓
Virtual Firewall
      ↓
Controls Network Traffic
      ↓
Protects AWS Resources
```

### Remember:

```text
📥 Inbound
Outside → AWS Resource

📤 Outbound
AWS Resource → Outside

🔐 Stateful
Response traffic is automatically allowed

✅ Allow Rules
Security Groups use allow rules

🖥️ Resource Level
Security Groups protect resources

🌐 NACL
Works at subnet level
```

### Common Ports

```text
SSH        → 22
HTTP       → 80
HTTPS      → 443
MySQL      → 3306
PostgreSQL → 5432
MongoDB    → 27017
```

### Common Architecture

```text
             🌐 Internet
                  │
                  ↓
             Load Balancer
                ALB-SG
                  │
                  ↓
          Application Server
                App-SG
                  │
                  ↓
             RDS Database
                 DB-SG
```

The idea is:

```text
Internet
   ↓
ALB-SG
   ↓
App-SG
   ↓
DB-SG
```

Each layer gets access only to what it needs.

---

# ⭐ Best Practices

* 🔐 Allow only required traffic
* 🚫 Avoid unnecessary open ports
* 🔑 Restrict SSH access
* 🗄️ Keep databases protected
* 🔗 Prefer Security Group references
* 📝 Use meaningful names and descriptions
* 🧹 Remove unused rules
* 🔍 Check networking components when troubleshooting
* 🛡️ Follow the principle of least privilege
