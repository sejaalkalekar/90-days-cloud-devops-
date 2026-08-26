# 📚 AWS Cloud Fundamentals

> A beginner-friendly guide to understanding cloud computing, AWS, its core services, infrastructure, networking, security, scalability, monitoring, and cost management.

---

# 1. What is Cloud Computing?

**Cloud computing** means using computing resources over the internet instead of buying and maintaining all the physical infrastructure yourself.

These resources can include:

* Servers
* Storage
* Databases
* Networking
* Applications
* Security
* Monitoring

### Simple Example

Suppose you want to host a website.

### Traditional approach

You would need to:

```text
Buy Server
    ↓
Install Operating System
    ↓
Configure Network
    ↓
Install Application
    ↓
Maintain Hardware
```

### Cloud approach

You can use a cloud provider:

```text
Choose Cloud Service
        ↓
Create Resource
        ↓
Deploy Application
        ↓
Pay for Usage
```

Instead of purchasing a physical server, you can create a virtual server in AWS using **EC2**.

---

# 2. Why Cloud Computing?

Cloud computing provides several benefits.

## Scalability

You can increase or decrease resources according to workload.

Example:

```text
Normal Traffic → 2 Servers

High Traffic → 5 Servers
```

---

## Cost Efficiency

You don't necessarily need to purchase expensive hardware upfront.

Cloud providers generally use usage-based pricing for many services.

---

## Flexibility

You can create and configure resources based on your requirements.

---

## High Availability

Cloud architectures can use multiple Availability Zones and redundant resources to reduce downtime.

---

## Global Reach

Cloud providers have infrastructure in different geographical locations.

This allows applications to be deployed closer to users.

---

## Automation

Cloud resources can be created and managed using:

* CLI
* APIs
* Infrastructure as Code
* Automation tools

---

# 3. Traditional IT vs Cloud

| Traditional IT              | Cloud                                               |
| --------------------------- | --------------------------------------------------- |
| Buy physical servers        | Provision cloud resources                           |
| Large upfront cost          | Usage-based pricing for many services               |
| Manual hardware maintenance | Provider manages underlying infrastructure          |
| Scaling can take time       | Resources can often be scaled quickly               |
| Limited physical capacity   | Flexible capacity                                   |
| Data center management      | Cloud provider operates the physical infrastructure |

### Simple Difference

**Traditional IT:**

> Buy infrastructure first, then use it.

**Cloud:**

> Provision the infrastructure you need, when you need it.

---

# 4. Cloud Computing Characteristics

Important characteristics include:

### On-Demand

Resources can be provisioned when needed.

### Resource Pooling

Cloud providers share large pools of computing resources across customers using isolation and virtualization technologies.

### Rapid Elasticity

Resources can be increased or decreased quickly.

### Measured Usage

Usage can be monitored and billed according to the pricing model of the service.

### Broad Network Access

Cloud resources are generally accessible over networks using appropriate authentication and security controls.

---

# 5. Cloud Service Models

Cloud services are commonly divided into:

* IaaS
* PaaS
* SaaS

---

## IaaS — Infrastructure as a Service

You receive infrastructure such as:

* Virtual machines
* Storage
* Networking

You manage more of the operating environment.

### Example

**Amazon EC2**

```text
AWS
│
├── Physical Hardware
├── Networking
└── Virtualization
        │
        ▼
      EC2
        │
        ▼
 You manage OS + Application
```

---

## PaaS — Platform as a Service

The cloud provider manages more of the underlying infrastructure and platform.

You focus more on deploying and running your application.

### Example

**AWS Elastic Beanstalk**

---

## SaaS — Software as a Service

You use a complete software application.

The provider manages the infrastructure and application platform.

Examples:

* Gmail
* Microsoft 365
* Salesforce

---

## IaaS vs PaaS vs SaaS

| Model | You Manage                                   | Example           |
| ----- | -------------------------------------------- | ----------------- |
| IaaS  | OS, applications, data                       | EC2               |
| PaaS  | Application and data                         | Elastic Beanstalk |
| SaaS  | Mainly how you use/configure the application | Gmail             |

### Easy Way to Remember

```text
IaaS → Rent Infrastructure
PaaS → Rent Platform
SaaS → Use Software
```

---

# 6. Cloud Deployment Models

There are three commonly discussed deployment models.

## Public Cloud

Infrastructure is provided by a cloud provider and shared among multiple customers using logical isolation.

Examples:

* AWS
* Microsoft Azure
* Google Cloud

---

## Private Cloud

Cloud infrastructure is dedicated to a single organization.

---

## Hybrid Cloud

A combination of private infrastructure and public cloud.

Example:

```text
On-Premises
     │
     │
     ▼
   Hybrid
     │
     ▼
    AWS
```

---

# 7. Cloud Computing Service Categories

Cloud services can also be grouped by what they do.

| Category         | Purpose                      | AWS Examples  |
| ---------------- | ---------------------------- | ------------- |
| Compute          | Run applications             | EC2, Lambda   |
| Storage          | Store data                   | S3, EBS       |
| Database         | Store application data       | RDS, DynamoDB |
| Networking       | Connect resources            | VPC           |
| DNS              | Resolve domain names         | Route 53      |
| Security         | Manage access and protection | IAM, KMS      |
| Monitoring       | Monitor resources            | CloudWatch    |
| Auditing         | Track API activity           | CloudTrail    |
| Load Balancing   | Distribute traffic           | ELB           |
| Scaling          | Adjust resources             | Auto Scaling  |
| Content Delivery | Deliver content globally     | CloudFront    |

### Important

Don't confuse:

**Service Models**

```text
IaaS
PaaS
SaaS
```

with:

**Service Categories**

```text
Compute
Storage
Database
Networking
Security
Monitoring
```

Service models describe **how much you manage**.

Service categories describe **what the service does**.

---

# 8. What is AWS?

**AWS (Amazon Web Services)** is a cloud computing platform provided by Amazon.

AWS provides hundreds of cloud services across areas such as:

* Compute
* Storage
* Databases
* Networking
* Security
* Monitoring
* Analytics
* DevOps
* Machine Learning

For a Cloud/DevOps engineer, some of the most important services to understand are:

```text
IAM
VPC
EC2
S3
RDS
ALB
Auto Scaling
Route 53
CloudWatch
CloudTrail
```

---

# 9. Why Use AWS?

Organizations use AWS for:

* Scalability
* Flexibility
* Global infrastructure
* High availability
* Automation
* Security capabilities
* Managed services
* Pay-as-you-go pricing

AWS allows teams to build infrastructure without managing the physical data center themselves.

---

# 10. AWS Global Infrastructure

AWS infrastructure is organized into several important concepts:

```text
AWS Global Infrastructure
│
├── Regions
│   └── Availability Zones
│
└── Edge Locations
```

Understanding these concepts is important for designing AWS architectures.

---

# 11. AWS Regions

A **Region** is a geographical area containing multiple Availability Zones.

Examples include AWS Regions in:

* Mumbai
* Singapore
* Frankfurt
* London
* North Virginia

### Why Choose a Region?

Consider:

* User location
* Latency
* Service availability
* Compliance requirements
* Data residency
* Cost

### Example

If most users are in India, you may consider an AWS Region closer to those users to reduce network latency, subject to your application and compliance requirements.

---

# 12. Availability Zones

An **Availability Zone (AZ)** is an isolated location within an AWS Region.

A Region contains multiple Availability Zones.

Example:

```text
AWS Region
│
├── AZ-A
├── AZ-B
└── AZ-C
```

You can deploy resources across multiple AZs to improve availability and fault isolation.

### Example

```text
                AWS Region
               /          \
             AZ-A         AZ-B
              │             │
            EC2-A         EC2-B
```

If one Availability Zone has a problem, resources in another AZ can continue serving traffic if the application is designed for it.

---

# 13. Edge Locations

**Edge Locations** are locations used by AWS services such as CloudFront to deliver content closer to end users.

Example:

```text
User
  ↓
Nearest Edge Location
  ↓
Cached Content
```

This can reduce latency for content delivery.

---

# 14. AWS Account

An AWS Account provides an environment in which AWS resources are created and managed.

Examples of resources:

* EC2
* S3
* VPC
* RDS
* IAM
* Load Balancers

### Root User

The root user is the identity created when the AWS account is created.

It has extensive permissions.

### Best Practice

Don't use the root user for everyday AWS operations.

Use appropriate IAM identities and permissions instead.

---

# 15. AWS Shared Responsibility Model

AWS security follows a **Shared Responsibility Model**.

The responsibility is divided between AWS and the customer.

## AWS Responsibility

AWS is responsible for **security of the cloud**.

This includes things such as:

* Physical data centers
* Physical hardware
* AWS global infrastructure
* Underlying networking infrastructure

---

## Customer Responsibility

The customer is responsible for **security in the cloud**.

Depending on the service, this can include:

* IAM permissions
* Data
* Operating system
* Applications
* Security groups
* Network configuration
* Encryption configuration

### Example: EC2

```text
AWS
│
├── Physical Data Center
├── Physical Servers
├── Networking
└── Hypervisor

Customer
│
├── Operating System
├── Applications
├── Data
├── IAM
└── Security Configuration
```

---

# 16. AWS IAM

**IAM (Identity and Access Management)** controls access to AWS resources.

IAM includes:

* Users
* Groups
* Roles
* Policies
* Permissions

---

## IAM User

Represents an identity that can interact with AWS.

---

## IAM Group

A group is a collection of IAM users.

Example:

```text
Developers
│
├── User A
├── User B
└── User C
```

Permissions can be assigned to the group.

---

## IAM Role

A role provides permissions that can be assumed by an AWS service, user, or other trusted principal.

### Example

An EC2 instance can use an IAM role to access an S3 bucket without storing long-term AWS credentials on the server.

---

## IAM Policy

A policy defines permissions.

Example:

```text
Allow
│
└── s3:GetObject
```

---

## Principle of Least Privilege

Give users and applications **only the permissions they actually need**.

Avoid giving unnecessary permissions such as:

```text
AdministratorAccess
```

when a smaller set of permissions is sufficient.

---

# 17. AWS Networking Fundamentals

Networking is one of the most important areas for a Cloud Engineer.

Important AWS networking concepts include:

```text
VPC
│
├── Subnets
├── Route Tables
├── Internet Gateway
├── NAT Gateway
├── Security Groups
└── Network ACLs
```

---

# 18. VPC

**VPC (Virtual Private Cloud)** is a logically isolated virtual network in AWS.

You can configure:

* IP address ranges
* Subnets
* Route tables
* Internet connectivity
* Security controls

Example:

```text
VPC: 10.0.0.0/16
│
├── Public Subnet
│   10.0.1.0/24
│
└── Private Subnet
    10.0.2.0/24
```

---

# 19. Subnet

A subnet is a smaller IP network inside a VPC.

Subnets are associated with a single Availability Zone.

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

---

## Public Subnet

A subnet is commonly called public when its route table has a route to an Internet Gateway.

Resources such as public-facing load balancers may be placed there.

---

## Private Subnet

A private subnet does not have a direct route to an Internet Gateway.

Resources such as application servers and databases can be placed in private subnets.

---

# 20. Route Table

A route table determines where network traffic is sent.

Example:

```text
Destination      Target
10.0.0.0/16      local
0.0.0.0/0        Internet Gateway
```

### Simple Meaning

```text
Traffic Destination
        ↓
Route Table
        ↓
Choose Next Hop
```

---

# 21. Internet Gateway

An **Internet Gateway (IGW)** allows communication between a VPC and the internet when appropriate routes and public addressing are configured.

Example:

```text
Internet
   │
   ▼
Internet Gateway
   │
   ▼
VPC
   │
   ▼
Public Subnet
```

---

# 22. NAT Gateway

A **NAT Gateway** allows resources in a private subnet to initiate outbound connections to the internet without allowing unsolicited inbound internet connections directly to those resources.

Example:

```text
Private EC2
     │
     ▼
NAT Gateway
     │
     ▼
Internet Gateway
     │
     ▼
Internet
```

A common use case is allowing a private server to download updates.

---

# 23. Security Group

A **Security Group** acts as a virtual firewall for supported AWS resources.

It controls:

* Inbound traffic
* Outbound traffic

Security groups are **stateful**.

Example:

```text
EC2 Security Group

Inbound:
22  → SSH
80  → HTTP
443 → HTTPS
```

### Best Practice

Don't allow SSH from everywhere unless there is a specific reason.

Avoid:

```text
0.0.0.0/0
```

for administrative ports whenever possible.

---

# 24. Network ACL

A **Network ACL (NACL)** is a network-level security control that operates at the subnet level.

NACLs are:

* Stateless
* Subnet-level
* Rule-based
* Able to allow or deny traffic

### Security Group vs NACL

| Feature      | Security Group             | NACL                   |
| ------------ | -------------------------- | ---------------------- |
| Level        | Resource/Network Interface | Subnet                 |
| Stateful     | Yes                        | No                     |
| Rules        | Allow                      | Allow + Deny           |
| Main Purpose | Resource-level control     | Subnet-level filtering |

---

# 25. Compute - EC2

**Amazon EC2 (Elastic Compute Cloud)** provides virtual servers in AWS.

EC2 instances can run:

* Websites
* APIs
* Applications
* Scripts
* Docker containers
* Development environments

---

## EC2 Launch Components

When launching an EC2 instance, you commonly select:

* AMI
* Instance type
* Storage
* VPC
* Subnet
* Security group
* Key pair or another supported access method

---

# 26. AMI

**AMI (Amazon Machine Image)** is a template used to launch EC2 instances.

It can include:

* Operating system
* Software
* Configuration

Example:

```text
AMI
 ↓
Launch EC2
 ↓
Running Instance
```

---

# 27. EC2 Instance Types

An EC2 instance type defines the compute resources available to an instance.

It affects resources such as:

* CPU
* Memory
* Network performance
* Storage characteristics

Different instance families are designed for different workloads.

---

# 28. EBS

**Amazon EBS (Elastic Block Store)** provides block storage for EC2.

Think of EBS as a virtual disk.

It can store:

* Operating system files
* Applications
* Logs
* Database files
* Other persistent data

Example:

```text
EC2
 │
 ▼
EBS Volume
 │
 ▼
Data
```

---

# 29. S3

**Amazon S3 (Simple Storage Service)** is an object storage service.

It is commonly used for:

* Images
* Videos
* Backups
* Logs
* Documents
* Static website files
* Application data

---

## S3 Bucket

A bucket is a container for objects.

Example:

```text
S3 Bucket
│
├── image.jpg
├── backup.zip
├── report.pdf
└── application.log
```

---

## Important S3 Concepts

### Versioning

Keeps multiple versions of objects.

### Encryption

Protects stored data.

### Lifecycle Rules

Can automatically transition or delete objects based on defined rules.

### Storage Classes

S3 provides different storage classes for different access and cost requirements.

---

# 30. RDS

**Amazon RDS (Relational Database Service)** is a managed relational database service.

It supports engines such as:

* MySQL
* PostgreSQL
* MariaDB
* Oracle
* SQL Server
* Aurora

AWS manages many infrastructure and maintenance tasks.

You still manage things such as:

* Database users
* Permissions
* Schema
* Queries
* Application configuration

---

## RDS Multi-AZ

Multi-AZ deployments can provide high availability by maintaining a standby database in another Availability Zone, depending on the configuration and database engine.

---

## Read Replica

Read replicas can be used to scale read-heavy workloads.

---

# 31. Load Balancing

A load balancer distributes incoming traffic across multiple targets.

Example:

```text
             Users
               │
               ▼
         Load Balancer
          /           \
         ▼             ▼
      EC2-A          EC2-B
```

Benefits:

* Traffic distribution
* High availability
* Health checks
* Scalability

---

## Application Load Balancer

An **Application Load Balancer (ALB)** works at the application layer and is commonly used for HTTP/HTTPS applications.

---

# 32. Auto Scaling

Auto Scaling helps automatically adjust compute capacity according to workload and configured scaling policies.

Example:

```text
Low Traffic
    ↓
2 EC2 Instances

High Traffic
    ↓
4 EC2 Instances
```

When demand decreases, capacity can also be reduced.

---

# 33. Route 53

**Amazon Route 53** is a scalable DNS service.

DNS converts domain names into IP addresses or other resources/targets through DNS records.

Example:

```text
example.com
     ↓
Route 53
     ↓
DNS Record
     ↓
Application
```

Route 53 also supports:

* Domain registration
* DNS routing
* Health checks

---

# 34. CloudFront

**Amazon CloudFront** is a content delivery network (CDN).

It delivers content through a global network of edge locations.

Example:

```text
User
  ↓
Nearest CloudFront Edge
  ↓
Cached Content
  ↓
Origin
```

Benefits:

* Lower latency
* Faster content delivery
* Reduced load on the origin

---

# 35. CloudWatch

**Amazon CloudWatch** is used for monitoring and observability.

It can work with:

* Metrics
* Logs
* Alarms
* Events

Example:

```text
EC2
 ↓
CloudWatch
 ↓
CPU Metric
 ↓
Alarm
```

You can use CloudWatch to monitor resources and applications.

---

# 36. CloudTrail

**AWS CloudTrail** records AWS API activity.

It can help answer:

* Who performed an action?
* What action was performed?
* When was it performed?
* Which resource was affected?

Example:

```text
User
 ↓
AWS API Call
 ↓
CloudTrail
 ↓
Event Record
```

CloudTrail is useful for:

* Auditing
* Security investigations
* Compliance
* Troubleshooting

---

# 37. AWS Security Fundamentals

Security should be considered when designing every AWS architecture.

Important security principles include:

## Least Privilege

Give only the permissions required.

## MFA

Use Multi-Factor Authentication for important identities.

## Encryption

Protect sensitive data:

* At rest
* In transit

## Secure Network Design

Use:

* Private subnets
* Security groups
* NACLs where appropriate
* Controlled routing

## Credential Management

Avoid hardcoding AWS credentials in:

* Source code
* Git repositories
* Scripts

Use appropriate AWS identity mechanisms such as IAM roles where possible.

---

# 38. AWS Cost Management

AWS uses different pricing models depending on the service.

Common concepts include:

* Pay-as-you-go
* Free Tier eligibility
* Reserved pricing options
* Savings Plans
* Cost Explorer
* AWS Budgets

---

## Important Learning Rule

When creating AWS resources for practice:

```text
Create Resource
      ↓
Use Resource
      ↓
Test
      ↓
Delete Unused Resources
```

Don't leave unnecessary resources running.

---

## Resources That Can Cause Charges

Depending on configuration, examples can include:

* EC2
* EBS volumes
* Elastic IP addresses
* NAT Gateways
* RDS
* Load Balancers
* Data transfer
* S3 storage

Always check the current AWS pricing for the specific service and Region.

---

# 39. AWS CLI

The **AWS Command Line Interface (CLI)** allows you to interact with AWS services from a terminal.

Example:

```bash
aws s3 ls
```

List EC2 instances:

```bash
aws ec2 describe-instances
```

AWS CLI is useful for:

* Automation
* Administration
* Troubleshooting
* Scripting
* DevOps workflows

---

# 40. Infrastructure as Code

**Infrastructure as Code (IaC)** means managing infrastructure using configuration files or code.

Popular tools include:

* Terraform
* AWS CloudFormation

Example:

```text
Terraform Code
      ↓
AWS API
      ↓
VPC
      ↓
Subnet
      ↓
EC2
      ↓
Security Group
```

### Benefits

* Automation
* Repeatability
* Version control
* Consistency
* Easier infrastructure management

---

# 41. High Availability

**High Availability (HA)** means designing systems to remain available even when some components fail.

Example:

```text
             Load Balancer
              /         \
             ↓           ↓
           AZ-A         AZ-B
            EC2          EC2
```

If one AZ becomes unavailable, the other can continue serving traffic when the architecture is designed appropriately.

---

# 42. Scalability

**Scalability** means the ability to handle increasing workload by increasing resources.

There are two common types.

---

## Vertical Scaling

Increase the size/capacity of an existing resource.

```text
Small EC2
   ↓
Larger EC2
```

---

## Horizontal Scaling

Add more resources.

```text
EC2-A
EC2-B
EC2-C
```

Horizontal scaling is commonly combined with load balancing and Auto Scaling.

---

# 43. Elasticity

**Elasticity** means automatically adjusting resources according to changing demand.

Example:

```text
Traffic increases
       ↓
More EC2 instances
       ↓
Traffic decreases
       ↓
Fewer EC2 instances
```

### Difference

**Scalability:**

> Can the system handle more workload?

**Elasticity:**

> Can the system automatically adjust resources as workload changes?

---

# 44. Fault Tolerance

**Fault tolerance** means designing a system so it can continue operating even when some components fail.

Example:

```text
Application
│
├── EC2-A
├── EC2-B
└── EC2-C
```

If one instance fails, the remaining instances can continue serving requests.

---

# 45. Basic AWS Architecture

A common web application architecture can look like:

```text
                         Internet
                            │
                            ▼
                        Route 53
                            │
                            ▼
                     Load Balancer
                            │
                 ┌──────────┴──────────┐
                 ▼                     ▼
               EC2-A                 EC2-B
                 │                     │
                 └──────────┬──────────┘
                            │
                            ▼
                           RDS
```

Supporting services:

```text
IAM
 ↓
Access Control

S3
 ↓
Object Storage

CloudWatch
 ↓
Monitoring

CloudTrail
 ↓
Auditing
```

---

# 46. Important AWS Terminology

| Term              | Simple Meaning                                                     |
| ----------------- | ------------------------------------------------------------------ |
| AWS               | Cloud platform from Amazon                                         |
| Region            | Geographical AWS location                                          |
| Availability Zone | Isolated location within a Region                                  |
| Edge Location     | Location used for services such as CloudFront                      |
| VPC               | Virtual network in AWS                                             |
| Subnet            | Smaller network inside a VPC                                       |
| EC2               | Virtual server                                                     |
| AMI               | Template used to launch EC2                                        |
| EBS               | Block storage for EC2                                              |
| S3                | Object storage                                                     |
| RDS               | Managed relational database                                        |
| IAM               | Identity and access management                                     |
| Security Group    | Stateful virtual firewall                                          |
| NACL              | Stateless subnet-level network filter                              |
| Route Table       | Controls network routes                                            |
| Internet Gateway  | VPC connectivity to the internet                                   |
| NAT Gateway       | Allows private resources to initiate outbound internet connections |
| ALB               | Application Load Balancer                                          |
| Auto Scaling      | Adjusts compute capacity                                           |
| Route 53          | DNS service                                                        |
| CloudFront        | CDN                                                                |
| CloudWatch        | Monitoring and observability                                       |
| CloudTrail        | API activity auditing                                              |
| IaC               | Infrastructure as Code                                             |

---

# 47. AWS Fundamentals Interview Questions

## 1. What is AWS?

AWS is a cloud computing platform that provides services for computing, storage, networking, databases, security, monitoring, and more.

---

## 2. What is Cloud Computing?

Cloud computing is the delivery of computing resources over a network on demand.

---

## 3. What is the difference between Region and Availability Zone?

A **Region** is a geographical area containing multiple Availability Zones.

An **Availability Zone** is an isolated location within a Region.

---

## 4. What is EC2?

EC2 is an AWS service that provides virtual servers.

---

## 5. What is S3?

S3 is an object storage service used to store files and other objects.

---

## 6. What is VPC?

VPC is a logically isolated virtual network in AWS.

---

## 7. What is a subnet?

A subnet is a smaller IP network inside a VPC.

---

## 8. What is a Security Group?

A Security Group is a stateful virtual firewall that controls network traffic to and from supported AWS resources.

---

## 9. What is IAM?

IAM manages identities and permissions for AWS resources.

---

## 10. What is an IAM Role?

An IAM role provides permissions that can be assumed by an AWS service, user, or other trusted principal.

---

## 11. What is S3 vs EBS?

**S3** is object storage.

**EBS** is block storage primarily used with EC2.

---

## 12. What is RDS?

RDS is a managed relational database service.

---

## 13. What is a Load Balancer?

A load balancer distributes incoming traffic across multiple targets.

---

## 14. What is Auto Scaling?

Auto Scaling automatically adjusts compute capacity according to configured policies and workload conditions.

---

## 15. What is CloudWatch?

CloudWatch provides monitoring and observability through metrics, logs, alarms, and other capabilities.

---

## 16. What is CloudTrail?

CloudTrail records AWS API activity for auditing and security purposes.

---

## 17. What is the Shared Responsibility Model?

AWS manages security **of the cloud**, while customers are responsible for security **in the cloud**, depending on the service.

---

## 18. What is High Availability?

High Availability means designing systems to remain available despite certain component or infrastructure failures.

---

## 19. What is Scalability?

Scalability is the ability of a system to handle increased workload by increasing resources.

---

## 20. What is Elasticity?

Elasticity is the ability to automatically increase or decrease resources based on changing demand.

---

# 48. Final Revision

Before moving deeper into AWS, make sure you can explain these concepts without looking at your notes:

### Cloud Fundamentals

* What is Cloud Computing?
* Why do companies use cloud?
* On-premises vs Cloud
* IaaS vs PaaS vs SaaS
* Public vs Private vs Hybrid Cloud
* Scalability
* Elasticity
* High Availability
* Fault Tolerance

### AWS Fundamentals

* What is AWS?
* Region
* Availability Zone
* Edge Location
* Shared Responsibility Model

### IAM

* User
* Group
* Role
* Policy
* Least Privilege

### Networking

* VPC
* CIDR
* Subnet
* Public vs Private Subnet
* Route Table
* Internet Gateway
* NAT Gateway
* Security Group
* NACL

### Compute & Storage

* EC2
* AMI
* Instance Type
* EBS
* S3

### Database

* RDS
* Multi-AZ
* Read Replica

### Availability & Scaling

* Load Balancer
* ALB
* Auto Scaling
* Vertical Scaling
* Horizontal Scaling

### Other Important Services

* Route 53
* CloudFront
* CloudWatch
* CloudTrail

### DevOps Foundation

* AWS CLI
* Infrastructure as Code
* Terraform
* CloudFormation

---

# 🎯 Final Takeaway

You don't need to memorize hundreds of AWS services.

First understand how the **core building blocks work together**:

```text
                         AWS
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
       IAM               VPC              EC2
    Security          Networking         Compute
                          │
             ┌────────────┼────────────┐
             │            │            │
            S3           RDS          ALB
         Storage       Database    Load Balancing
             │                         │
             └────────────┬────────────┘
                          │
                     Auto Scaling
                          │
                 ┌────────┴────────┐
                 │                 │
             CloudWatch        CloudTrail
             Monitoring         Auditing
```

Once these fundamentals are clear, services such as **EC2, VPC, IAM, S3, RDS, ALB, Auto Scaling, CloudWatch, and Terraform** become much easier to learn in depth.

> **Learn the concept first. Then learn the AWS service that implements it.**
