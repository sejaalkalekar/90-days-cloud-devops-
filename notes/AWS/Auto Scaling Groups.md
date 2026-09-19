# 📈 AWS Auto Scaling Groups (ASG)

## 📖 Introduction

Imagine you have a web application running on one EC2 instance:

```text
Users
  ↓
EC2
```

If traffic increases significantly, the EC2 instance may become overloaded.

Instead of manually launching more EC2 instances, AWS can automatically add or remove instances based on your requirements.

This is where **Amazon EC2 Auto Scaling** comes in.

A major component of EC2 Auto Scaling is the:

> **Auto Scaling Group (ASG)**

An Auto Scaling Group automatically manages a group of EC2 instances and maintains the desired number of instances.

---

# 🧠 1. What is an Auto Scaling Group?

An **Auto Scaling Group (ASG)** is a collection of EC2 instances that AWS manages together.

The ASG can:

* Launch EC2 instances
* Terminate EC2 instances
* Replace unhealthy instances
* Increase instances when demand increases
* Decrease instances when demand decreases
* Maintain a desired number of instances

### Simple Example

Suppose your application normally needs 2 servers:

```text
ASG

EC2-1
EC2-2
```

If traffic increases:

```text
ASG

EC2-1
EC2-2
EC2-3
EC2-4
```

When traffic decreases:

```text
ASG

EC2-1
EC2-2
```

The ASG adjusts the number of instances automatically.

---

# 🎯 2. Why Do We Need Auto Scaling?

Without Auto Scaling:

```text
Traffic increases
      ↓
EC2 becomes overloaded
      ↓
Application becomes slow
      ↓
Engineer manually launches EC2
```

With Auto Scaling:

```text
Traffic increases
      ↓
CloudWatch detects increased load
      ↓
ASG launches more EC2
      ↓
Application handles more traffic
```

When traffic decreases:

```text
Traffic decreases
      ↓
ASG scales in
      ↓
Unused EC2 instances are removed
      ↓
Costs can be reduced
```

---

# 📊 3. Scaling Out vs Scaling In

There are two important terms.

## ➕ Scaling Out

Adding more EC2 instances.

```text
2 EC2
 ↓
4 EC2
```

This is called **horizontal scaling**.

---

## ➖ Scaling In

Removing EC2 instances.

```text
4 EC2
 ↓
2 EC2
```

Scaling in helps avoid paying for unnecessary compute capacity.

---

# ↕️ 4. Horizontal vs Vertical Scaling

### Horizontal Scaling

Add or remove instances:

```text
EC2 + EC2 + EC2
```

Example:

```text
2 instances → 4 instances
```

### Vertical Scaling

Increase the size of one instance:

```text
t3.small
   ↓
t3.large
```

### Easy Difference

| Scaling    | Meaning                         |
| ---------- | ------------------------------- |
| Horizontal | Add/remove instances            |
| Vertical   | Increase/decrease instance size |

Auto Scaling Groups primarily provide **horizontal scaling**.

---

# 🔢 5. Desired Capacity

**Desired capacity** is the number of EC2 instances the ASG tries to maintain under normal conditions.

Example:

```text
Desired Capacity = 2
```

The ASG attempts to keep:

```text
EC2-1
EC2-2
```

If one instance becomes unhealthy:

```text
EC2-1 → Healthy
EC2-2 → Unhealthy
```

The ASG can launch a replacement:

```text
EC2-1 → Healthy
EC2-3 → New
```

The desired capacity returns to 2.

---

# 📉 6. Minimum Capacity

**Minimum capacity** defines the smallest number of instances the ASG should maintain.

Example:

```text
Minimum = 2
```

The ASG should not normally scale below 2 instances.

Example:

```text
Minimum = 2
Desired = 2
Maximum = 5
```

The ASG can operate between:

```text
2 → 3 → 4 → 5
```

---

# 📈 7. Maximum Capacity

**Maximum capacity** defines the maximum number of instances the ASG can launch.

Example:

```text
Maximum = 5
```

Even if demand becomes very high, the ASG will not normally scale beyond the configured maximum.

Example:

```text
Minimum = 2
Desired = 2
Maximum = 5
```

Possible capacity:

```text
2
3
4
5
```

---

# 🧩 8. Minimum, Desired and Maximum

These three settings are extremely important.

Example:

```text
Minimum Capacity = 2
Desired Capacity = 2
Maximum Capacity = 5
```

Think of it like:

```text
Minimum                    Maximum
   ↓                           ↓
   2 ---- 3 ---- 4 ---- 5
          ↑
       Scaling
```

### Easy Memory Trick

```text
Minimum  → Lowest
Desired  → Normal
Maximum  → Highest
```

---

# 🖼️ 9. Launch Template

An ASG needs instructions for how new EC2 instances should be created.

A common way to provide these instructions is a **Launch Template**.

A Launch Template can define things such as:

* AMI
* Instance type
* Key pair
* Security groups
* Network settings
* IAM role
* User data
* Storage configuration

Example:

```text
Launch Template
       ↓
AMI
Instance Type
Security Group
IAM Role
User Data
       ↓
ASG
       ↓
EC2 Instances
```

When the ASG needs another instance, it uses the launch configuration information from the template.

---

# 🆚 10. Launch Template vs AMI

These are different.

### AMI

Provides the machine image:

```text
Operating System
+
Software
+
Configuration
```

### Launch Template

Provides instructions for launching an EC2 instance:

```text
AMI
+
Instance Type
+
Security Group
+
IAM Role
+
User Data
+
Other Settings
```

Think:

> **AMI = What is installed**

> **Launch Template = How to launch the server**

---

# 🌐 11. Auto Scaling Groups and Subnets

An ASG can launch instances across multiple Availability Zones.

Example:

```text
                 VPC
                  |
        ┌─────────┴─────────┐
        ↓                   ↓
       AZ-A                AZ-B
        ↓                   ↓
     Subnet A            Subnet B
        ↓                   ↓
      EC2-1               EC2-2
```

This improves availability.

If one Availability Zone has a problem, instances can continue operating in another AZ.

---

# ⚖️ 12. ASG with Application Load Balancer

ASG and ALB are commonly used together.

Architecture:

```text
                    Users
                      ↓
                     ALB
                  ↙       ↘
                 ↓         ↓
              EC2-1      EC2-2
                 ↑         ↑
                 └────┬────┘
                      ↓
                     ASG
```

The ALB distributes incoming traffic.

The ASG manages the number of EC2 instances.

### Simple Difference

```text
ALB → Distributes traffic

ASG → Manages EC2 capacity
```

Together:

```text
Users
  ↓
ALB
  ↓
Target Group
  ↓
ASG-managed EC2
```

---

# ❤️ 13. Auto Scaling and Health Checks

ASG can monitor the health of instances.

Suppose:

```text
EC2-1 → Healthy ✅
EC2-2 → Healthy ✅
EC2-3 → Unhealthy ❌
```

The ASG can terminate the unhealthy instance and launch a replacement.

Result:

```text
EC2-1 → Healthy ✅
EC2-2 → Healthy ✅
EC2-4 → New instance ✅
```

This helps maintain application availability.

---

# 📊 14. CloudWatch and Auto Scaling

Amazon CloudWatch provides metrics that can be used by scaling policies.

For example:

```text
EC2 CPU Utilization
        ↓
    CloudWatch
        ↓
Scaling Policy
        ↓
      ASG
```

Suppose CPU utilization becomes high:

```text
CPU > 70%
   ↓
Scale Out
   ↓
Launch EC2
```

When CPU utilization falls:

```text
CPU < 30%
   ↓
Scale In
   ↓
Remove EC2
```

The exact thresholds depend on the scaling policy you configure.

---

# 📏 15. Scaling Policies

Scaling policies tell the ASG **when and how to change capacity**.

Common approaches include:

### 15.1 Target Tracking Scaling

You specify a target value.

Example:

```text
Target CPU = 50%
```

The ASG automatically adjusts capacity to try to maintain the target.

Simple idea:

```text
CPU too high
    ↓
Add instances

CPU too low
    ↓
Remove instances
```

---

### 15.2 Step Scaling

The ASG changes capacity based on how much a metric crosses defined thresholds.

Example:

```text
CPU > 60%  → Add 1 instance
CPU > 80%  → Add 2 instances
```

The more demand increases, the more aggressively capacity can change.

---

### 15.3 Scheduled Scaling

Scaling can happen at a known time.

Example:

```text
9:00 AM
   ↓
Increase capacity

8:00 PM
   ↓
Decrease capacity
```

This is useful when traffic follows a predictable schedule.

---

# 🚀 16. Target Tracking Example

Suppose:

```text
Desired Capacity = 2
Target CPU = 50%
```

Current situation:

```text
EC2-1 → 80% CPU
EC2-2 → 75% CPU
```

The ASG detects that the target is being exceeded.

It may increase capacity:

```text
EC2-1
EC2-2
EC2-3
```

As workload is distributed, CPU utilization may decrease.

---

# 🕒 17. Cooldown and Instance Warm-Up

When an ASG launches an instance, the new instance needs time to start.

For example:

```text
Launch EC2
    ↓
Boot operating system
    ↓
Start application
    ↓
Become healthy
```

If scaling happens too quickly, AWS may launch more instances before the previous change has had time to take effect.

Auto Scaling provides mechanisms such as **instance warm-up** and other timing controls to help scaling decisions account for startup time.

---

# 🔄 18. Auto Scaling Lifecycle

A typical lifecycle looks like:

```text
Scaling Decision
      ↓
ASG launches EC2
      ↓
EC2 starts
      ↓
Application starts
      ↓
Health checks
      ↓
Instance becomes available
      ↓
ALB sends traffic
```

When scaling in:

```text
Scaling Decision
      ↓
Instance selected
      ↓
Instance removed from service
      ↓
Instance terminated
```

---

# 🧹 19. What Happens During Scale In?

Suppose:

```text
5 EC2 instances
```

are running and the ASG decides that only 3 are required.

It may terminate instances according to its configured termination behavior.

The capacity becomes:

```text
5
↓
4
↓
3
```

When an ALB is used, the instance is removed from serving traffic as part of the process before termination.

---

# 🏗️ 20. Common AWS Architecture

A typical production-style architecture can look like:

```text
                         Internet
                            ↓
                           ALB
                       ↙         ↘
                      ↓           ↓
                 Public Layer
                      ↓
             ┌────────┴────────┐
             ↓                 ↓
          Private AZ-A      Private AZ-B
             ↓                 ↓
           EC2-1             EC2-2
             ↑                 ↑
             └────── ASG ──────┘
                      ↓
                  Application
                      ↓
                     RDS
```

The ALB handles incoming traffic.

The ASG manages application EC2 capacity.

RDS can provide the database layer.

---

# 💰 21. Auto Scaling and Cost Optimization

Auto Scaling can help reduce unnecessary EC2 costs.

Example:

During the day:

```text
High traffic
     ↓
5 EC2
```

At night:

```text
Low traffic
     ↓
2 EC2
```

Instead of running 5 instances all day, the application can adjust capacity according to demand.

However, Auto Scaling itself does not automatically make every workload cheaper. Poorly configured scaling policies or excessive minimum capacity can still result in unnecessary costs.

---

# 🧪 22. Hands-on Lab — Build an Auto Scaling Group

For your AWS learning journey, a good beginner lab is:

```text
                    Internet
                       ↓
                      ALB
                       ↓
                 Target Group
                   ↙       ↘
                  ↓         ↓
               EC2-1      EC2-2
                  ↑         ↑
                  └────┬────┘
                       ↓
                      ASG
```

### Step 1 — Create a Launch Template

Create a launch template containing:

```text
AMI
Instance Type
Security Group
IAM Role
User Data
```

For example:

```text
Instance Type: t3.micro
```

---

### Step 2 — Create an Auto Scaling Group

Configure:

```text
Minimum: 2
Desired: 2
Maximum: 4
```

Choose the VPC and subnets across multiple Availability Zones.

---

### Step 3 — Attach a Target Group

Connect the ASG to the target group used by your ALB.

Architecture:

```text
ASG
 ↓
Target Group
 ↓
ALB
```

More commonly, conceptually:

```text
ALB
 ↓
Target Group
 ↓
ASG-managed EC2 instances
```

---

### Step 4 — Create a Scaling Policy

For example:

```text
Target Tracking
Target CPU Utilization = 50%
```

The ASG will adjust capacity based on the configured target.

---

### Step 5 — Verify Instances

Go to:

```text
EC2
→ Auto Scaling Groups
→ Your ASG
```

You should see:

```text
Desired: 2
Min: 2
Max: 4
```

And instances such as:

```text
EC2-1 → InService
EC2-2 → InService
```

---

### Step 6 — Test Scaling

Generate workload on an EC2 instance.

For example, in a Linux test environment:

```bash
yes > /dev/null &
```

Check CPU usage.

Stop the test workload:

```bash
pkill yes
```

Then observe CloudWatch and the ASG.

> Use this only as a temporary lab workload and stop it after testing.

---

# 🔍 23. Troubleshooting Auto Scaling

If the ASG is not launching instances, check:

### 1. Launch Template

Check:

* AMI
* Instance type
* Security group
* IAM role
* User data

### 2. Subnets

Make sure the selected subnets are correct and available.

### 3. Desired / Minimum / Maximum

Check:

```text
Minimum
Desired
Maximum
```

### 4. Scaling Policy

Check whether the scaling policy is actually being triggered.

### 5. CloudWatch Metrics

Check:

```text
CPUUtilization
```

and other metrics relevant to your policy.

### 6. Instance Health

Check whether instances are:

```text
InService
```

or being marked unhealthy.

### 7. Load Balancer Target Health

If using ALB:

```text
ALB
 ↓
Target Group
 ↓
Target Health
```

Check whether new instances are healthy.

### 8. Service Quotas

AWS account and Region limits can also affect how many resources can be launched.

---

# 🛡️ 24. Auto Scaling Best Practices

### ✅ Use Multiple Availability Zones

Deploy instances across multiple AZs.

### ✅ Use Launch Templates

Keep EC2 configuration consistent.

### ✅ Set Appropriate Minimum Capacity

Make sure the application has enough capacity for normal traffic.

### ✅ Set a Safe Maximum

Prevent unexpected scaling from creating excessive resource usage and costs.

### ✅ Use Target Tracking Where Appropriate

It provides a simple way to maintain a desired metric target.

### ✅ Combine ASG with ALB

Use ALB for traffic distribution and ASG for capacity management.

### ✅ Monitor with CloudWatch

Monitor:

* CPU
* Request count
* Instance health
* Scaling activities
* Application metrics

### ✅ Test Scaling

Do not assume scaling works just because the configuration exists. Test scale-out, scale-in, and unhealthy-instance replacement.

---

# 🆚 25. ALB vs Auto Scaling Group

These services have different responsibilities.

| ALB                           | Auto Scaling Group           |
| ----------------------------- | ---------------------------- |
| Distributes traffic           | Manages EC2 capacity         |
| Routes requests               | Launches instances           |
| Performs target health checks | Replaces unhealthy instances |
| Uses listeners                | Uses scaling policies        |
| Uses target groups            | Uses launch templates        |
| Handles traffic               | Handles capacity             |

### Easy Memory Trick

> **ALB decides where traffic goes.**

> **ASG decides how many servers should run.**

---

# 🆚 26. Auto Scaling Group vs EC2

| EC2                                    | ASG                                |
| -------------------------------------- | ---------------------------------- |
| Individual virtual server              | Group of EC2 instances             |
| Runs application                       | Manages instance fleet             |
| Can be launched manually               | Can automatically launch instances |
| Does not automatically scale by itself | Can scale based on policies        |
| One instance                           | Multiple instances                 |

---

# 🧠 27. Quick Revision

| Concept           | Meaning                                        |
| ----------------- | ---------------------------------------------- |
| ASG               | Automatically manages a group of EC2 instances |
| Scale Out         | Add instances                                  |
| Scale In          | Remove instances                               |
| Minimum           | Lowest configured capacity                     |
| Desired           | Normal target capacity                         |
| Maximum           | Highest configured capacity                    |
| Launch Template   | Instructions for launching EC2                 |
| Target Tracking   | Maintains a target metric                      |
| Step Scaling      | Changes capacity based on thresholds           |
| Scheduled Scaling | Scales at scheduled times                      |
| Health Check      | Detects unhealthy instances                    |
| CloudWatch        | Provides metrics used for monitoring/scaling   |
| ALB               | Distributes traffic to healthy targets         |

---

# ⭐ Remember This Architecture

```text
                         Users
                           ↓
                          ALB
                           ↓
                     Target Group
                     ↙          ↘
                    ↓            ↓
                 EC2-1         EC2-2
                    ↑            ↑
                    └──── ASG ───┘
                           ↓
                  Scaling Policies
                           ↓
                       CloudWatch
```

### The easiest way to remember:

```text
CloudWatch
    ↓
Scaling Policy
    ↓
ASG
    ↓
EC2 Instances
    ↑
    │
   ALB
    ↑
    │
  Users
```

> **CloudWatch provides metrics, scaling policies make scaling decisions, ASG manages EC2 capacity, and ALB distributes application traffic.**

