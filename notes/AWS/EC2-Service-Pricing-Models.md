# 💰 EC2 Pricing Models

## 📖 Introduction

AWS gives you different ways to pay for EC2 instances.

The right pricing model depends on:

* How long you need the server
* Whether your workload is predictable
* Whether your application can handle interruption
* Whether you need dedicated hardware

The main EC2 pricing options are:

```text
1. On-Demand
2. Reserved Instances
3. Savings Plans
4. Spot Instances
5. Dedicated Hosts
6. Dedicated Instances
```

---

# 💵 1. On-Demand Instances

**On-Demand** means you pay for the EC2 resources you use without making a long-term commitment.

### Simple Example

```text
Launch EC2
    ↓
Use EC2
    ↓
Pay for usage
```

You can use the instance when you need it and stop or terminate it when you don't.

### Best For

* Beginners
* Learning
* Testing
* Development
* Short-term projects
* Unpredictable workloads

### Advantages

* No long-term commitment
* Easy to use
* Flexible
* Good for temporary workloads

### Disadvantage

It can be more expensive for applications that run continuously for a long time.

---

# 📅 2. Reserved Instances

**Reserved Instances (RIs)** provide a discount when you commit to eligible EC2 usage for a longer period.

Common terms include:

```text
1 year
3 years
```

### Best For

Applications that:

* Run continuously
* Have predictable usage
* Need EC2 for a long period

### Example

Suppose a company runs a production server 24/7.

Instead of using On-Demand pricing for the entire period, the company can consider a Reserved Instance to reduce the cost.

### Advantages

* Lower cost for predictable workloads
* Good for long-running applications

### Disadvantages

* Requires a commitment
* Less flexible than On-Demand

---

# 💡 3. Savings Plans

**Savings Plans** provide discounted pricing when you commit to a certain amount of eligible compute usage for a specific period.

Common commitment terms include:

```text
1 year
3 years
```

Savings Plans are generally more flexible than Reserved Instances.

### Types of Savings Plans

### Compute Savings Plans

These provide more flexibility across eligible compute services and usage.

### EC2 Instance Savings Plans

These provide savings when you commit to a specific EC2 instance family in a specific AWS Region.

### Best For

* Long-term workloads
* Predictable compute usage
* Companies looking to reduce compute costs

---

# ⚡ 4. Spot Instances

**Spot Instances** allow you to use AWS spare EC2 capacity at potentially large discounts compared with On-Demand pricing.

However, AWS can interrupt Spot Instances when the capacity is needed.

```text
Spot Capacity Available
        ↓
    EC2 Running
        ↓
AWS Needs Capacity
        ↓
Instance May Be Interrupted
```

### Best For

Workloads that can handle interruptions.

Examples:

* Batch processing
* Data processing
* Testing
* Some CI/CD workloads
* Fault-tolerant applications

### Not Suitable For

Applications that:

* Cannot tolerate interruption
* Require continuous availability
* Cannot restart or recover easily

### Important

Spot Instances are cheap, but your application must be designed to handle interruptions.

---

# 🖥️ 5. Dedicated Hosts

A **Dedicated Host** is a physical server dedicated to your AWS account.

You get more visibility and control over the physical host.

### Simple Example

```text
AWS Physical Server
        ↓
Dedicated Host
        ↓
Your EC2 Instances
```

### Best For

* Specific software licensing requirements
* Dedicated hardware requirements
* Certain enterprise workloads

Dedicated Hosts are generally more expensive than normal EC2 options.

---

# 🖥️ 6. Dedicated Instances

**Dedicated Instances** run on hardware dedicated to a single AWS customer.

However, you don't get the same level of physical host visibility and control that Dedicated Hosts provide.

### Simple Difference

```text
Dedicated Instance
→ Dedicated hardware
→ Less host-level control

Dedicated Host
→ Dedicated physical server
→ More visibility and control
```

---

# 🔄 EC2 Pricing Models Comparison

| Pricing Model       | Commitment | Cost                 | Best For                        |
| ------------------- | ---------- | -------------------- | ------------------------------- |
| On-Demand           | No         | Higher               | Short-term / flexible workloads |
| Reserved Instances  | Long-term  | Lower                | Predictable workloads           |
| Savings Plans       | Long-term  | Lower                | Predictable compute usage       |
| Spot                | No         | Very low/potentially | Interruptible workloads         |
| Dedicated Hosts     | Depends    | High                 | Dedicated hardware / licensing  |
| Dedicated Instances | No         | Higher               | Dedicated tenancy               |

---

# 🧠 Which Pricing Model Should I Choose?

Think about it this way:

### Need flexibility?

```text
On-Demand
```

### Running a predictable workload for a long time?

```text
Reserved Instances
       OR
Savings Plans
```

### Can your application handle interruption?

```text
Spot Instances
```

### Need dedicated physical hardware?

```text
Dedicated Host
       OR
Dedicated Instance
```

---

# 💼 Real-World Examples

## Example 1 — Learning EC2

You are learning AWS and create an EC2 instance for a few hours.

```text
Best Choice → On-Demand
```

Why?

You don't need a long-term commitment.

---

## Example 2 — Production Server

A company has a production application that runs 24/7 and has predictable usage.

```text
Possible Choice → Savings Plans / Reserved Instances
```

Why?

The workload is predictable and long-term.

---

## Example 3 — Batch Processing

A company processes large amounts of data, and the job can be interrupted and restarted.

```text
Possible Choice → Spot Instances
```

Why?

The workload can tolerate interruption.

---

## Example 4 — Special Licensing Requirement

A company needs dedicated physical hardware because of its software licensing requirements.

```text
Possible Choice → Dedicated Host
```

---

# 💰 EC2 Cost Optimization

Choosing the correct pricing model is only one part of reducing EC2 costs.

You should also:

### 1. Choose the right instance size

Don't use a large instance if a smaller instance is enough.

```text
Over-sized EC2
      ↓
Higher Cost
```

---

### 2. Stop unused instances

For development and testing environments:

```text
Not needed
    ↓
Stop EC2
    ↓
Reduce compute cost
```

---

### 3. Terminate unused resources

Delete EC2 instances and related resources that are no longer required.

---

### 4. Monitor your costs

Use AWS tools such as:

* AWS Cost Explorer
* AWS Budgets

to understand and monitor your AWS spending.

---

### 5. Use Spot when appropriate

If a workload can tolerate interruption, Spot Instances can significantly reduce compute costs.

---

# ⚠️ Important Cost Considerations

The EC2 instance price is not necessarily your **entire AWS bill**.

You may also have charges related to resources such as:

* EBS storage
* Elastic IP addresses
* Data transfer
* NAT Gateway
* Load Balancer
* CloudWatch
* Other AWS services

Always check the pricing for the complete architecture.

---

# 🧠 Quick Revision

| Term               | Meaning                                               |
| ------------------ | ----------------------------------------------------- |
| On-Demand          | Pay for EC2 without long-term commitment              |
| Reserved Instance  | Discount for eligible long-term EC2 usage             |
| Savings Plans      | Discount for committed compute usage                  |
| Spot Instance      | Use spare EC2 capacity at potentially large discounts |
| Dedicated Host     | Physical server dedicated to your AWS account         |
| Dedicated Instance | EC2 running on hardware dedicated to your AWS account |

---

# ⭐ Best Practices

* Use **On-Demand** when flexibility is important.
* Use **Savings Plans** or **Reserved Instances** for predictable long-term workloads.
* Use **Spot Instances** for workloads that can tolerate interruption.
* Don't use Spot for workloads that cannot handle interruption.
* Choose the correct EC2 instance size.
* Stop unused development instances.
* Monitor AWS costs regularly.
* Check all related AWS resources, not just EC2 instance costs.

