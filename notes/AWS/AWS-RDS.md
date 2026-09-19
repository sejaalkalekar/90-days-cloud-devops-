# Amazon RDS

## 1. What is Amazon RDS?

**Amazon RDS (Relational Database Service)** is a managed database service provided by AWS.

It makes it easier to **set up, operate, and scale relational databases** in the cloud.

With a traditional database server, you may need to manage:

* Server setup
* Operating system
* Database installation
* Software updates
* Backups
* Storage
* High availability
* Monitoring

With RDS, AWS manages many of these infrastructure and database administration tasks.

You mainly focus on:

> **Your database, data, users, queries, and application.**

---

# 2. What is a Relational Database?

A relational database stores data in **tables** consisting of rows and columns.

Example:

```text
Users Table

+----+----------+-------------------+
| ID | Name     | Email             |
+----+----------+-------------------+
| 1  | Sejal    | sejal@example.com |
| 2  | Rahul    | rahul@example.com |
+----+----------+-------------------+
```

Relational databases use **SQL (Structured Query Language)** to work with data.

For example:

```sql
SELECT * FROM users;
```

---

# 3. Supported Database Engines

Amazon RDS supports several popular relational database engines.

Common options include:

* MySQL
* PostgreSQL
* MariaDB
* Oracle
* Microsoft SQL Server
* Amazon Aurora

The exact features, versions, and availability can vary by AWS Region.

---

# 4. Why Use Amazon RDS?

RDS is useful because AWS handles many common database infrastructure tasks.

Some benefits include:

* Managed database infrastructure
* Automated backups
* Database monitoring
* Easy scaling
* High availability options
* Security controls
* Multiple database engine choices

Instead of installing a database manually on an EC2 instance, you can create an RDS database through AWS.

---

# 5. RDS vs Database on EC2

You can run a database in two common ways:

### Database on EC2

```text
EC2 Instance
     ↓
Operating System
     ↓
Install Database
     ↓
Configure & Manage Database
```

You are responsible for much of the infrastructure management.

### Amazon RDS

```text
Amazon RDS
     ↓
AWS Managed Infrastructure
     ↓
Database
```

AWS manages much of the underlying infrastructure.

### Simple Comparison

| Feature               | RDS             | Database on EC2    |
| --------------------- | --------------- | ------------------ |
| Infrastructure        | AWS managed     | User managed       |
| OS management         | AWS managed     | User managed       |
| Database installation | AWS managed     | User managed       |
| Backups               | Managed options | Configure yourself |
| Scaling               | Easier          | More manual        |
| Customization         | More limited    | More control       |
| Administration effort | Lower           | Higher             |

---

# 6. RDS Architecture

A simple RDS architecture looks like:

```text
User
  ↓
Application
  ↓
Amazon RDS
  ↓
Relational Database
```

For example:

```text
EC2 Application
      ↓
Security Group
      ↓
Amazon RDS
      ↓
MySQL Database
```

The application connects to RDS using the database endpoint.

---

# 7. RDS Endpoint

When you create an RDS database, AWS provides a **DNS endpoint**.

Example:

```text
mydb.xxxxxxxxxxxx.ap-south-1.rds.amazonaws.com
```

Applications use this endpoint to connect to the database.

Example:

```text
Application
     ↓
RDS Endpoint
     ↓
MySQL / PostgreSQL
```

The endpoint is preferred over relying on a database instance's IP address.

---

# 8. RDS Port

Different database engines use different default ports.

| Database             | Default Port |
| -------------------- | -----------: |
| MySQL                |         3306 |
| PostgreSQL           |         5432 |
| MariaDB              |         3306 |
| Microsoft SQL Server |         1433 |
| Oracle               |         1521 |

For example, a MySQL application may connect using:

```text
RDS Endpoint : 3306
```

---

# 9. RDS Security Groups

RDS uses **Security Groups** to control network access.

Example:

```text
EC2
 |
 | TCP 3306
 ↓
RDS Security Group
 |
 ↓
RDS MySQL
```

A common secure configuration is:

```text
Source:
EC2 Security Group

Protocol:
TCP

Port:
3306
```

This allows the application server to connect to MySQL without allowing everyone on the internet to access the database.

### Important:

Avoid exposing a database directly to the public internet unless there is a specific requirement and appropriate security controls.

---

# 10. RDS Subnets

RDS databases are deployed within an AWS **VPC**.

RDS uses a **DB subnet group** to determine which subnets the database can use.

A DB subnet group normally contains subnets from multiple Availability Zones.

Example:

```text
VPC
│
├── Private Subnet - AZ1
│       ↓
│     RDS
│
└── Private Subnet - AZ2
        ↓
      RDS
```

For production architectures, databases are commonly placed in private subnets.

---

# 11. DB Subnet Group

A **DB subnet group** is a collection of subnets used by RDS.

For high availability, it should include subnets in **multiple Availability Zones**.

Example:

```text
DB Subnet Group

├── Private Subnet - AZ1
└── Private Subnet - AZ2
```

RDS can use these subnets when placing database resources.

---

# 12. RDS Storage

RDS databases use persistent storage.

Common storage options include:

* General Purpose SSD
* Provisioned IOPS SSD

Storage choice depends on workload requirements.

Consider:

* Database size
* I/O requirements
* Performance
* Cost

---

# 13. Storage Autoscaling

RDS can automatically increase storage capacity when the database needs more space, when storage autoscaling is configured.

Example:

```text
Initial Storage
      ↓
Database grows
      ↓
Storage approaches threshold
      ↓
RDS increases storage
```

This can help reduce the need to manually increase storage capacity.

---

# 14. RDS Automated Backups

RDS supports **automated backups**.

Automated backups can include:

* Database snapshots
* Transaction logs

These help support **point-in-time recovery**.

Example:

```text
Database
   ↓
Automated Backup
   ↓
Restore to a specific point in time
```

The backup retention period can be configured within the supported range.

---

# 15. RDS Snapshots

A **DB snapshot** is a point-in-time backup of an RDS database.

You can create a snapshot manually.

Example:

```text
RDS Database
     ↓
Manual Snapshot
     ↓
Stored Snapshot
```

Snapshots can be useful before:

* Major database changes
* Testing
* Migrations
* Deleting a database
* Making significant configuration changes

---

# 16. Automated Backups vs Snapshots

| Feature                | Automated Backup     | Manual Snapshot         |
| ---------------------- | -------------------- | ----------------------- |
| Purpose                | Backup & recovery    | Long-term/manual backup |
| Point-in-time recovery | Yes                  | No                      |
| Created                | Automatically        | Manually                |
| Retention              | Configurable         | Kept until deleted      |
| Use case               | Operational recovery | Long-term backup        |

---

# 17. Multi-AZ

**Multi-AZ** improves database availability.

With Multi-AZ enabled, RDS maintains a standby database in another Availability Zone for supported configurations.

Simplified architecture:

```text
              Application
                   ↓
             RDS Database
              /        \
             /          \
        AZ-1              AZ-2
      Primary           Standby
```

The standby is primarily for **high availability and failover**, not for serving normal read traffic.

If the primary database becomes unavailable, RDS can perform a failover.

---

# 18. Read Replicas

A **Read Replica** is a separate database instance that receives replicated data and can be used to handle read traffic.

Example:

```text
             Application
                 ↓
          ┌──────┴──────┐
          ↓             ↓
       Primary       Read Replica
          ↓             ↓
       Writes          Reads
```

Read replicas can help when an application has a large number of read operations.

### Important Difference

**Multi-AZ:**

> Mainly for high availability and failover.

**Read Replica:**

> Mainly for read scaling.

---

# 19. Multi-AZ vs Read Replica

| Feature              | Multi-AZ                                 | Read Replica            |
| -------------------- | ---------------------------------------- | ----------------------- |
| Main purpose         | High availability                        | Read scaling            |
| Failover             | Yes                                      | Not the primary purpose |
| Handles read traffic | Standby generally doesn't                | Yes                     |
| Typical use          | Production HA                            | Heavy read workloads    |
| Replication          | Synchronous for supported configurations | Asynchronous            |

---

# 20. RDS Read Replicas

Read replicas are useful when applications perform many read operations.

Example:

```text
                 Application
                      |
            ┌─────────┴─────────┐
            ↓                   ↓
       Write Requests      Read Requests
            ↓                   ↓
         Primary          Read Replica
```

A read replica can be created in the same Region or, for supported configurations, in another Region.

---

# 21. RDS Scaling

RDS supports different types of scaling.

### Vertical Scaling

Increase the database instance size.

```text
Small Instance
     ↓
Larger Instance
```

This provides more CPU and memory capacity.

### Storage Scaling

Increase database storage capacity.

```text
100 GB
 ↓
200 GB
```

### Read Scaling

Use read replicas to distribute read traffic.

```text
Primary
   ↓
Read Replica 1
Read Replica 2
```

---

# 22. RDS Encryption

RDS supports encryption at rest using **AWS Key Management Service (AWS KMS)**.

Encryption can protect:

* Database storage
* Automated backups
* Read replicas
* Snapshots

Example:

```text
Application
     ↓
Encrypted RDS
     ↓
Encrypted Storage
```

For secure applications, encryption should be considered as part of the database security design.

---

# 23. RDS IAM Authentication

Some RDS database engines support **IAM database authentication**.

Instead of relying only on a traditional database password, applications can use AWS IAM credentials/tokens for authentication where supported.

This can help reduce the need to manage long-lived database passwords.

---

# 24. RDS Monitoring

RDS integrates with **Amazon CloudWatch**.

You can monitor metrics such as:

* CPU utilization
* Database connections
* Free storage space
* Read operations
* Write operations
* Network traffic

Example:

```text
RDS
 ↓
CloudWatch
 ↓
Metrics
 ↓
Monitoring / Alarms
```

---

# 25. Enhanced Monitoring

RDS also provides **Enhanced Monitoring** for supported configurations.

It provides more detailed operating-system-level metrics about the database instance.

This can help with deeper performance troubleshooting.

---

# 26. RDS Performance Insights

**Performance Insights** helps analyze database performance and identify database load.

It can help you understand:

* Which database operations are consuming resources
* Database load
* Performance bottlenecks

This is useful when investigating slow database performance.

---

# 27. RDS Maintenance

AWS periodically performs maintenance for RDS.

Maintenance can include:

* Database engine updates
* Security patches
* Infrastructure maintenance

You can configure a **maintenance window** to specify a preferred time for maintenance activities.

---

# 28. RDS Parameter Groups

A **DB parameter group** contains database engine configuration settings.

For example, it can control database parameters related to:

* Connections
* Memory
* Logging
* Engine behavior

You can create or modify parameter groups based on your database requirements.

---

# 29. RDS Option Groups

An **option group** is used to enable additional features for supported RDS database engines.

It is primarily relevant to certain database engines, especially where optional database features need to be configured.

---

# 30. RDS Secrets

Database credentials should be handled securely.

Instead of hardcoding passwords inside application code, you can use services such as:

**AWS Secrets Manager**

Example:

```text
Application
     ↓
Secrets Manager
     ↓
Database Credentials
     ↓
RDS
```

This is safer than storing database passwords directly in source code.

---

# 31. RDS Security Best Practices

Some important practices include:

### 1. Use Private Subnets

Keep databases private when they don't need direct internet access.

### 2. Restrict Security Groups

Allow database access only from required application resources.

Example:

```text
EC2 Security Group
        ↓
   TCP 3306
        ↓
RDS Security Group
```

### 3. Enable Encryption

Use encryption for sensitive data.

### 4. Enable Backups

Configure automated backups and appropriate retention.

### 5. Use Multi-AZ for High Availability

For production workloads that require higher availability, consider Multi-AZ.

### 6. Monitor the Database

Use CloudWatch and appropriate RDS monitoring tools.

### 7. Protect Credentials

Use Secrets Manager or another secure credential-management approach.

---

# 32. RDS vs Aurora

Both are AWS managed relational database services.

| Feature     | RDS                                                    | Aurora                                  |
| ----------- | ------------------------------------------------------ | --------------------------------------- |
| Service     | Managed relational database service                    | AWS relational database engine          |
| Engines     | MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, Aurora | MySQL-compatible, PostgreSQL-compatible |
| Management  | AWS managed                                            | AWS managed                             |
| Scalability | Depends on engine/configuration                        | Designed for cloud scalability          |
| Use case    | General relational databases                           | Cloud-optimized workloads               |

**Amazon Aurora** is an AWS-designed relational database engine compatible with MySQL and PostgreSQL.

---

# 33. Simple RDS Architecture

A common architecture can look like:

```text
                    Internet
                       ↓
                Application Load
                   Balancer
                       ↓
                 EC2 Instances
                       ↓
                RDS Security Group
                       ↓
                 Amazon RDS
                  /        \
                 /          \
              AZ-1          AZ-2
            Primary        Standby
```

The application servers communicate with RDS over the required database port.

---

# 34. Example: Web Application with RDS

Imagine an online shopping application.

```text
User
 ↓
Application Load Balancer
 ↓
EC2 / Application Servers
 ↓
Amazon RDS
 ↓
Products / Users / Orders
```

The application can use RDS to store:

* User accounts
* Product information
* Orders
* Payments-related records
* Application data

---

# 35. Common RDS Interview Questions

### Q1. What is Amazon RDS?

Amazon RDS is a managed AWS service for running relational databases.

### Q2. What database engines does RDS support?

Common engines include MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, and Amazon Aurora.

### Q3. What is Multi-AZ?

Multi-AZ provides high availability by maintaining a standby database in another Availability Zone for supported configurations.

### Q4. What is a Read Replica?

A Read Replica is a database replica that can be used to handle read traffic and scale read-heavy workloads.

### Q5. Difference between Multi-AZ and Read Replica?

Multi-AZ is mainly for **high availability and failover**, while Read Replicas are mainly for **read scaling**.

### Q6. What is an RDS endpoint?

It is the DNS address used by applications to connect to the RDS database.

### Q7. What is a DB subnet group?

It is a collection of subnets in a VPC that RDS can use for database deployment.

### Q8. How do you secure an RDS database?

Use private subnets where appropriate, restrictive security groups, encryption, IAM/Secrets Manager where supported, backups, and monitoring.

### Q9. Can RDS be accessed from the internet?

It can be configured for public accessibility, but databases should generally not be exposed publicly unless there is a specific requirement and appropriate security controls.

### Q10. Does RDS eliminate all database administration?

No. AWS manages much of the underlying infrastructure, but you are still responsible for database configuration, schema, users, queries, data, and application-level database management.

---

# 36. Important RDS Terms

| Term                 | Meaning                                 |
| -------------------- | --------------------------------------- |
| RDS                  | Managed relational database service     |
| DB Instance          | Managed database environment            |
| DB Engine            | MySQL, PostgreSQL, etc.                 |
| Endpoint             | DNS address used to connect to RDS      |
| DB Subnet Group      | Subnets used for RDS deployment         |
| Multi-AZ             | High availability and failover          |
| Read Replica         | Replica used mainly for read scaling    |
| Snapshot             | Point-in-time database backup           |
| Automated Backup     | Automated backup and recovery mechanism |
| Parameter Group      | Database configuration settings         |
| Option Group         | Optional engine features                |
| Security Group       | Controls network access                 |
| KMS                  | AWS service used for encryption keys    |
| CloudWatch           | Monitoring service                      |
| Performance Insights | Database performance analysis           |

---

# 37. Key Takeaways

* **Amazon RDS is a managed relational database service.**
* AWS manages much of the underlying database infrastructure.
* RDS supports multiple database engines.
* RDS databases run inside a **VPC**.
* Security Groups control network access.
* DB subnet groups define eligible subnets.
* **Multi-AZ** is mainly used for high availability and failover.
* **Read Replicas** are mainly used for read scaling.
* Automated backups support recovery.
* Snapshots provide point-in-time copies.
* CloudWatch helps monitor RDS.
* Encryption can protect data at rest.
* Secrets Manager can help securely manage database credentials.
* RDS reduces infrastructure administration compared with running a database directly on EC2.

### In one line:

> **Amazon RDS lets you run relational databases on AWS while AWS manages much of the underlying database infrastructure.**
