# ⚖️ AWS Application Load Balancer (ALB)

## 📖 Introduction

When a website or application becomes busy, running it on only one EC2 instance can create problems.

For example:

```text
Users
  ↓
EC2 Instance
```

If many users access the application at the same time:

* The server can become overloaded.
* If the server fails, the application becomes unavailable.
* Traffic cannot be distributed across multiple servers.

AWS provides **Elastic Load Balancing (ELB)** to distribute incoming traffic across multiple resources.

For web applications, one of the most commonly used options is:

> **Application Load Balancer (ALB)**

A simple architecture looks like:

```text
              Users
                ↓
        Application Load Balancer
             ↙       ↘
            ↓         ↓
         EC2-1      EC2-2
```

---

# ⚖️ 1. What is a Load Balancer?

A **Load Balancer** distributes incoming network traffic across multiple servers.

Instead of sending every request to one server:

```text
Users
  ↓
Server
```

we can distribute requests:

```text
                 Load Balancer
                ↙      ↓      ↘
              EC2-1   EC2-2   EC2-3
```

### Simple Example

Imagine a restaurant with one cashier.

If 100 customers arrive:

```text
Customers
    ↓
One Cashier
```

The cashier can become overloaded.

Now imagine three cashiers:

```text
             Customers
                 ↓
           Reception/Router
          ↙       ↓       ↘
     Cashier 1 Cashier 2 Cashier 3
```

The work can be distributed.

A load balancer works in a similar way.

---

# 🧩 2. What is Application Load Balancer?

An **Application Load Balancer (ALB)** is a Layer 7 load balancer provided by AWS.

It operates at the **application layer** and is designed primarily for HTTP and HTTPS traffic.

ALB can make routing decisions based on information such as:

* Hostname
* URL path
* HTTP headers
* HTTP methods
* Query parameters

### Example

Suppose we have:

```text
example.com/
example.com/api
example.com/images
```

We can route requests differently:

```text
example.com/
       ↓
   Web Servers

example.com/api
       ↓
   API Servers

example.com/images
       ↓
   Image Servers
```

This is called **content-based routing**.

---

# 🏗️ 3. Basic ALB Architecture

A common AWS architecture looks like:

```text
                     Internet
                        ↓
                 Internet Gateway
                        ↓
              Application Load Balancer
                  ↙           ↘
                 ↓             ↓
              EC2-1          EC2-2
                 ↓             ↓
                    Application
```

The ALB receives requests and forwards them to healthy backend servers.

---

# 🌐 4. Where Does ALB Live?

An ALB is deployed across **multiple Availability Zones**.

For example:

```text
                 VPC
                  |
        ┌─────────┴─────────┐
        ↓                   ↓
   Availability Zone A   Availability Zone B
        |                   |
   Public Subnet        Public Subnet
        |                   |
       ALB                 ALB
        ↓                   ↓
      EC2-1               EC2-2
```

Using multiple Availability Zones improves availability.

### Important

For a typical internet-facing ALB:

* ALB is placed in public subnets.
* Backend EC2 instances can be in private subnets.
* The ALB communicates with the backend instances.

---

# 🎯 5. What is a Target?

A **target** is a resource that receives traffic from the load balancer.

Examples include:

* EC2 instances
* IP addresses
* Lambda functions

For a basic EC2 application:

```text
ALB
 ↓
Target Group
 ↓
EC2 Instances
```

---

# 👥 6. What is a Target Group?

A **Target Group** is a collection of targets that the ALB sends traffic to.

Example:

```text
Target Group
│
├── EC2-1
├── EC2-2
└── EC2-3
```

The ALB uses the target group to determine where requests should be forwarded.

---

# ❤️ 7. Health Checks

One of the most important features of an ALB is **health checking**.

The ALB regularly checks whether targets are healthy.

Example:

```text
ALB
│
├── EC2-1 → Healthy ✅
├── EC2-2 → Healthy ✅
└── EC2-3 → Unhealthy ❌
```

If EC2-3 becomes unhealthy, the ALB stops sending new requests to it.

Traffic continues to healthy targets:

```text
             ALB
            /   \
           ↓     ↓
        EC2-1   EC2-2
        Healthy Healthy

        EC2-3
       Unhealthy
```

### Example Health Check

The ALB can check:

```text
HTTP
Port: 80
Path: /
```

If the application returns a successful response, the target can be considered healthy.

---

# 🔄 8. How ALB Handles a Request

Suppose a user opens:

```text
https://example.com
```

The request flows approximately like this:

```text
User
 ↓
DNS
 ↓
ALB
 ↓
Listener
 ↓
Listener Rule
 ↓
Target Group
 ↓
Healthy EC2
 ↓
Application Response
 ↓
ALB
 ↓
User
```

---

# 👂 9. What is an ALB Listener?

A **Listener** checks for incoming connection requests.

For example:

```text
HTTP  → Port 80
HTTPS → Port 443
```

Example:

```text
ALB
│
├── Listener :80
│
└── Listener :443
```

The listener receives the request and applies its rules.

---

# 📜 10. Listener Rules

Listener rules determine where traffic should go.

For example:

```text
IF Host = api.example.com
        ↓
API Target Group
```

Another rule:

```text
IF Path = /images/*
        ↓
Image Target Group
```

Example:

```text
example.com/api/*
        ↓
API Servers

example.com/images/*
        ↓
Image Servers
```

This is one of the major advantages of an ALB.

---

# 🛣️ 11. Path-Based Routing

ALB can route requests based on URL paths.

Example:

```text
example.com/
        ↓
Web Target Group

example.com/api/*
        ↓
API Target Group

example.com/admin/*
        ↓
Admin Target Group
```

This allows different applications or services to use the same ALB.

---

# 🌐 12. Host-Based Routing

ALB can also route based on hostname.

Example:

```text
www.example.com
        ↓
Website Target Group

api.example.com
        ↓
API Target Group

admin.example.com
        ↓
Admin Target Group
```

This is called **host-based routing**.

---

# ⚖️ 13. Load Balancing Algorithms

The ALB distributes requests among healthy targets.

A common algorithm is **round robin**.

Example:

```text
Request 1 → EC2-1
Request 2 → EC2-2
Request 3 → EC2-3
Request 4 → EC2-1
Request 5 → EC2-2
```

ALB also supports other routing behavior, including **least outstanding requests**, which can help when requests take different amounts of time to complete.

---

# 🔐 14. Security Groups with ALB

Security Groups are very important when using an ALB.

A common setup is:

```text
Internet
   ↓
ALB Security Group
   ↓
EC2 Security Group
```

### ALB Security Group

Allow:

```text
HTTP  : 80
HTTPS : 443
```

from appropriate client sources, often the internet for a public website.

### EC2 Security Group

Allow the application port **from the ALB's security group**, rather than allowing the whole internet.

Example:

```text
ALB-SG
  ↓
EC2-SG
```

This is more secure than:

```text
Internet
  ↓
EC2-SG
```

---

# 🔒 15. HTTPS and SSL/TLS

ALB can handle HTTPS traffic.

Example:

```text
User
 ↓
HTTPS :443
 ↓
ALB
 ↓
HTTP/HTTPS
 ↓
EC2
```

You can use an SSL/TLS certificate with the ALB, commonly managed through **AWS Certificate Manager (ACM)**.

This allows the ALB to terminate HTTPS connections.

---

# 🔁 16. SSL Termination

Suppose a user connects using HTTPS:

```text
User
  |
 HTTPS
  ↓
 ALB
  |
 HTTP
  ↓
 EC2
```

The ALB decrypts the HTTPS traffic.

This is called **SSL/TLS termination** at the load balancer.

You can also use HTTPS between the ALB and backend targets when required.

---

# 🚀 17. ALB with Auto Scaling

ALB works very well with **Auto Scaling Groups (ASG)**.

Example:

```text
                 ALB
              /   |   \
             ↓    ↓    ↓
           EC2  EC2  EC2
             ↑    ↑    ↑
             Auto Scaling
```

If traffic increases:

```text
More traffic
     ↓
Auto Scaling
     ↓
More EC2 instances
     ↓
Target Group
     ↓
ALB
```

New instances can automatically be registered with the target group.

If an instance becomes unhealthy, traffic can be stopped from reaching it.

---

# 🛡️ 18. High Availability with ALB

A good architecture uses multiple Availability Zones.

Example:

```text
                 Internet
                    ↓
                   ALB
               ↙         ↘
              ↓           ↓
           AZ-A          AZ-B
            ↓             ↓
          EC2-1         EC2-2
```

If one Availability Zone has a problem, traffic can continue through healthy resources in another AZ.

---

# 🆚 19. ALB vs NLB vs Gateway Load Balancer

AWS provides different types of Elastic Load Balancers.

| Load Balancer             | Layer            | Main Use                                    |
| ------------------------- | ---------------- | ------------------------------------------- |
| Application Load Balancer | Layer 7          | HTTP/HTTPS applications                     |
| Network Load Balancer     | Layer 4          | TCP/UDP/TLS and high-performance networking |
| Gateway Load Balancer     | Layer 3          | Network/security appliances                 |
| Classic Load Balancer     | Older generation | Legacy applications                         |

### Easy way to remember

```text
ALB → Application / HTTP / HTTPS
NLB → Network / TCP / UDP / TLS
GWLB → Security & network appliances
```

For modern web applications, **ALB** is usually the natural choice when you need Layer 7 HTTP/HTTPS routing.

---

# 🆚 20. ALB vs EC2

These are completely different things.

| ALB                      | EC2                            |
| ------------------------ | ------------------------------ |
| Distributes traffic      | Runs applications              |
| Receives client requests | Processes application requests |
| Performs health checks   | Hosts application              |
| Routes traffic           | Provides compute               |
| Can use target groups    | Can be a target                |

Example:

```text
ALB
 ↓
EC2
 ↓
Application
```

---

# 🧩 21. ALB and VPC

ALB works inside a VPC.

It interacts with several VPC components:

```text
VPC
│
├── Subnets
├── Route Tables
├── Internet Gateway
├── Security Groups
├── EC2
└── Application Load Balancer
```

For an internet-facing ALB, public subnets need appropriate routing to the Internet Gateway.

---

# 🧪 22. Simple Hands-on ALB Lab

You can build a simple ALB architecture using two EC2 instances.

### Architecture

```text
                 Internet
                    ↓
                  ALB
               ↙       ↘
              ↓         ↓
           EC2-1      EC2-2
           "Server 1" "Server 2"
```

### Step 1 — Launch Two EC2 Instances

Create:

```text
EC2-1
EC2-2
```

Install a simple web server on both.

For Amazon Linux:

```bash
sudo dnf install httpd -y
```

Start Apache:

```bash
sudo systemctl start httpd
sudo systemctl enable httpd
```

---

### Step 2 — Give Each Server Different Content

On EC2-1:

```bash
echo "Hello from Server 1" | sudo tee /var/www/html/index.html
```

On EC2-2:

```bash
echo "Hello from Server 2" | sudo tee /var/www/html/index.html
```

---

### Step 3 — Create Target Group

Create a target group:

```text
Target Type: Instances
Protocol: HTTP
Port: 80
```

Register:

```text
EC2-1
EC2-2
```

---

### Step 4 — Create Application Load Balancer

Create:

```text
Load Balancer Type:
Application Load Balancer
```

Choose:

```text
Scheme:
Internet-facing
```

Select appropriate VPC subnets across at least two Availability Zones.

---

### Step 5 — Configure Security Groups

ALB Security Group:

```text
Inbound:
HTTP : 80
```

EC2 Security Group:

```text
Inbound:
HTTP : 80
Source: ALB Security Group
```

---

### Step 6 — Create Listener

Configure:

```text
Listener:
HTTP : 80

Default Action:
Forward to Target Group
```

---

### Step 7 — Check Target Health

Go to:

```text
EC2
→ Target Groups
→ Targets
```

You should see:

```text
EC2-1 → Healthy ✅
EC2-2 → Healthy ✅
```

---

### Step 8 — Test the ALB

Copy the ALB DNS name.

It will look similar to:

```text
my-alb-123456789.ap-south-1.elb.amazonaws.com
```

Open it in your browser.

You should receive a response from one of the EC2 servers.

Refresh multiple times to observe traffic distribution.

---

# 🔍 23. ALB Troubleshooting

If the ALB is not working, check these areas.

### 1. Target Health

Check:

```text
Target Group
→ Targets
```

Are the targets:

```text
Healthy ✅
```

or:

```text
Unhealthy ❌
```

---

### 2. Application Running

On EC2:

```bash
sudo systemctl status httpd
```

---

### 3. Port Listening

Check:

```bash
sudo ss -tulnp
```

Make sure the application is listening on the expected port.

---

### 4. Security Groups

Check:

```text
Internet
   ↓
ALB SG
   ↓
EC2 SG
```

Make sure the EC2 security group allows traffic from the ALB security group.

---

### 5. Listener

Check that the listener is configured correctly:

```text
HTTP :80
       ↓
Target Group
```

---

### 6. Health Check Path

If your application uses:

```text
/
```

make sure the health check path is correct.

For example:

```text
Path: /
Port: Traffic Port
Protocol: HTTP
```

---

### 7. Network Configuration

Check:

* VPC
* Subnets
* Route tables
* Internet Gateway
* Security Groups
* Network ACLs

---

# 🛡️ 24. ALB Best Practices

### ✅ Use Multiple Availability Zones

Improve availability by deploying the ALB across multiple AZs.

### ✅ Use HTTPS

Use HTTPS for production applications.

### ✅ Restrict EC2 Access

Allow application traffic to EC2 from the ALB security group instead of `0.0.0.0/0`.

### ✅ Use Health Checks

Configure meaningful health check paths.

### ✅ Use Auto Scaling

Combine ALB with an Auto Scaling Group for scalable applications.

### ✅ Monitor the ALB

Use Amazon CloudWatch to monitor:

* Request count
* Target response time
* HTTP errors
* Target health
* 4xx errors
* 5xx errors

### ✅ Use Path/Host Routing Carefully

Use listener rules when multiple applications or services need to share an ALB.

---

# 🧠 25. Quick Revision

| Concept       | Meaning                            |
| ------------- | ---------------------------------- |
| ALB           | Layer 7 load balancer              |
| ELB           | AWS Elastic Load Balancing service |
| Listener      | Receives incoming connections      |
| Listener Rule | Decides how traffic is routed      |
| Target        | Backend resource receiving traffic |
| Target Group  | Group of backend targets           |
| Health Check  | Checks whether targets are healthy |
| Path Routing  | Routes based on URL path           |
| Host Routing  | Routes based on hostname           |
| ALB SG        | Controls traffic reaching ALB      |
| EC2 SG        | Controls traffic reaching EC2      |
| ACM           | Certificate management for TLS     |
| ALB + ASG     | Scalable application architecture  |

---

# ⭐ Remember This Architecture

```text
                         Internet
                            ↓
                     Application Load
                        Balancer
                            ↓
                    Listener : 80/443
                            ↓
                      Target Group
                     ↙            ↘
                    ↓              ↓
                 EC2-1           EC2-2
               Healthy ✅       Healthy ✅
                    ↓              ↓
                    Application
```

### Easy Memory Trick

```text
ALB
 ↓
Listener
 ↓
Rules
 ↓
Target Group
 ↓
Healthy Targets
```

> **ALB receives web traffic, checks the routing rules, and forwards requests to healthy targets.**
