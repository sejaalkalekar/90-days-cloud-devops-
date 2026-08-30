# AWS IAM Policies

## 1. What is an IAM Policy?

An **IAM Policy** is a JSON document that defines permissions in AWS.

In simple words:

> **An IAM Policy tells AWS who can do what, on which resource, and under which conditions.**

For example:

```text
Allow a developer to read files from an S3 bucket.
```

or:

```text
Allow an EC2 instance to read from S3.
```

or:

```text
Deny users from deleting an S3 bucket.
```

IAM policies are one of the most important parts of **AWS Identity and Access Management (IAM)**.

---

# 2. Why Do We Need IAM Policies?

AWS contains many services:

```text
EC2
S3
RDS
VPC
Lambda
CloudWatch
ECS
ECR
SSM
DynamoDB
IAM
```

We don't want every user, application, or AWS service to access everything.

For example:

```text
Developer
   ↓
Can read S3
Can view CloudWatch
Cannot delete EC2
Cannot modify IAM
```

Policies allow us to control this access.

---

# 3. Simple IAM Permission Model

The easiest way to understand an IAM policy is:

```text
WHO?
 ↓
User / Group / Role
 ↓
POLICY
 ↓
WHAT?
 ↓
Action
 ↓
WHERE?
 ↓
Resource
```

Example:

```text
Developer
   ↓
IAM Policy
   ↓
s3:GetObject
   ↓
Application S3 Bucket
```

This means:

> The developer is allowed to read objects from the specified S3 bucket.

---

# 4. IAM Policy JSON

IAM policies are written using JSON.

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

on:

```text
my-bucket
```

---

# 5. Main Elements of an IAM Policy

The most important policy elements are:

```text
Version
Statement
Sid
Effect
Principal
Action
Resource
Condition
```

Not every policy requires all of these elements.

---

# 6. Version

Example:

```json
"Version": "2012-10-17"
```

`Version` specifies the version of the IAM policy language.

The commonly used version is:

```text
2012-10-17
```

This does **not** mean the policy was created on that date.

---

# 7. Statement

`Statement` contains the actual permission rules.

Example:

```json
"Statement": [
  {
    "Effect": "Allow",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::my-bucket/*"
  }
]
```

A policy can contain multiple statements.

Example:

```text
Statement 1 → Allow S3 read
Statement 2 → Allow CloudWatch logs
Statement 3 → Deny S3 deletion
```

---

# 8. Sid

`Sid` means **Statement ID**.

It is an optional identifier for a statement.

Example:

```json
"Sid": "AllowS3Read"
```

Example:

```json
{
  "Sid": "AllowEC2Start",
  "Effect": "Allow",
  "Action": "ec2:StartInstances",
  "Resource": "*"
}
```

`Sid` makes a policy easier to understand and manage.

---

# 9. Effect

`Effect` defines whether access is allowed or denied.

There are two possible values:

```text
Allow
Deny
```

---

## Allow

Example:

```json
"Effect": "Allow"
```

This allows the specified action.

Example:

```text
Allow → s3:GetObject
```

Meaning:

> The identity can read S3 objects.

---

## Deny

Example:

```json
"Effect": "Deny"
```

This blocks the specified action.

Example:

```text
Deny → s3:DeleteBucket
```

Meaning:

> The identity cannot delete the S3 bucket.

---

# 10. Explicit Deny

This is one of the most important IAM concepts.

> **An explicit Deny overrides an Allow.**

Example:

```text
Policy 1:
Allow → s3:DeleteBucket

Policy 2:
Deny → s3:DeleteBucket
```

Final result:

```text
DENIED
```

Even though an Allow exists.

---

# 11. Action

`Action` defines **what operation** the identity can perform.

Examples:

```text
s3:GetObject
s3:PutObject
s3:DeleteObject

ec2:StartInstances
ec2:StopInstances
ec2:TerminateInstances

rds:DescribeDBInstances

ssm:StartSession
```

The general format is:

```text
service:action
```

Example:

```text
s3:GetObject
```

Here:

```text
s3
 ↓
AWS service

GetObject
 ↓
AWS API action
```

---

# 12. Common AWS Actions

### S3

```text
s3:GetObject
s3:PutObject
s3:DeleteObject
s3:ListBucket
```

### EC2

```text
ec2:StartInstances
ec2:StopInstances
ec2:TerminateInstances
ec2:DescribeInstances
```

### RDS

```text
rds:DescribeDBInstances
rds:StartDBInstance
rds:StopDBInstance
```

### Systems Manager

```text
ssm:StartSession
ssm:SendCommand
```

### CloudWatch Logs

```text
logs:CreateLogGroup
logs:CreateLogStream
logs:PutLogEvents
```

---

# 13. Multiple Actions

A policy can contain multiple actions.

Example:

```json
"Action": [
  "s3:GetObject",
  "s3:PutObject"
]
```

This allows:

```text
Read objects
Upload objects
```

but does not automatically allow:

```text
Delete objects
```

---

# 14. Wildcards in Actions

IAM policies support wildcards.

Example:

```json
"Action": "s3:*"
```

This allows all S3 actions covered by that statement.

Another example:

```json
"Action": "ec2:Describe*"
```

This matches EC2 actions beginning with `Describe`.

---

## Be Careful With `Action: "*"`

Example:

```json
"Action": "*"
```

This is extremely broad.

It can allow actions across many AWS services depending on the rest of the policy.

Avoid this when it is not necessary.

---

# 15. Resource

`Resource` specifies **which AWS resource** the permission applies to.

Example:

```json
"Resource": "arn:aws:s3:::my-bucket/*"
```

This refers to objects inside:

```text
my-bucket
```

---

# 16. Resource ARN

An ARN identifies an AWS resource.

ARN stands for:

> **Amazon Resource Name**

General format:

```text
arn:partition:service:region:account-id:resource
```

Example:

```text
arn:aws:s3:::my-bucket
```

Example:

```text
arn:aws:ec2:ap-south-1:123456789012:instance/i-1234567890abcdef
```

ARNs are commonly used inside IAM policies.

---

# 17. Resource `*`

Sometimes an AWS action does not support resource-level permissions, or the policy intentionally applies broadly.

In those cases we may use:

```json
"Resource": "*"
```

Example:

```json
{
  "Effect": "Allow",
  "Action": "ec2:DescribeInstances",
  "Resource": "*"
}
```

Where possible, use a specific resource instead of `*`.

---

# 18. Principal

`Principal` defines **who or what** is allowed to access a resource.

Example:

```json
"Principal": {
  "AWS": "arn:aws:iam::123456789012:user/alice"
}
```

This identifies Alice as the principal.

`Principal` is especially important in:

* Resource-based policies
* IAM role trust policies

---

# 19. Condition

`Condition` adds additional requirements to a policy.

For example:

```text
Allow access
ONLY when MFA is enabled.
```

Example:

```json
"Condition": {
  "Bool": {
    "aws:MultiFactorAuthPresent": "true"
  }
}
```

The permission is allowed only when the condition is satisfied.

---

# 20. Why Use Conditions?

Conditions make permissions more specific.

For example:

```text
Allow access only from a specific IP.

Allow access only when MFA is enabled.

Allow access only in a specific Region.

Allow access only when a resource has a specific tag.

Allow access only when HTTPS is used.
```

---

# 21. Common IAM Condition Keys

Some commonly used condition keys include:

```text
aws:SourceIp
aws:RequestedRegion
aws:MultiFactorAuthPresent
aws:SecureTransport
aws:PrincipalTag
aws:ResourceTag
```

The correct condition key depends on the AWS service and use case.

---

# 22. Example: Restrict Access by IP

A policy can restrict access to a specific IP range.

Conceptually:

```text
Allow S3 access
ONLY from:
203.0.113.0/24
```

Example:

```json
"Condition": {
  "IpAddress": {
    "aws:SourceIp": "203.0.113.0/24"
  }
}
```

---

# 23. Example: Require MFA

Example:

```json
"Condition": {
  "Bool": {
    "aws:MultiFactorAuthPresent": "true"
  }
}
```

This can be used to require MFA for specific operations.

---

# 24. Identity-Based Policies

Identity-based policies are attached to:

```text
Users
Groups
Roles
```

Example:

```text
IAM User
   ↓
Identity Policy
   ↓
S3 permissions
```

Example:

```json
{
  "Effect": "Allow",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::my-bucket/*"
}
```

---

# 25. Resource-Based Policies

Resource-based policies are attached directly to AWS resources.

Examples include:

```text
S3 Bucket Policy
SQS Queue Policy
SNS Topic Policy
KMS Key Policy
```

Example:

```text
User
 ↓
S3 Bucket
 ↑
Bucket Policy
```

The resource policy can define who is allowed to access the resource.

---

# 26. Identity-Based vs Resource-Based Policies

| Identity-Based Policy        | Resource-Based Policy           |
| ---------------------------- | ------------------------------- |
| Attached to identity         | Attached to resource            |
| User                         | S3 bucket                       |
| Group                        | SQS queue                       |
| Role                         | SNS topic                       |
| Defines what identity can do | Defines who can access resource |

Simple way to remember:

```text
Identity Policy
→ What can this identity do?

Resource Policy
→ Who can access this resource?
```

---

# 27. Managed Policies

Managed policies are standalone policies that can be attached to identities.

There are two main types:

```text
AWS Managed Policies
Customer Managed Policies
```

---

# 28. AWS Managed Policies

AWS creates and maintains these policies.

Examples:

```text
AmazonS3ReadOnlyAccess
AmazonEC2FullAccess
AmazonSSMManagedInstanceCore
AdministratorAccess
```

Advantages:

* Easy to use
* Maintained by AWS
* Useful for common permission requirements

However, some AWS managed policies can be broader than your exact application needs.

---

# 29. Customer Managed Policies

Customer managed policies are created and maintained by you.

Example:

```text
DeveloperS3ReadPolicy
```

You can define exactly what permissions are required.

Example:

```text
Allow:
s3:GetObject

Allow:
s3:ListBucket

Deny:
s3:DeleteBucket
```

Customer managed policies are useful when you need more control and reuse.

---

# 30. Inline Policies

An inline policy is directly attached to one IAM user, group, or role.

Example:

```text
IAM Role
   ↓
Inline Policy
```

The policy belongs directly to that identity.

Inline policies can be useful for permissions that are tightly tied to one specific identity.

For reusable permissions, managed policies are generally easier to manage.

---

# 31. Managed vs Inline Policies

| Policy Type      | Managed By | Reusable?                             |
| ---------------- | ---------- | ------------------------------------- |
| AWS Managed      | AWS        | Yes                                   |
| Customer Managed | You        | Yes                                   |
| Inline           | You        | No, directly attached to one identity |

---

# 32. Least Privilege

One of the most important IAM principles is:

> **Give only the permissions that are actually required.**

Suppose an application only needs to read S3 objects.

Don't give:

```text
AmazonS3FullAccess
```

Instead give:

```text
s3:GetObject
```

for the required bucket.

---

# 33. Bad Policy Example

```json
{
  "Effect": "Allow",
  "Action": "*",
  "Resource": "*"
}
```

This is extremely broad.

It can potentially give access to almost everything covered by the policy.

---

# 34. Better Policy Example

```json
{
  "Effect": "Allow",
  "Action": [
    "s3:GetObject"
  ],
  "Resource": "arn:aws:s3:::my-app-bucket/*"
}
```

This is much more restrictive.

The identity can:

```text
Read objects
```

from:

```text
my-app-bucket
```

---

# 35. Policy Evaluation Logic

AWS evaluates multiple policies when deciding whether an action is allowed.

A simplified process is:

```text
AWS Request
     ↓
Authentication
     ↓
Policy Evaluation
     ↓
Explicit Deny?
   ↙       ↘
 Yes       No
  ↓         ↓
DENY      Is there an Allow?
             ↓
        ┌────┴────┐
       Yes        No
        ↓          ↓
      ALLOW       DENY
```

The most important rule:

> **Explicit Deny overrides Allow.**

---

# 36. Default Deny

AWS follows a default-deny approach.

If there is no applicable Allow:

```text
Request
   ↓
No Allow
   ↓
DENY
```

Example:

```text
User has no EC2 permissions.
```

If the user tries:

```text
ec2:TerminateInstances
```

the request is denied.

---

# 37. Explicit Deny vs Default Deny

These are different concepts.

### Default Deny

There is no permission allowing the action.

```text
No Allow
 ↓
DENY
```

### Explicit Deny

A policy specifically says:

```text
Deny
```

Example:

```json
"Effect": "Deny"
```

Both result in denial, but an explicit Deny is especially important because it overrides an Allow.

---

# 38. Policy Inheritance Through Groups

Users can receive permissions through groups.

Example:

```text
Developers Group
      ↓
S3 Read Policy
      ↓
Alice
Bob
Charlie
```

Alice, Bob, and Charlie receive the permissions attached to the group.

This is easier to manage than creating the same policy separately for every user.

---

# 39. Role Permission Policies

Roles can also have policies.

Example:

```text
EC2
 ↓
IAM Role
 ↓
Permission Policy
 ↓
S3
```

The policy defines what the role can do.

Example:

```text
s3:GetObject
```

---

# 40. Role Trust Policy

An IAM role has another important policy called a **trust policy**.

It defines:

> **Who can assume this role?**

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
Can read S3
```

---

# 41. Trust Policy vs Permission Policy

This distinction is extremely important.

| Policy            | Question                 |
| ----------------- | ------------------------ |
| Trust Policy      | Who can assume the role? |
| Permission Policy | What can the role do?    |

Easy way to remember:

```text
Trust
 ↓
WHO?

Permission
 ↓
WHAT?
```

---

# 42. Example: EC2 IAM Role

Suppose an EC2 instance needs to read S3.

We create:

```text
EC2-S3-Read-Role
```

### Trust Policy

```text
EC2 service
   ↓
Can assume role
```

### Permission Policy

```text
Role
 ↓
s3:GetObject
 ↓
Application bucket
```

Final architecture:

```text
EC2
 ↓
IAM Role
 ↓
Permission Policy
 ↓
S3
```

---

# 43. Permissions Boundaries

A **Permissions Boundary** defines the maximum permissions an IAM user or role can have.

Think of it as a limit.

Example:

```text
Permissions Policy:
S3 + EC2 + RDS

Permissions Boundary:
S3 + EC2
```

Effective permissions cannot exceed the boundary.

```text
Effective permissions:
S3 + EC2
```

RDS access is not available.

---

# 44. SCP and IAM Policies

**SCP = Service Control Policy**

SCPs are used with **AWS Organizations**.

An SCP acts as a permission guardrail for AWS accounts or organizational units.

Important:

> **An SCP does not grant permissions.**

It limits what permissions can be used.

Example:

```text
AWS Organization
       ↓
Production Account
       ↓
SCP
       ↓
Blocks certain actions
```

Even if an IAM policy allows an action, an SCP can prevent it.

---

# 45. IAM Policy vs Permissions Boundary vs SCP

| Feature              | Purpose                                                   |
| -------------------- | --------------------------------------------------------- |
| IAM Policy           | Grants permissions                                        |
| Permissions Boundary | Limits maximum permissions for a user/role                |
| SCP                  | Limits maximum permissions available to an AWS account/OU |

Think of them as:

```text
IAM Policy
→ What can I do?

Permissions Boundary
→ What is the maximum I can receive?

SCP
→ What is the account allowed to use?
```

---

# 46. Policy Variables

IAM policies can use variables.

Example:

```text
${aws:username}
```

This allows a policy to dynamically refer to the current IAM username.

Policy variables can help create reusable policies.

---

# 47. Example Using a Policy Variable

Conceptually:

```text
arn:aws:s3:::company-bucket/${aws:username}/*
```

This can allow users to access objects in paths associated with their usernames, when the policy and service support the variable.

Example:

```text
company-bucket/alice/
company-bucket/bob/
company-bucket/charlie/
```

---

# 48. Resource-Level Permissions

Some AWS services allow policies to specify individual resources.

Example:

```text
Specific S3 bucket
Specific EC2 instance
Specific SQS queue
```

This is more secure than:

```text
Resource: "*"
```

when the service and action support resource-level permissions.

---

# 49. Policy Conditions and Tags

Tags can be used in access-control conditions.

Example:

```text
Environment = Production
```

A policy can be designed to allow actions only on resources with specific tags, where the AWS service supports the relevant condition keys.

This is useful in large environments.

---

# 50. Secure Transport Condition

AWS policies can use the `aws:SecureTransport` condition key.

This can be used to require secure connections such as HTTPS for supported requests.

Conceptually:

```text
If HTTPS
   ↓
Allow

If not HTTPS
   ↓
Deny
```

This is commonly seen in secure S3 bucket policies.

---

# 51. Policy Example: Deny Non-HTTPS Requests

Example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyInsecureTransport",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::my-bucket",
        "arn:aws:s3:::my-bucket/*"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
```

The idea is:

> Deny S3 requests that are not using secure transport.

---

# 52. Policy Examples

## Example 1: S3 Read

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::my-app-bucket/*"
    }
  ]
}
```

Purpose:

```text
Read S3 objects
```

---

## Example 2: S3 Upload

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::my-app-bucket/*"
    }
  ]
}
```

Purpose:

```text
Upload objects to S3
```

---

## Example 3: EC2 Start and Stop

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:StartInstances",
        "ec2:StopInstances"
      ],
      "Resource": "*"
    }
  ]
}
```

Purpose:

```text
Start EC2 instances
Stop EC2 instances
```

---

## Example 4: Read-Only EC2

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeVolumes",
        "ec2:DescribeSecurityGroups"
      ],
      "Resource": "*"
    }
  ]
}
```

Purpose:

```text
View EC2 information
```

The identity cannot automatically:

```text
Start EC2
Stop EC2
Terminate EC2
```

---

# 53. AWS Managed Policy vs Custom Policy

Suppose a developer needs S3 access.

You have two choices.

### AWS Managed Policy

```text
AmazonS3ReadOnlyAccess
```

Easy to use.

### Customer Managed Policy

Create:

```text
DeveloperS3ReadPolicy
```

with only:

```text
s3:GetObject
s3:ListBucket
```

and limit it to a specific bucket.

The custom policy may better follow least privilege.

---

# 54. Policy Simulator

AWS provides the **IAM Policy Simulator** to test permissions.

Example question:

```text
Can this user perform:

s3:GetObject
```

The simulator helps determine whether the action is allowed or denied.

This is useful when troubleshooting permission issues.

---

# 55. IAM Access Analyzer

**IAM Access Analyzer** helps identify unintended external access to AWS resources.

It can help identify resources that are accessible from outside the expected AWS account or organization.

It can also help with policy validation and policy generation capabilities.

Example:

```text
S3 Bucket
   ↓
Access Analyzer
   ↓
Unexpected external access detected
```

---

# 56. IAM Credential Report

The IAM credential report provides information about IAM user credentials.

It can help administrators review:

```text
Password status
MFA status
Access key status
Access key age
Password age
```

This is useful for security audits.

---

# 57. IAM Last Accessed Information

IAM provides information that can help identify when identities or policies last accessed AWS services.

This can help find unused permissions.

Example:

```text
User has:
EC2 permissions
S3 permissions
RDS permissions

Actual usage:
S3 only
```

The unused permissions can be reviewed and potentially removed.

---

# 58. IAM Policies and DevOps

IAM policies are extremely important for DevOps engineers.

DevOps tools frequently interact with AWS APIs.

Examples:

```text
Terraform
GitHub Actions
Jenkins
AWS CLI
AWS SDK
EC2
Lambda
ECS
SSM
```

All of these may require appropriate IAM permissions.

---

# 59. IAM Policies with Terraform

Terraform needs permission to create and manage AWS resources.

Example:

```text
Terraform
    ↓
IAM Identity / Role
    ↓
IAM Permissions
    ↓
AWS API
    ↓
VPC / EC2 / S3 / RDS
```

If Terraform does not have the required permissions, deployment can fail with:

```text
AccessDenied
```

Do not automatically give Terraform:

```text
AdministratorAccess
```

Instead, provide the permissions required by the infrastructure.

---

# 60. IAM Policies with EC2

EC2 applications often need to access other AWS services.

Example:

```text
EC2
 ↓
IAM Role
 ↓
Policy
 ↓
S3
```

The EC2 instance can access S3 using temporary credentials provided through the IAM role.

This is safer than storing access keys on the server.

---

# 61. IAM Policies with Systems Manager

An EC2 instance using AWS Systems Manager may need an IAM role with the required SSM permissions.

A common AWS managed policy is:

```text
AmazonSSMManagedInstanceCore
```

Architecture:

```text
EC2
 ↓
IAM Role
 ↓
SSM Permissions
 ↓
AWS Systems Manager
```

This allows secure management of EC2 instances without requiring traditional SSH access for many use cases.

---

# 62. IAM Policies with CI/CD

CI/CD systems need permissions to deploy AWS resources.

Example:

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

The IAM role should contain only the permissions required by the deployment.

---

# 63. IAM Policies and OIDC

OIDC can be used by external systems such as GitHub Actions to obtain temporary AWS credentials.

Architecture:

```text
GitHub Actions
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

This avoids storing long-lived AWS access keys in the CI/CD system.

---

# 64. IAM Policy and Access Keys

Access keys can be used for programmatic access.

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

However, long-lived access keys should be avoided when a safer alternative such as an IAM role or temporary credentials is available.

---

# 65. Never Store Credentials in Policies

IAM policies define permissions.

They should not be used as a place to store:

```text
Passwords
Database credentials
API secrets
Application secrets
```

For secrets, use appropriate services such as:

```text
AWS Secrets Manager
AWS Systems Manager Parameter Store
```

depending on the use case.

---

# 66. Policy Troubleshooting

When you receive:

```text
AccessDenied
```

check:

```text
1. Which identity am I using?
2. Does it have the required Action?
3. Is the Resource correct?
4. Is the ARN correct?
5. Is there an explicit Deny?
6. Is a permissions boundary restricting access?
7. Is an SCP restricting access?
8. Is a resource policy involved?
9. Is the role trust policy correct?
10. Am I using the correct AWS account?
11. Am I using the correct AWS Region?
12. Are policy Conditions being satisfied?
```

---

# 67. First Command for IAM Troubleshooting

When troubleshooting AWS permissions, first find out which identity is being used.

Run:

```bash
aws sts get-caller-identity
```

Example output:

```text
Account: 123456789012
Arn: arn:aws:iam::123456789012:user/cloud-devops-user
```

This tells you which AWS identity is making the request.

---

# 68. Common IAM Policy Errors

## AccessDeniedException

Example:

```text
User is not authorized to perform:
ec2:StartInstances
```

Possible reasons:

```text
Missing Allow
Explicit Deny
SCP restriction
Permissions Boundary
Resource Policy
Incorrect role
```

---

## Incorrect Resource ARN

Example:

```text
Policy allows:
arn:aws:s3:::bucket-a/*

Request accesses:
bucket-b
```

The permission does not match the requested resource.

---

## Missing Action

Example:

```text
Policy allows:
s3:GetObject

Application attempts:
s3:PutObject
```

The application does not have permission to upload.

---

# 69. Common IAM Policy Mistakes

## Mistake 1: Giving `Action: "*"`

Bad:

```json
"Action": "*"
```

This is unnecessarily broad in many situations.

---

## Mistake 2: Giving `Resource: "*"`

Bad:

```json
"Resource": "*"
```

when a specific resource ARN could be used.

---

## Mistake 3: Giving AdministratorAccess

Avoid giving:

```text
AdministratorAccess
```

to identities that do not need administrative access.

---

## Mistake 4: Copying Policies Without Understanding Them

Never blindly copy an IAM policy.

Understand:

```text
Effect
Action
Resource
Condition
Principal
```

before using it.

---

## Mistake 5: Forgetting Explicit Deny

An Allow policy may exist, but another policy could contain:

```text
Deny
```

Remember:

```text
Explicit Deny > Allow
```

---

# 70. IAM Policy Best Practices

### 1. Follow Least Privilege

Give only the required permissions.

### 2. Use Specific Actions

Prefer:

```text
s3:GetObject
```

over:

```text
s3:*
```

when possible.

### 3. Use Specific Resources

Prefer:

```text
arn:aws:s3:::my-app-bucket/*
```

over:

```text
*
```

when supported.

### 4. Use Conditions

Add additional security requirements where appropriate.

### 5. Prefer IAM Roles

For AWS workloads, prefer roles over long-lived access keys.

### 6. Review Permissions Regularly

Remove permissions that are no longer required.

### 7. Use IAM Access Analyzer

Look for unintended access.

### 8. Use Policy Simulator

Test policies before troubleshooting in production.

### 9. Protect Privileged Access

Use MFA and strong access controls.

### 10. Never Commit Credentials

Never push AWS credentials to GitHub.

---

# 71. IAM Policy Design Example

Suppose a company has:

```text
Development
Production
```

Developers need:

```text
Development:
EC2
S3
CloudWatch
```

But they should not have direct production administrative access.

A better design is:

```text
Developer
   ↓
Development Permissions
   ↓
Development Account


DevOps Engineer
   ↓
DevOps Permissions
   ↓
Development + Production
```

Production access can be controlled through appropriate roles, centralized identity, MFA, and temporary credentials.

---

# 72. Real-World DevOps IAM Example

Consider a CI/CD deployment:

```text
Developer
    ↓
GitHub
    ↓
GitHub Actions
    ↓
OIDC
    ↓
AWS IAM Role
    ↓
IAM Policy
    ↓
ECR / ECS / S3 / CloudFormation
```

The IAM policy defines exactly what the deployment role can do.

For example:

```text
Allow:
ecr:PutImage
ecs:UpdateService

Deny:
iam:*
```

This prevents the deployment pipeline from automatically modifying IAM.

---

# 73. IAM Policy Mental Model

Whenever you see an IAM policy, ask these five questions:

```text
1. WHO?
   Principal / Identity

2. WHAT?
   Action

3. WHERE?
   Resource

4. ALLOW OR DENY?
   Effect

5. UNDER WHICH CONDITIONS?
   Condition
```

Example:

```text
WHO?
Developer

WHAT?
s3:GetObject

WHERE?
my-app-bucket

ALLOW OR DENY?
Allow

CONDITION?
Only under specific conditions, if defined
```

---

# 74. Important IAM Policy Concepts

For AWS Cloud/DevOps interviews, understand these concepts well:

```text
IAM Policy
IAM User
IAM Group
IAM Role
Identity-Based Policy
Resource-Based Policy
AWS Managed Policy
Customer Managed Policy
Inline Policy
Trust Policy
Permission Policy
Explicit Deny
Default Deny
Least Privilege
Policy Evaluation
Permissions Boundary
SCP
Policy Conditions
Policy Variables
ARN
STS
AssumeRole
OIDC
IAM Access Analyzer
Policy Simulator
```

---

# 75. Quick IAM Policy Cheat Sheet

```text
IAM Policy
│
├── Version
│   └── Policy language version
│
├── Statement
│   └── Permission rules
│
├── Sid
│   └── Statement identifier
│
├── Effect
│   ├── Allow
│   └── Deny
│
├── Action
│   └── What can be done?
│
├── Resource
│   └── On which resource?
│
├── Principal
│   └── Who?
│
└── Condition
    └── Under which conditions?
```

---

# 76. Important Policy Rules

Remember these rules:

```text
1. AWS IAM policies are JSON documents.

2. Policies define permissions.

3. Allow grants access.

4. Explicit Deny blocks access.

5. Explicit Deny overrides Allow.

6. No applicable Allow normally means Deny.

7. Action defines what can be done.

8. Resource defines where the action can be performed.

9. Principal defines who can access a resource
   in policies where Principal is applicable.

10. Condition adds additional requirements.

11. IAM roles use permission policies to define
    what they can do.

12. IAM role trust policies define who can assume
    the role.

13. Least privilege should always be the goal.

14. Avoid unnecessary "*" permissions.

15. Permissions boundaries limit the maximum permissions
    of IAM users and roles.

16. SCPs provide account/OU-level guardrails and
    do not grant permissions.

17. Prefer temporary credentials and IAM roles over
    long-lived access keys when possible.
```

---

# 77. Final Summary

AWS IAM Policies are the foundation of AWS permissions.

The easiest way to remember an IAM policy is:

```text
WHO
 ↓
CAN DO WHAT
 ↓
ON WHICH RESOURCE
 ↓
UNDER WHICH CONDITIONS
```

For example:

```text
EC2 Application
      ↓
IAM Role
      ↓
IAM Policy
      ↓
s3:GetObject
      ↓
Specific S3 Bucket
```

A secure IAM design should follow:

```text
Least Privilege
      +
Specific Actions
      +
Specific Resources
      +
Conditions where required
      +
MFA for privileged access
      +
IAM Roles
      +
Temporary Credentials
```

The most important rule to remember is:

> **Explicit Deny always overrides Allow.**

And the most important security principle is:

> **Give an identity only the permissions it actually needs.**
