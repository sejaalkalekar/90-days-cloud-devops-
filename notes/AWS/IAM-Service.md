# AWS IAM Service

## 1. What is AWS IAM?

**AWS IAM (Identity and Access Management)** is an AWS service used to control:

* **Who** can access AWS resources
* **What** they can do
* **Which AWS resources** they can access
* **How** they can access those resources

In simple words:

> **IAM decides who can do what in AWS.**

For example:

* Developer can access S3 but cannot delete EC2 instances.
* DevOps Engineer can manage EC2 and CloudWatch.
* Application running on EC2 can access an S3 bucket without storing AWS access keys.
* Administrator can manage almost everything in AWS.

IAM is a **global AWS service**, so IAM resources are not created inside a specific AWS Region.

---

# 2. Why is IAM Important?

Security is one of the most important parts of AWS.

Without IAM, users and applications could potentially have unnecessary access to AWS resources.

IAM helps us implement:

* Authentication
* Authorization
* Access control
* Least privilege
* Secure application access
* User management
* Role-based access
* Temporary credentials
* Multi-factor authentication (MFA)
* Auditing and accountability

---

# 3. Authentication vs Authorization

These two concepts are very important in IAM.

## Authentication

Authentication answers:

> **Who are you?**

Example:

You log in to AWS using:

* Username
* Password
* MFA

AWS verifies your identity.

That is **authentication**.

---

## Authorization

Authorization answers:

> **What are you allowed to do?**

For example:

A user is authenticated successfully, but IAM may allow them to:

```text
View S3 buckets
Download S3 objects
```

but not:

```text
Delete S3 buckets
Terminate EC2 instances
```

That is **authorization**.

### Simple difference

```text
Authentication → Who are you?
Authorization  → What can you do?
```

---

# 4. Main IAM Components

The most important IAM components are:

```text
IAM
│
├── Users
│
├── Groups
│
├── Roles
│
├── Policies
│
├── Identity-based policies
│
├── Resource-based policies
│
├── Permissions boundaries
│
├── MFA
│
├── Access Keys
│
├── Temporary credentials
│
├── Federation
│
└── IAM Identity Center
```

Let's understand each one.

---

# 5. IAM Users

An **IAM User** represents a person or application that needs long-term AWS access.

For example:

```text
Developer
DevOps Engineer
Tester
Administrator
```

A user can have:

* Username
* Password
* Access keys
* Permissions
* MFA

---

## Example

Suppose a company has:

```text
Alice → Developer
Bob   → DevOps Engineer
John  → Tester
```

We can create separate IAM users:

```text
alice
bob
john
```

and give each user appropriate permissions.

---

# 6. IAM User Credentials

An IAM user can have different types of credentials.

### Console credentials

Used to log in to:

```text
AWS Management Console
```

Usually:

```text
Username
Password
MFA
```

---

### Access keys

Used by:

* AWS CLI
* AWS SDK
* Applications

An access key consists of:

```text
Access Key ID
Secret Access Key
```

Example:

```text
AWS Access Key ID
AWS Secret Access Key
```

### Important

Never hard-code access keys inside:

```text
GitHub repositories
Source code
Docker images
Scripts
Public files
```

---

# 7. IAM Groups

An IAM Group is a collection of IAM users.

Instead of assigning the same permissions to every user individually, we can create a group.

Example:

```text
Developers
│
├── Alice
├── Bob
└── Charlie
```

Attach permissions to the group.

All users in the group receive those permissions.

---

## Example

Create:

```text
Developers
```

Attach:

```text
AmazonS3ReadOnlyAccess
```

Then add:

```text
Alice
Bob
Charlie
```

All three users can read S3 resources.

---

# 8. IAM Roles

An **IAM Role** is an identity that provides permissions temporarily.

Unlike an IAM user, a role is not normally associated with one specific person.

Roles are commonly used by:

* EC2
* Lambda
* ECS
* EKS
* AWS services
* Applications
* Cross-account access
* Federated users

---

## Example: EC2 accessing S3

Suppose an EC2 instance needs to read files from S3.

### Bad approach

Store access keys inside the EC2 server:

```text
Access Key
Secret Key
```

This is risky.

### Better approach

Create an IAM Role:

```text
EC2-S3-Read-Role
```

Attach an S3 read policy.

Attach the role to EC2.

Now:

```text
EC2
 ↓
IAM Role
 ↓
S3
```

The application can access S3 without storing permanent access keys.

---

# 9. User vs Group vs Role

| Component | Purpose                                                       |
| --------- | ------------------------------------------------------------- |
| User      | Represents a person/application needing an IAM identity       |
| Group     | Collection of users                                           |
| Role      | Provides temporary permissions to trusted identities/services |

### Easy way to remember

```text
User  → Person
Group → Collection of people
Role  → Temporary permissions
```

---

# 10. IAM Policies

An IAM Policy is a document that defines permissions.

It answers:

```text
What action?
On which resource?
Under which conditions?
```

IAM policies are normally written in **JSON**.

Example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
```

This policy allows:

```text
s3:GetObject
```

on objects inside:

```text
my-bucket
```

---

# 11. IAM Policy Structure

A policy commonly contains:

```text
Version
Statement
Effect
Action
Resource
Condition
Principal
```

---

## Version

Example:

```json
"Version": "2012-10-17"
```

This specifies the policy language version.

---

## Effect

Defines whether access is allowed or denied.

Possible values:

```text
Allow
Deny
```

Example:

```json
"Effect": "Allow"
```

---

## Action

Defines what operation is allowed.

Examples:

```text
s3:GetObject
s3:PutObject
s3:DeleteObject
ec2:StartInstances
ec2:StopInstances
```

---

## Resource

Defines which AWS resource the permission applies to.

Example:

```text
arn:aws:s3:::my-bucket/*
```

---

## Principal

Defines who is allowed to access a resource.

Principal is commonly used in **resource-based policies** and role trust policies.

Example:

```json
"Principal": {
  "AWS": "arn:aws:iam::123456789012:user/alice"
}
```

---

## Condition

Adds additional rules.

Example:

```text
Allow access only from a specific IP address.
```

Conditions can be based on things such as:

* IP address
* AWS Region
* MFA
* Tags
* Date/time
* VPC endpoint
* Encryption requirements

---

# 12. Identity-Based Policies

Identity-based policies are attached to:

* Users
* Groups
* Roles

Example:

```text
User
 ↓
IAM Policy
 ↓
S3 permissions
```

Example:

```json
{
  "Effect": "Allow",
  "Action": "s3:ListAllMyBuckets",
  "Resource": "*"
}
```

---

# 13. Resource-Based Policies

Resource-based policies are attached directly to resources.

Common examples include:

* S3 bucket policies
* SQS policies
* SNS policies
* KMS key policies

Example:

```text
User
   ↓
S3 Bucket
   ↑
Bucket Policy
```

An S3 bucket policy can specify which users, roles, or accounts can access the bucket.

---

# 14. Identity-Based vs Resource-Based Policies

| Identity-Based               | Resource-Based                  |
| ---------------------------- | ------------------------------- |
| Attached to identity         | Attached to resource            |
| User                         | S3 bucket                       |
| Group                        | SQS queue                       |
| Role                         | SNS topic                       |
| Defines what identity can do | Defines who can access resource |

Simple example:

```text
Identity Policy:
"Bob can read S3"

Resource Policy:
"This S3 bucket allows Bob"
```

---

# 15. Managed Policies

AWS provides predefined policies called **AWS Managed Policies**.

Examples:

```text
AmazonS3ReadOnlyAccess
AmazonEC2FullAccess
AmazonSSMManagedInstanceCore
AdministratorAccess
```

These policies are maintained by AWS.

---

# 16. Customer Managed Policies

Customer managed policies are policies created and maintained by you.

Example:

```text
DeveloperS3ReadPolicy
```

You can customize the exact permissions.

Example:

```text
Allow:
s3:GetObject

Deny:
s3:DeleteObject
```

Customer managed policies are useful when you need more control.

---

# 17. Inline Policies

An inline policy is directly embedded into one IAM identity.

For example:

```text
IAM Role
 ↓
Inline Policy
```

Inline policies have a one-to-one relationship with the identity.

They are useful for specific permissions that should not be reused.

For most reusable permissions, managed policies are generally easier to manage.

---

# 18. AWS Managed vs Customer Managed vs Inline

| Policy Type      | Managed By | Reusable?                             |
| ---------------- | ---------- | ------------------------------------- |
| AWS Managed      | AWS        | Yes                                   |
| Customer Managed | You        | Yes                                   |
| Inline           | You        | No, attached directly to one identity |

---

# 19. Least Privilege Principle

**Least privilege** means:

> Give only the permissions that are actually required.

For example, if an application only needs to read an S3 object:

Don't give:

```text
AmazonS3FullAccess
```

Give only:

```text
s3:GetObject
```

and only for the required bucket/object.

---

## Bad example

```text
Action: *
Resource: *
```

This means almost everything is allowed.

---

## Better example

```text
Action:
s3:GetObject

Resource:
arn:aws:s3:::my-app-bucket/*
```

This follows least privilege.

---

# 20. IAM Policy Evaluation Logic

AWS evaluates IAM permissions before allowing an action.

A simple way to understand the process is:

```text
Request
   ↓
Authentication
   ↓
Policy evaluation
   ↓
Explicit Deny?
   ↓
Yes → DENY
   ↓
No
   ↓
Allow?
   ↓
Yes → ALLOW
No  → DENY
```

### Most important rule

> **Explicit Deny overrides Allow.**

Example:

Policy 1:

```text
Allow S3 access
```

Policy 2:

```text
Deny S3 access
```

Result:

```text
DENY
```

---

# 21. Explicit Deny

An explicit Deny always has higher priority than Allow.

Example:

```json
{
  "Effect": "Deny",
  "Action": "s3:DeleteBucket",
  "Resource": "*"
}
```

Even if another policy says:

```text
Allow s3:DeleteBucket
```

the request will still be denied.

---

# 22. IAM Permissions Boundaries

A **Permissions Boundary** defines the maximum permissions an IAM user or role can receive.

Think of it as a permission limit.

Example:

```text
IAM Role
+
Permissions Policy
+
Permissions Boundary
```

The role can only receive permissions allowed by both.

Simple example:

```text
Policy:
Can access S3 + EC2 + RDS

Boundary:
Can access only S3 + EC2
```

Effective permissions:

```text
S3 + EC2
```

Not RDS.

---

# 23. IAM Role Trust Policy

An IAM role has two important concepts:

### Permission Policy

Defines:

> What can this role do?

### Trust Policy

Defines:

> Who can assume this role?

Example:

```text
EC2
 ↓
Trust Policy
 ↓
Can assume role
 ↓
Permission Policy
 ↓
Can access S3
```

---

# 24. Trust Policy Example

Example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

This means:

```text
EC2 service can assume this role.
```

---

# 25. Permission Policy vs Trust Policy

| Policy            | Question                 |
| ----------------- | ------------------------ |
| Permission Policy | What can the role do?    |
| Trust Policy      | Who can assume the role? |

Remember:

```text
Trust → Who can use the role?

Permission → What can they do?
```

---

# 26. IAM Instance Profile

When we attach an IAM role to an EC2 instance, AWS uses an **instance profile** to provide the role to the EC2 instance.

Conceptually:

```text
EC2
 ↓
Instance Profile
 ↓
IAM Role
 ↓
Permissions
```

This allows applications running on EC2 to obtain temporary AWS credentials.

---

# 27. IAM Access Keys

Access keys are mainly used for programmatic access.

They contain:

```text
Access Key ID
Secret Access Key
```

Example:

```text
AWS CLI
   ↓
Access Key
   ↓
IAM
   ↓
AWS Service
```

---

# 28. Why Access Keys Are Risky

Access keys can accidentally leak through:

```text
GitHub
Git repositories
Source code
Logs
Screenshots
Docker images
Configuration files
```

Never commit credentials like:

```text
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
```

to GitHub.

---

# 29. Better Alternatives to Access Keys

Whenever possible, use:

```text
IAM Roles
AWS IAM Identity Center
Temporary credentials
Environment-specific identity mechanisms
```

For EC2:

```text
EC2 IAM Role
```

is preferred over storing access keys.

---

# 30. Temporary Credentials

AWS STS can provide temporary credentials.

Temporary credentials usually contain:

```text
Access Key ID
Secret Access Key
Session Token
```

They expire after a limited period.

This is safer than permanent credentials.

---

# 31. AWS STS

**AWS Security Token Service (STS)** provides temporary security credentials.

STS is commonly used for:

* AssumeRole
* Cross-account access
* Federation
* Temporary access

Example:

```text
User
 ↓
STS AssumeRole
 ↓
Temporary Credentials
 ↓
AWS Resources
```

---

# 32. AssumeRole

`AssumeRole` allows an identity to temporarily use an IAM role.

Example:

```text
Developer Account
       ↓
   AssumeRole
       ↓
Production Role
       ↓
Production Resources
```

The developer does not need permanent production credentials.

---

# 33. Cross-Account IAM Access

AWS allows access between different AWS accounts.

Example:

```text
Account A
Developer
   │
   │ AssumeRole
   ↓
Account B
Production Role
   │
   ↓
Production Resources
```

This is commonly used in organizations with:

```text
Development Account
Testing Account
Production Account
Security Account
```

---

# 34. IAM MFA

**MFA = Multi-Factor Authentication**

MFA adds an additional verification step.

Instead of only:

```text
Username + Password
```

you also need:

```text
MFA code
```

Common MFA methods include authenticator applications and security keys/passkeys depending on the AWS-supported setup.

---

# 35. Why MFA is Important

If someone gets your password, MFA provides another layer of protection.

MFA should especially be enabled for:

* Root user
* Privileged users
* Administrative access

---

# 36. Root User

Every AWS account has a root user.

The root user has extremely powerful permissions.

The root user should **not** be used for everyday AWS administration.

Use IAM identities instead.

---

# 37. Root User Best Practices

For the root user:

* Enable MFA
* Do not create access keys unless absolutely required
* Do not use root for daily tasks
* Use IAM roles/users for normal operations
* Keep root credentials secure

---

# 38. IAM Identity Center

**AWS IAM Identity Center** provides centralized access management for people.

It is commonly used when organizations need:

```text
One login
   ↓
Multiple AWS Accounts
   ↓
Different permission sets
```

Example:

```text
Sejal
 ↓
IAM Identity Center
 ↓
Dev Account
 ↓
ReadOnly

Sejal
 ↓
IAM Identity Center
 ↓
Production Account
 ↓
DeveloperAccess
```

---

# 39. Federation

Federation allows users to authenticate using an external identity provider.

Examples include:

```text
Microsoft Entra ID
Okta
Other enterprise identity providers
```

Instead of creating separate AWS IAM users for every employee, organizations can use centralized identity management.

---

# 40. IAM Tags

IAM resources can have tags.

Example:

```text
Environment = Production
Team        = DevOps
Project     = Payment
Owner       = CloudTeam
```

Tags help with:

* Organization
* Automation
* Cost allocation in supported scenarios
* Access control conditions
* Resource management

---

# 41. IAM Policy Conditions

Conditions allow us to make permissions more specific.

Example:

```text
Allow S3 access
ONLY when MFA is enabled.
```

Or:

```text
Allow access only from a specific IP range.
```

Example:

```json
"Condition": {
  "Bool": {
    "aws:MultiFactorAuthPresent": "true"
  }
}
```

---

# 42. Common IAM Policy Conditions

Some commonly used condition keys include:

```text
aws:MultiFactorAuthPresent
aws:SourceIp
aws:RequestedRegion
aws:PrincipalTag
aws:ResourceTag
aws:SecureTransport
```

Conditions can make IAM policies more secure and precise.

---

# 43. IAM Policy Variables

IAM policies can use variables.

Example:

```text
${aws:username}
```

This can be useful when creating policies that dynamically refer to the current identity.

---

# 44. ARN

**ARN = Amazon Resource Name**

ARN uniquely identifies AWS resources.

General format:

```text
arn:partition:service:region:account-id:resource
```

Example S3 ARN:

```text
arn:aws:s3:::my-bucket
```

Example EC2-related ARN:

```text
arn:aws:ec2:ap-south-1:123456789012:instance/i-1234567890
```

ARNs are frequently used inside IAM policies.

---

# 45. IAM Policy Example

Example: allow read access to a specific S3 bucket.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowReadFromBucket",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::my-app-bucket",
        "arn:aws:s3:::my-app-bucket/*"
      ]
    }
  ]
}
```

This gives limited S3 access instead of full S3 access.

---

# 46. IAM Policy Simulator

AWS provides the **IAM Policy Simulator** to test whether a user or role has permission to perform an action.

For example:

```text
Can this role perform:
s3:GetObject?
```

The simulator can help determine whether the action is:

```text
Allowed
Denied
```

This is useful for troubleshooting IAM permission problems.

---

# 47. IAM Access Analyzer

**IAM Access Analyzer** helps identify unintended access to AWS resources.

It can help detect resources that are accessible from outside your AWS account or organization.

It can also help with policy validation and analysis.

Example:

```text
S3 Bucket
   ↓
Access Analyzer
   ↓
Detected external access
```

---

# 48. IAM Credential Report

AWS can generate an IAM credential report.

It provides information about IAM users and their credentials.

It can help administrators check things such as:

```text
Password enabled?
MFA enabled?
Access key exists?
Access key age?
Password age?
```

This is useful for security audits.

---

# 49. IAM Last Accessed Information

AWS can provide information about when identities accessed AWS services.

This can help identify unused permissions.

Example:

```text
User has:
EC2 permissions
S3 permissions
RDS permissions

But user only uses:
S3
```

The unused permissions can then be reviewed and potentially removed.

---

# 50. Service Control Policies (SCP)

**SCP = Service Control Policy**

SCPs are part of **AWS Organizations**.

They define the maximum available permissions for accounts or organizational units.

Important:

> SCPs do not grant permissions by themselves.

Think of an SCP as a guardrail.

Example:

```text
Organization
     ↓
Production Account
     ↓
SCP
     ↓
Cannot use certain AWS services
```

Even if IAM allows an action, an SCP can restrict it.

---

# 51. IAM vs SCP

| IAM Policy                                        | SCP                                             |
| ------------------------------------------------- | ----------------------------------------------- |
| Controls permissions for IAM identities/resources | Sets permission guardrails for AWS accounts/OUs |
| Can grant permissions                             | Does not grant permissions                      |
| User/Group/Role policies                          | AWS Organizations                               |
| Identity/resource level                           | Account/OU level                                |

---

# 52. Permission Sets

Permission sets are used with **IAM Identity Center**.

They define what users/groups can do in an AWS account.

Example:

```text
Developer
   ↓
Permission Set
   ↓
Development Account
   ↓
Developer Permissions
```

---

# 53. IAM Roles for AWS Services

AWS services often need permissions to perform actions on your behalf.

Examples:

```text
EC2 → S3
Lambda → DynamoDB
ECS → CloudWatch
AWS Backup → AWS resources
```

We can create IAM roles for these services.

Example:

```text
Lambda
 ↓
Lambda Execution Role
 ↓
CloudWatch Logs
```

---

# 54. IAM for DevOps Engineers

IAM is extremely important for DevOps.

A DevOps Engineer commonly works with:

```text
EC2
S3
VPC
RDS
CloudWatch
Systems Manager
ECR
ECS
Lambda
CodePipeline
Terraform
GitHub Actions
```

All of these may require IAM permissions.

---

# 55. IAM with EC2

Typical architecture:

```text
EC2
 ↓
IAM Role
 ↓
SSM
S3
CloudWatch
```

Example:

An EC2 instance can use an IAM role to:

```text
Send logs to CloudWatch
Read files from S3
Use Systems Manager
```

without storing access keys.

---

# 56. IAM with AWS Systems Manager

For Systems Manager, an EC2 instance can use an IAM role containing the required SSM permissions.

A commonly used AWS managed policy is:

```text
AmazonSSMManagedInstanceCore
```

Architecture:

```text
EC2
 ↓
IAM Role
 ↓
SSM permissions
 ↓
AWS Systems Manager
```

This is especially useful for secure server management without relying on SSH keys.

---

# 57. IAM with Terraform

Terraform also needs AWS permissions.

Example:

```text
Terraform
   ↓
AWS credentials / IAM role
   ↓
AWS API
   ↓
EC2 / VPC / S3 / IAM / RDS
```

The identity running Terraform must have the permissions required to create and manage the infrastructure.

### Important

Do not automatically give Terraform:

```text
AdministratorAccess
```

Use the minimum permissions required by the Terraform deployment.

---

# 58. IAM with CI/CD

CI/CD systems often need AWS permissions.

Example:

```text
GitHub Actions
      ↓
AWS Authentication
      ↓
IAM Role
      ↓
Deploy AWS Resources
```

A secure modern approach is to use **OIDC federation** so the CI/CD platform can obtain temporary AWS credentials instead of storing long-lived AWS access keys.

---

# 59. IAM with GitHub Actions

A common architecture is:

```text
GitHub Actions
       ↓
OIDC
       ↓
AWS IAM Role
       ↓
Temporary Credentials
       ↓
AWS
```

This is safer than storing permanent AWS access keys as GitHub secrets.

---

# 60. IAM OIDC

**OIDC = OpenID Connect**

OIDC allows an external identity provider to authenticate to AWS.

A common DevOps use case:

```text
GitHub
  ↓
OIDC Token
  ↓
AWS STS
  ↓
Assume IAM Role
  ↓
Temporary Credentials
  ↓
AWS Resources
```

This reduces the need for long-lived AWS access keys.

---

# 61. IAM and Secrets

IAM is not a replacement for a secrets-management service.

Do not store passwords or application secrets directly inside IAM policies.

For secrets, AWS services such as:

```text
AWS Secrets Manager
AWS Systems Manager Parameter Store
```

may be appropriate depending on the use case.

---

# 62. IAM Best Practices

### 1. Enable MFA

Especially for:

```text
Root user
Privileged identities
```

---

### 2. Follow Least Privilege

Give only the permissions required.

---

### 3. Avoid Root User

Use IAM identities for normal operations.

---

### 4. Prefer Roles Over Long-Lived Access Keys

For AWS workloads:

```text
EC2 → IAM Role
Lambda → IAM Role
ECS → IAM Role
```

---

### 5. Rotate Credentials

If access keys must be used, manage their lifecycle carefully.

---

### 6. Remove Unused Credentials

Delete:

```text
Unused users
Unused access keys
Unused roles
Unused permissions
```

---

### 7. Use Strong Passwords

For console users.

---

### 8. Use MFA

Add another layer of protection.

---

### 9. Avoid `Action: "*"`

Do not give unrestricted permissions unless genuinely required.

---

### 10. Avoid `Resource: "*"` When Possible

Limit permissions to specific resources.

---

### 11. Monitor IAM Activity

Use AWS security and auditing tools to identify unusual or unnecessary access.

---

### 12. Never Commit AWS Credentials

Never push credentials to GitHub.

---

# 63. Common IAM Mistakes

## Mistake 1: Giving AdministratorAccess to Everyone

Bad:

```text
All developers
      ↓
AdministratorAccess
```

Better:

```text
Developer
 ↓
Only required permissions
```

---

## Mistake 2: Hard-Coding Access Keys

Bad:

```text
AWS_ACCESS_KEY_ID=xxxxx
AWS_SECRET_ACCESS_KEY=xxxxx
```

inside application code.

Better:

```text
IAM Role
```

where supported.

---

## Mistake 3: No MFA

Using only:

```text
Username + Password
```

for privileged access.

Better:

```text
Password + MFA
```

---

## Mistake 4: Using Root User Daily

The root user should be protected and reserved for tasks that specifically require it.

---

## Mistake 5: Giving `*:*`

Example:

```json
{
  "Effect": "Allow",
  "Action": "*",
  "Resource": "*"
}
```

This provides extremely broad permissions.

Use specific permissions whenever possible.

---

# 64. Common IAM Errors

## AccessDeniedException

Example:

```text
User is not authorized to perform:
ec2:StartInstances
```

This usually means the identity does not have the required permission, or another policy/guardrail is preventing the action.

---

## InvalidClientTokenId

This can occur when AWS credentials are invalid or incorrectly configured.

Check:

```bash
aws configure
```

and:

```bash
aws sts get-caller-identity
```

---

## Not authorized to perform sts:AssumeRole

This can happen when:

* Caller lacks `sts:AssumeRole`
* Role trust policy does not trust the caller
* SCP or another restriction blocks the request

Check both:

```text
Caller permissions
+
Role trust policy
```

---

# 65. Useful AWS CLI IAM Commands

### Check current identity

```bash
aws sts get-caller-identity
```

---

### List IAM users

```bash
aws iam list-users
```

---

### List IAM groups

```bash
aws iam list-groups
```

---

### List IAM roles

```bash
aws iam list-roles
```

---

### List policies

```bash
aws iam list-policies
```

---

### Get user information

```bash
aws iam get-user
```

---

### List policies attached to a user

```bash
aws iam list-attached-user-policies \
  --user-name USERNAME
```

---

### List groups for a user

```bash
aws iam list-groups-for-user \
  --user-name USERNAME
```

---

### List access keys

```bash
aws iam list-access-keys \
  --user-name USERNAME
```

---

### List roles

```bash
aws iam list-roles
```

---

### Get role

```bash
aws iam get-role \
  --role-name ROLE_NAME
```

---

### List role policies

```bash
aws iam list-role-policies \
  --role-name ROLE_NAME
```

---

# 66. Useful AWS STS Commands

Check the current identity:

```bash
aws sts get-caller-identity
```

Example output:

```text
Account: 123456789012
Arn: arn:aws:iam::123456789012:user/cloud-devops-user
```

This is one of the most useful commands when troubleshooting AWS credentials.

---

# 67. IAM Troubleshooting Checklist

When an AWS API call gives:

```text
AccessDenied
```

check the following:

```text
1. Which identity am I using?
2. Does the identity have the required permission?
3. Is the resource correct?
4. Is the ARN correct?
5. Is there an explicit Deny?
6. Is a permissions boundary restricting access?
7. Is an SCP restricting access?
8. Is a resource policy denying access?
9. Is the role trust policy correct?
10. Is the request using the correct AWS Region/account?
```

First command to run:

```bash
aws sts get-caller-identity
```

---

# 68. IAM Security Model

A simplified AWS security model looks like this:

```text
                    AWS IAM
                       │
        ┌──────────────┼──────────────┐
        │              │              │
      Users          Roles          Groups
        │              │              │
        └──────────────┼──────────────┘
                       │
                    Policies
                       │
                 Permissions
                       │
              AWS Resources
```

---

# 69. Real-World DevOps Example

Suppose we have:

```text
Developer
DevOps Engineer
EC2 Application
GitHub Actions
```

We can design IAM like this:

```text
Developer
   ↓
IAM Identity Center
   ↓
Developer Permission Set


DevOps Engineer
   ↓
IAM Identity Center
   ↓
DevOps Permission Set


EC2
   ↓
IAM Role
   ↓
S3 + SSM + CloudWatch


GitHub Actions
   ↓
OIDC
   ↓
IAM Role
   ↓
Temporary AWS Credentials
```

This avoids giving everyone permanent credentials and keeps permissions separated.

---

# 70. IAM Architecture Example

```text
                         AWS ACCOUNT
                              │
                            IAM
                              │
          ┌───────────────────┼───────────────────┐
          │                   │                   │
        Users               Groups              Roles
          │                   │                   │
          │                   │                   │
          └───────────────────┼───────────────────┘
                              │
                           Policies
                              │
                    ┌─────────┴─────────┐
                    │                   │
               Permissions          Conditions
                    │                   │
                    └─────────┬─────────┘
                              │
                         AWS Resources
```

---

# 71. Important IAM Terms

| Term                 | Simple Meaning                                      |
| -------------------- | --------------------------------------------------- |
| IAM                  | AWS identity and access management service          |
| User                 | Identity generally representing a person            |
| Group                | Collection of IAM users                             |
| Role                 | Identity that can be assumed to obtain permissions  |
| Policy               | Document defining permissions                       |
| Permission           | What an identity is allowed to do                   |
| MFA                  | Additional authentication factor                    |
| Access Key           | Credential for programmatic access                  |
| STS                  | Service for temporary security credentials          |
| ARN                  | Unique AWS resource identifier                      |
| Trust Policy         | Defines who can assume a role                       |
| Permissions Policy   | Defines what an identity can do                     |
| Permissions Boundary | Maximum permissions an identity can receive         |
| SCP                  | Account/OU permission guardrail                     |
| Federation           | External identity used to access AWS                |
| OIDC                 | Identity federation protocol commonly used in CI/CD |
| IAM Identity Center  | Centralized workforce access to AWS accounts        |

---

# 72. Most Important IAM Concepts for a DevOps Engineer

If you are preparing for AWS Cloud/DevOps roles, focus strongly on these topics:

```text
1. IAM Users
2. IAM Groups
3. IAM Roles
4. IAM Policies
5. Managed Policies
6. Inline Policies
7. Least Privilege
8. IAM Policy Evaluation
9. Explicit Deny
10. Trust Policies
11. Permissions Boundaries
12. MFA
13. Access Keys
14. Temporary Credentials
15. AWS STS
16. AssumeRole
17. Cross-Account Roles
18. IAM Identity Center
19. Federation
20. OIDC
21. IAM Access Analyzer
22. Credential Reports
23. SCPs
24. IAM with EC2
25. IAM with SSM
26. IAM with Terraform
27. IAM with CI/CD
28. IAM troubleshooting
```

---

# 73. IAM Interview Questions

## Q1. What is AWS IAM?

AWS IAM is a service used to securely control access to AWS resources.

---

## Q2. What is the difference between authentication and authorization?

```text
Authentication → Who are you?
Authorization  → What can you do?
```

---

## Q3. What is an IAM User?

An IAM user is an identity generally used to represent a person or workload that requires AWS access.

---

## Q4. What is an IAM Role?

An IAM role provides permissions that can be assumed temporarily by trusted users, applications, or AWS services.

---

## Q5. Why are IAM roles preferred for EC2?

Because applications can use temporary credentials provided through the role instead of storing long-lived access keys on the server.

---

## Q6. What is an IAM Policy?

An IAM policy is a JSON document that defines permissions.

---

## Q7. What is the difference between Allow and Deny?

```text
Allow → Gives permission
Deny  → Removes/blocks permission
```

An explicit Deny overrides an Allow.

---

## Q8. What is least privilege?

Giving an identity only the permissions it actually needs.

---

## Q9. What is a trust policy?

A trust policy defines who or what is allowed to assume an IAM role.

---

## Q10. What is an access key?

An access key is used for programmatic access to AWS.

It contains:

```text
Access Key ID
Secret Access Key
```

---

## Q11. What is AWS STS?

AWS STS provides temporary security credentials.

---

## Q12. What is AssumeRole?

`AssumeRole` allows an identity to obtain temporary credentials for an IAM role.

---

## Q13. What is a permissions boundary?

It defines the maximum permissions that an IAM user or role can receive.

---

## Q14. What is an SCP?

An SCP is an AWS Organizations policy that acts as a permission guardrail for accounts or organizational units.

---

## Q15. Does an SCP grant permissions?

No.

An SCP limits the maximum permissions available to an account or OU.

---

## Q16. What is IAM Identity Center?

It provides centralized workforce access to AWS accounts and applications.

---

## Q17. What is OIDC used for in DevOps?

OIDC can allow systems such as GitHub Actions to obtain temporary AWS credentials through an IAM role without storing long-lived AWS access keys.

---

## Q18. How do you check which AWS identity you are currently using?

```bash
aws sts get-caller-identity
```

---

# 74. Quick IAM Cheat Sheet

```text
IAM
│
├── User
│   └── Person / long-term identity
│
├── Group
│   └── Collection of users
│
├── Role
│   └── Temporary identity/permissions
│
├── Policy
│   └── Defines permissions
│
├── Trust Policy
│   └── Who can assume a role?
│
├── Permission Policy
│   └── What can the identity do?
│
├── Permissions Boundary
│   └── Maximum permissions
│
├── MFA
│   └── Extra authentication layer
│
├── STS
│   └── Temporary credentials
│
├── Identity Center
│   └── Centralized workforce access
│
├── Access Analyzer
│   └── Find unintended access
│
└── SCP
    └── Account/OUs permission guardrail
```

---

# 75. Golden Rules of AWS IAM

Remember these rules:

```text
1. Never use the root user for daily work.

2. Enable MFA for privileged access.

3. Follow least privilege.

4. Prefer IAM roles over long-lived access keys.

5. Never commit AWS credentials to GitHub.

6. Use temporary credentials whenever possible.

7. Use separate permissions for different job responsibilities.

8. Review unused permissions regularly.

9. Understand both permission policies and trust policies.

10. Remember:
   Explicit Deny overrides Allow.

11. Use IAM Identity Center for centralized workforce access
   where appropriate.

12. Use OIDC for CI/CD workloads where supported.

13. Use IAM roles for AWS services such as EC2 and Lambda.

14. Use SCPs as organization-level guardrails.

15. Always check the current identity when troubleshooting:
   
   aws sts get-caller-identity
```

---

# 76. Final Summary

AWS IAM is the foundation of AWS security.

The easiest way to understand IAM is:

```text
WHO?
 ↓
User / Role
 ↓
WHAT CAN THEY DO?
 ↓
Policy
 ↓
ON WHAT?
 ↓
AWS Resource
```

For example:

```text
EC2
 ↓
IAM Role
 ↓
Policy
 ↓
s3:GetObject
 ↓
Specific S3 Bucket
```

A strong AWS Cloud/DevOps Engineer should understand not only how to create IAM users and policies, but also how to design **secure access using roles, least privilege, temporary credentials, federation, OIDC, permissions boundaries, SCPs, and centralized identity management**.

The main goal of IAM is:

> **Give the right identity the right permissions to the right resources for the right amount of time.**
