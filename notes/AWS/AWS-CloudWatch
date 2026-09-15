# 📊 AWS CloudWatch

## 📖 Introduction

**Amazon CloudWatch** is an AWS monitoring and observability service.

It helps you **monitor AWS resources, applications, and workloads**.

With CloudWatch, you can:

* 📊 Monitor resources
* 📈 View metrics
* 📝 Collect logs
* 🚨 Create alarms
* 🔔 Send notifications
* ⚙️ Automate actions
* 🔍 Troubleshoot problems

### Simple Example

Imagine you have an EC2 server.

You want to know:

```text
Is the server running?
Is CPU usage too high?
Is memory becoming a problem?
Are applications generating errors?
```

CloudWatch helps you monitor these things.

```text
EC2
 │
 ├── CPU Metrics
 ├── Network Metrics
 ├── Status Checks
 └── Logs
       ↓
   CloudWatch
       ↓
   Monitor & Alert
```

---

# 🧠 1. What is Amazon CloudWatch?

CloudWatch collects and monitors **metrics, logs, events, and other operational data** from AWS resources and applications.

Think of CloudWatch as a **monitoring dashboard for your AWS environment**.

Example:

```text
AWS Resources
     │
     ├── EC2
     ├── S3
     ├── RDS
     └── Lambda
            ↓
       CloudWatch
            ↓
     Metrics / Logs / Alarms
```

---

# 🎯 2. Why Do We Need CloudWatch?

Without monitoring, you may not know when something goes wrong.

For example:

```text
EC2 CPU Usage
      ↓
     95%
      ↓
CloudWatch Alarm
      ↓
Notification
      ↓
DevOps Engineer
```

CloudWatch helps you detect problems before they become bigger issues.

---

# 🧩 3. Main Components of CloudWatch

The important CloudWatch features to understand are:

```text
CloudWatch
│
├── Metrics
├── Logs
├── Alarms
├── Dashboards
├── Events / EventBridge
└── CloudWatch Agent
```

Let's understand each one.

---

# 📈 4. What are CloudWatch Metrics?

A **metric** is a numerical measurement collected over time.

Examples:

```text
CPUUtilization
NetworkIn
NetworkOut
DiskReadOps
DiskWriteOps
```

For an EC2 instance:

```text
CPU Usage

10%
20%
35%
50%
80%
95%
```

CloudWatch can display this information as graphs.

---

# 🖥️ 5. EC2 CloudWatch Metrics

EC2 automatically provides several metrics to CloudWatch.

Common examples include:

| Metric            | Meaning                       |
| ----------------- | ----------------------------- |
| CPUUtilization    | CPU usage                     |
| NetworkIn         | Data received                 |
| NetworkOut        | Data sent                     |
| DiskReadOps       | Disk read operations          |
| DiskWriteOps      | Disk write operations         |
| StatusCheckFailed | Instance/system check failure |

Example:

```text
EC2
 │
 ├── CPU → 75%
 ├── NetworkIn
 ├── NetworkOut
 └── Status Checks
        ↓
    CloudWatch
```

---

# 🧠 6. Basic vs Detailed Monitoring

EC2 can provide monitoring at different intervals depending on the monitoring configuration.

### Basic Monitoring

Metrics are generally available at **5-minute intervals** for many EC2 metrics.

### Detailed Monitoring

Metrics can be collected at **1-minute intervals**.

Detailed monitoring can provide more frequent data, but it may involve additional charges.

---

# 💡 7. What is a Namespace?

A **namespace** is a container that separates metrics from different AWS services or applications.

For example:

```text
AWS/EC2
AWS/S3
AWS/RDS
AWS/Lambda
```

EC2 metrics are available under:

```text
AWS/EC2
```

RDS metrics are available under:

```text
AWS/RDS
```

---

# 🏷️ 8. Dimensions

A **dimension** helps identify a specific metric.

For example, EC2 metrics can use:

```text
InstanceId
```

Example:

```text
Metric:
CPUUtilization

Dimension:
InstanceId = i-123456789
```

This allows CloudWatch to identify which EC2 instance the metric belongs to.

---

# 🚨 9. What is a CloudWatch Alarm?

A **CloudWatch Alarm** watches a metric and performs an action when a condition is met.

Example:

```text
CPUUtilization > 80%
        ↓
   CloudWatch Alarm
        ↓
       Alert
```

### Example

You can create an alarm:

```text
Metric:
CPUUtilization

Condition:
Greater than 80%

Period:
5 minutes
```

If the condition is met, the alarm can enter the **ALARM** state.

---

# 🔔 10. CloudWatch Alarm States

A CloudWatch alarm can have states such as:

```text
OK
ALARM
INSUFFICIENT_DATA
```

### OK

The metric is within the configured condition.

### ALARM

The configured threshold has been breached.

### INSUFFICIENT_DATA

CloudWatch does not have enough data to determine the state.

---

# 📢 11. CloudWatch and SNS

CloudWatch Alarms can send notifications through **Amazon SNS**.

Example:

```text
EC2 CPU > 80%
       ↓
CloudWatch Alarm
       ↓
Amazon SNS
       ↓
Notification
```

This allows the operations team to know that something needs attention.

---

# ⚙️ 12. CloudWatch and Auto Scaling

CloudWatch alarms can work with **EC2 Auto Scaling**.

Example:

```text
Average CPU > 70%
       ↓
CloudWatch Alarm
       ↓
Auto Scaling
       ↓
Launch additional EC2
```

When demand decreases:

```text
CPU < 30%
       ↓
CloudWatch
       ↓
Auto Scaling
       ↓
Reduce instances
```

This helps applications respond to changing workloads.

---

# 📝 13. What are CloudWatch Logs?

**CloudWatch Logs** stores and monitors log data.

Applications and AWS resources can send logs to CloudWatch Logs.

Example:

```text
Application
     ↓
Log File
     ↓
CloudWatch Logs
```

Logs can contain information such as:

```text
Application started
User login successful
Database connection failed
HTTP 500 error
```

---

# 📁 14. Log Groups

A **Log Group** is a container for related log streams.

Example:

```text
Log Group
│
└── /application/web
       │
       ├── Log Stream 1
       ├── Log Stream 2
       └── Log Stream 3
```

You can use a log group to organize logs from a particular application or service.

---

# 📄 15. Log Streams

A **Log Stream** is a sequence of log events from a particular source.

For example:

```text
Log Group
    ↓
/application/web

Log Streams
    ├── server-01
    ├── server-02
    └── server-03
```

---

# 🔍 16. Log Events

A **log event** is an individual entry in a log.

Example:

```text
2026-09-15 20:10:01
Application started
```

Another:

```text
2026-09-15 20:15:21
Database connection failed
```

---

# 🖥️ 17. CloudWatch Agent

The **CloudWatch Agent** can collect additional system-level metrics and logs from EC2 instances and on-premises servers.

For example:

```text
Linux Server
│
├── CPU
├── Memory
├── Disk
└── Logs
       ↓
CloudWatch Agent
       ↓
CloudWatch
```

This is useful because some information, such as **memory utilization**, is not provided as a standard EC2 metric by default.

---

# 💾 18. Memory Monitoring

Suppose your EC2 server has:

```text
Memory Usage = 90%
```

You may want CloudWatch to monitor it.

You can install and configure the CloudWatch Agent:

```text
EC2
 ↓
CloudWatch Agent
 ↓
Memory Metrics
 ↓
CloudWatch
```

Then you can create an alarm based on memory usage.

---

# 📊 19. CloudWatch Dashboards

A **CloudWatch Dashboard** allows you to display multiple metrics in one place.

Example:

```text
┌─────────────────────────────┐
│      Production Dashboard   │
├─────────────────────────────┤
│ CPU Usage        65%        │
│ Memory Usage     72%        │
│ Network In       2.4 GB     │
│ Network Out      1.8 GB     │
│ Error Count      12         │
└─────────────────────────────┘
```

Dashboards are useful for quickly checking the health of your infrastructure.

---

# 🔍 20. CloudWatch Logs Insights

**CloudWatch Logs Insights** allows you to search and analyze log data.

For example, you may want to find:

```text
500 errors
failed login attempts
database errors
specific IP addresses
```

Instead of manually reading thousands of log lines, you can query the logs.

Example query:

```text
fields @timestamp, @message
| filter @message like /ERROR/
| sort @timestamp desc
```

---

# ⚡ 21. CloudWatch and Lambda

AWS Lambda can automatically send logs to CloudWatch Logs.

Example:

```text
Lambda
  ↓
Function executes
  ↓
Logs
  ↓
CloudWatch Logs
```

This is very useful for troubleshooting Lambda functions.

---

# 🗄️ 22. CloudWatch and RDS

Amazon RDS provides monitoring metrics to CloudWatch.

Examples include:

```text
CPUUtilization
DatabaseConnections
FreeStorageSpace
ReadIOPS
WriteIOPS
```

Example:

```text
RDS
 ↓
DatabaseConnections
 ↓
CloudWatch
 ↓
Alarm
```

---

# 🪣 23. CloudWatch and S3

S3 can work with CloudWatch for monitoring certain S3 metrics and request/storage-related information.

Example:

```text
S3 Bucket
    ↓
Monitoring Data
    ↓
CloudWatch
```

For detailed object-level API activity, **AWS CloudTrail** is commonly used.

---

# 🔄 24. CloudWatch Events and EventBridge

AWS **EventBridge** is the successor to the older CloudWatch Events capability.

It can detect events and trigger actions.

Example:

```text
EC2 State Changes
       ↓
EventBridge
       ↓
Lambda
       ↓
Perform Action
```

For example:

```text
EC2 stopped
   ↓
EventBridge rule
   ↓
Lambda
   ↓
Send notification
```

---

# ⏰ 25. Scheduled Events

EventBridge can also trigger actions on a schedule.

Example:

```text
Every day at 10 PM
       ↓
EventBridge
       ↓
Lambda
       ↓
Perform task
```

This can be useful for scheduled automation.

---

# 🔐 26. CloudWatch Security

CloudWatch data should be protected using proper IAM permissions.

For example:

```text
DevOps Engineer
      ↓
IAM Role
      ↓
CloudWatch Permissions
      ↓
View Metrics / Logs
```

Follow the principle of **least privilege**.

---

# 💰 27. CloudWatch Costs

Some CloudWatch capabilities are included at no additional charge, while other features can incur charges.

Potential cost areas include:

* Custom metrics
* Detailed monitoring
* Log ingestion
* Log storage
* Logs Insights queries
* Dashboards
* Alarms
* API usage

### Best Practice

Do not keep unnecessary logs forever.

Use appropriate **log retention periods**.

For example:

```text
Development Logs
      ↓
Short Retention

Production Logs
      ↓
Longer Retention
```

Choose retention based on operational and compliance requirements.

---

# 🧪 28. Hands-on CloudWatch Lab

Let's create a simple EC2 monitoring setup.

### Step 1: Launch EC2

Launch an EC2 instance.

Example:

```text
Instance:
t3.micro
```

---

### Step 2: Open CloudWatch

Go to:

```text
AWS Console
 ↓
CloudWatch
```

---

### Step 3: View EC2 Metrics

Go to:

```text
CloudWatch
 ↓
Metrics
 ↓
All Metrics
 ↓
EC2
```

Select:

```text
CPUUtilization
```

Choose your EC2 instance.

---

### Step 4: Create an Alarm

Create an alarm for:

```text
Metric:
CPUUtilization

Condition:
Greater than 70%
```

Configure the required evaluation period.

---

### Step 5: Test the Alarm

Generate CPU load on your Linux server.

For example:

```bash
yes > /dev/null &
```

Check CPU usage.

When finished:

```bash
pkill yes
```

⚠️ Do not leave unnecessary CPU load running.

---

### Step 6: Check CloudWatch

Go back to:

```text
CloudWatch
 ↓
Alarms
```

You can observe the alarm transition when the configured condition is met.

---

# 🔍 29. Troubleshooting with CloudWatch

CloudWatch can help answer questions like:

### EC2 is slow

Check:

```text
CPUUtilization
Memory
Disk
Network
Logs
```

### Application is returning errors

Check:

```text
CloudWatch Logs
Logs Insights
Application metrics
```

### Database is slow

Check:

```text
RDS CPU
DatabaseConnections
Read/Write IOPS
FreeStorageSpace
```

---

# 🛠️ 30. Common CloudWatch Problems

### ❌ No Metrics Visible

Check:

```text
1. Correct AWS Region
2. Correct AWS resource
3. Metric namespace
4. Time range
5. Monitoring configuration
```

---

### ❌ Memory Metric Not Available

Remember:

> EC2 does not provide memory utilization as a standard metric by default.

Install and configure the **CloudWatch Agent**.

---

### ❌ Alarm Not Triggering

Check:

```text
1. Metric
2. Threshold
3. Evaluation period
4. Datapoints
5. Alarm state
6. Notification configuration
```

---

### ❌ Logs Are Not Appearing

Check:

```text
1. CloudWatch Agent configuration
2. IAM permissions
3. Log group
4. Log stream
5. Application log path
```

---

# 🆚 31. CloudWatch vs CloudTrail

These services are often confused.

| Feature           | CloudWatch                 | CloudTrail              |
| ----------------- | -------------------------- | ----------------------- |
| Main purpose      | Monitoring & observability | API activity & auditing |
| Metrics           | ✅                          | ❌                       |
| Logs              | ✅                          | ✅                       |
| Alarms            | ✅                          | ❌                       |
| API activity      | Limited/context-dependent  | ✅                       |
| Troubleshooting   | ✅                          | ✅                       |
| Security auditing | Supporting role            | ✅                       |

### Easy Way to Remember

```text
CloudWatch → "Is my system healthy?"

CloudTrail → "Who did what in AWS?"
```

---

# 🆚 32. CloudWatch vs AWS Config

| Feature                        | CloudWatch | AWS Config |
| ------------------------------ | ---------- | ---------- |
| Monitoring                     | ✅          | ❌          |
| Metrics                        | ✅          | ❌          |
| Logs                           | ✅          | ❌          |
| Alarms                         | ✅          | ❌          |
| Resource configuration history | ❌          | ✅          |
| Configuration compliance       | ❌          | ✅          |

### Easy Way to Remember

```text
CloudWatch → Monitor
CloudTrail  → Audit
Config      → Configuration & Compliance
```

---

# 🧠 33. CloudWatch in a DevOps Environment

CloudWatch is commonly used throughout the DevOps lifecycle.

```text
                AWS Infrastructure
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
       EC2            RDS            Lambda
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                  CloudWatch
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
     Metrics          Logs          Alarms
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                   DevOps Team
```

It helps DevOps engineers:

* Monitor infrastructure
* Detect failures
* Troubleshoot applications
* Create alerts
* Track performance
* Automate responses

---

# 🛡️ 34. CloudWatch Best Practices

### 📊 1. Monitor important resources

Monitor production EC2, RDS, Lambda, and other critical services.

### 🚨 2. Create meaningful alarms

Don't create unnecessary alarms for every metric.

### 📝 3. Set log retention

Avoid storing logs forever unless required.

### 🔐 4. Use IAM least privilege

Give users only the CloudWatch permissions they need.

### 📈 5. Create useful dashboards

Keep important production metrics visible in one place.

### 🔍 6. Use Logs Insights

Use queries to quickly investigate application problems.

### 🧹 7. Monitor costs

Large amounts of logs, custom metrics, and queries can increase costs.

---

# 🧠 35. Quick Revision

| Term             | Simple Meaning                              |
| ---------------- | ------------------------------------------- |
| CloudWatch       | AWS monitoring and observability service    |
| Metric           | Numerical measurement                       |
| Namespace        | Container/group for metrics                 |
| Dimension        | Identifies a metric source                  |
| Alarm            | Watches a metric and reacts to conditions   |
| Log Group        | Container for related logs                  |
| Log Stream       | Sequence of log events                      |
| Log Event        | Individual log entry                        |
| CloudWatch Agent | Collects additional system metrics/logs     |
| Dashboard        | Visual monitoring screen                    |
| Logs Insights    | Query and analyze logs                      |
| EventBridge      | Event-driven automation service             |
| SNS              | Notification service often used with alarms |

---

# ⭐ Remember These 5 Things

```text
CloudWatch
│
├── 📈 Metrics
│      ↓
│   Monitor performance
│
├── 📝 Logs
│      ↓
│   Troubleshoot applications
│
├── 🚨 Alarms
│      ↓
│   Detect problems
│
├── 📊 Dashboards
│      ↓
│   Visualize monitoring data
│
└── ⚙️ Automation
       ↓
    Trigger actions
```

### Most Important Concept

> **CloudWatch helps you monitor what is happening inside your AWS environment.**

Remember:

```text
Metrics   → What is happening?
Logs      → What happened?
Alarms    → Is something wrong?
Dashboard → What is the overall health?
Agent     → Collect additional system data
```

