# AWS Lambda

## 1. What is AWS Lambda?

**AWS Lambda** is a **serverless compute service** provided by AWS.

It allows you to run code without managing servers.

With traditional servers, you usually need to:

* Launch a server
* Install an operating system
* Configure the server
* Manage CPU and memory
* Apply updates and patches
* Maintain the infrastructure

With Lambda, AWS manages the underlying servers for you.

You mainly focus on:

> **Writing the code and defining when it should run.**

---

## 2. Why is Lambda Called Serverless?

Serverless does **not** mean there are no servers.

Servers are still used behind the scenes, but **AWS manages them for you**.

You don't need to manage:

* Servers
* Operating systems
* Server scaling
* Hardware
* Infrastructure maintenance

So you can focus more on your application logic.

---

## 3. How AWS Lambda Works

A simple Lambda flow looks like this:

```text
Event
  ↓
AWS Lambda
  ↓
Your Function
  ↓
Result
```

For example:

```text
User uploads an image to S3
          ↓
       S3 Event
          ↓
      AWS Lambda
          ↓
Process the image
```

Lambda runs the function when the configured event occurs.

---

# 4. What is a Lambda Function?

A **Lambda function** is the code that Lambda executes.

For example, a simple Python Lambda function:

```python
def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "Hello from AWS Lambda!"
    }
```

The function contains the application logic that should be executed.

---

# 5. Lambda Handler

The **handler** tells Lambda which function to execute.

For example:

```python
def lambda_handler(event, context):
```

Here:

* `lambda_handler` → function name
* `event` → information about the event that triggered Lambda
* `context` → information about the Lambda execution environment

The handler is commonly written as:

```text
filename.function_name
```

For example:

```text
lambda_function.lambda_handler
```

---

# 6. Lambda Runtime

A **runtime** provides the environment required to execute your code.

Common Lambda runtimes include languages such as:

* Python
* Node.js
* Java
* .NET
* Ruby
* Go

The runtime determines how AWS executes your function.

---

# 7. What is an Event?

An **event** is data sent to Lambda when something happens.

Examples:

* An object is uploaded to S3
* An API request is received
* A scheduled task runs
* A message arrives in a queue
* A database event occurs

Example:

```text
S3 Upload
    ↓
S3 Event
    ↓
Lambda Function
```

---

# 8. Lambda Triggers

A **trigger** is an AWS service or event source that invokes a Lambda function.

Common Lambda triggers include:

| Trigger            | Example            |
| ------------------ | ------------------ |
| Amazon S3          | File upload        |
| Amazon API Gateway | HTTP/API request   |
| Amazon EventBridge | Scheduled event    |
| Amazon SQS         | Message processing |
| Amazon SNS         | Notification       |
| DynamoDB           | Database changes   |

Example:

```text
API Gateway
     ↓
   Lambda
     ↓
Application Logic
```

---

# 9. Lambda with S3

Lambda can be triggered when an object is created in an S3 bucket.

Example:

```text
User
 ↓
Upload File
 ↓
Amazon S3
 ↓
AWS Lambda
 ↓
Process File
```

Possible use cases:

* Image processing
* File validation
* Thumbnail generation
* Data processing
* Automated workflows

---

# 10. Lambda with API Gateway

Lambda is commonly used with **Amazon API Gateway** to build serverless APIs.

```text
Client
  ↓
API Gateway
  ↓
Lambda
  ↓
Application Logic
  ↓
Response
```

For example:

A client sends:

```text
GET /users
```

API Gateway receives the request and invokes Lambda.

Lambda processes the request and returns a response.

---

# 11. Lambda Scaling

One important advantage of Lambda is that it can automatically scale based on incoming requests.

For example:

```text
Low Traffic
    ↓
Few Lambda Executions

High Traffic
    ↓
More Lambda Executions
```

You don't manually launch additional EC2 instances for every increase in traffic.

AWS manages the underlying infrastructure and execution capacity.

---

# 12. Lambda Execution Model

A Lambda function is executed when it is invoked.

The basic lifecycle is:

```text
Invocation
    ↓
Execution Environment
    ↓
Function Runs
    ↓
Response
```

Lambda may reuse an existing execution environment for later invocations, but you should not rely on the environment always being reused.

---

# 13. Stateless Nature of Lambda

Lambda functions should generally be designed as **stateless**.

This means you should not depend on local memory or temporary files to permanently store application data.

For persistent storage, use services such as:

* Amazon S3
* Amazon DynamoDB
* Amazon RDS

Example:

```text
Lambda
  ↓
S3 / DynamoDB / RDS
```

---

# 14. Lambda Environment Variables

Environment variables allow you to provide configuration values to your Lambda function.

Example:

```text
DATABASE_HOST=example.com
ENVIRONMENT=production
```

Your code can read these values instead of hardcoding configuration.

Environment variables are useful for:

* Configuration
* API endpoints
* Environment-specific settings
* Application settings

Sensitive values should be handled carefully; for secrets, AWS services such as **AWS Secrets Manager** can be used.

---

# 15. Lambda IAM Permissions

Lambda often needs permission to access other AWS services.

For example:

```text
Lambda
   ↓
Read from S3
```

The Lambda function needs appropriate IAM permissions.

This is commonly configured using a **Lambda execution role**.

Example:

```text
Lambda Function
      ↓
IAM Execution Role
      ↓
IAM Policy
      ↓
AWS Service
```

The principle of **least privilege** should be followed.

Give the function only the permissions it actually needs.

---

# 16. Lambda Layers

**Lambda Layers** allow you to package reusable code or dependencies separately from your main function.

For example:

```text
Lambda Function
      +
Lambda Layer
      ↓
Execution
```

Layers can help share common libraries or components across multiple functions.

---

# 17. Lambda Versions

Lambda supports **versions** of a function.

A version represents a specific state of your function code and configuration.

For example:

```text
Version 1
Version 2
Version 3
```

This can help maintain stable versions of functions.

---

# 18. Lambda Aliases

An **alias** is a named reference to a specific Lambda version.

Examples:

```text
dev
test
production
```

For example:

```text
production → Version 3
```

This makes it easier to manage different environments and deployments.

---

# 19. Monitoring Lambda

Lambda integrates with **Amazon CloudWatch** for monitoring.

You can monitor information such as:

* Invocations
* Errors
* Duration
* Throttles
* Logs

Example:

```text
Lambda
   ↓
CloudWatch
   ↓
Metrics + Logs
```

Lambda automatically sends logs to CloudWatch when logging is configured through the function's execution.

---

# 20. Lambda Limits

Lambda has limits related to things such as:

* Execution duration
* Memory
* Concurrent executions
* Deployment package size
* Temporary storage

One important concept is **maximum execution duration**.

Lambda is designed for workloads that can complete within its execution limits.

For long-running workloads, other AWS services may be more appropriate.

---

# 21. Lambda Pricing

Lambda generally follows a **pay-for-use** model.

You are primarily charged based on factors such as:

* Number of requests
* Compute duration
* Allocated memory

This can be useful for workloads that run only when needed.

Unlike a continuously running EC2 instance, you don't need to keep a server running just to wait for occasional requests.

---

# 22. Lambda vs EC2

| Feature           | Lambda                 | EC2                           |
| ----------------- | ---------------------- | ----------------------------- |
| Server Management | AWS manages servers    | You manage the instance       |
| Infrastructure    | Serverless             | Virtual server                |
| Scaling           | Automatic              | Configure scaling             |
| Billing           | Usage-based            | Instance running time         |
| OS Management     | AWS managed            | User managed                  |
| Best For          | Event-driven workloads | Long-running/custom workloads |

### Simple Example

**EC2:**

```text
Launch Server
     ↓
Install Software
     ↓
Deploy Application
     ↓
Manage Server
```

**Lambda:**

```text
Write Function
     ↓
Configure Trigger
     ↓
AWS Runs Function
```

---

# 23. Common Lambda Use Cases

AWS Lambda can be used for:

### 1. Serverless APIs

```text
API Gateway → Lambda → Database
```

### 2. File Processing

```text
S3 → Lambda → Process File
```

### 3. Scheduled Tasks

```text
EventBridge → Lambda → Task
```

### 4. Automation

```text
AWS Event → Lambda → Automated Action
```

### 5. Data Processing

Lambda can process data as events arrive.

---

# 24. Simple Real-World Example

Imagine an application where users upload profile images.

Without Lambda:

```text
User
 ↓
Application Server
 ↓
Image Processing
 ↓
Storage
```

With Lambda:

```text
User
 ↓
S3
 ↓
Lambda
 ↓
Image Processing
 ↓
S3
```

The image-processing function runs only when the required event occurs.

---

# 25. Important Lambda Terms

| Term           | Meaning                                                          |
| -------------- | ---------------------------------------------------------------- |
| Function       | Code executed by Lambda                                          |
| Runtime        | Environment used to execute code                                 |
| Handler        | Entry point of the function                                      |
| Event          | Data that triggers/invokes the function                          |
| Trigger        | Service/event that invokes Lambda                                |
| Execution Role | IAM role used by Lambda                                          |
| Layer          | Reusable dependencies/code                                       |
| Version        | Specific version of a function                                   |
| Alias          | Named pointer to a version                                       |
| Invocation     | Execution of a Lambda function                                   |
| Cold Start     | Initialization delay when a new execution environment is created |
| Concurrency    | Number of function executions running at the same time           |

---

# 26. Lambda Architecture Example

A simple serverless application can look like:

```text
             Users
                ↓
        Amazon API Gateway
                ↓
          AWS Lambda
                ↓
       ┌────────┴────────┐
       ↓                 ↓
   DynamoDB             S3
```

Lambda handles the application logic while other AWS services provide API access and data storage.

---

# 27. Key Takeaways

* AWS Lambda is a **serverless compute service**.
* You run code without managing servers.
* Lambda functions execute in response to events.
* Lambda can integrate with many AWS services.
* Lambda automatically handles infrastructure scaling.
* IAM execution roles control access to AWS services.
* CloudWatch provides monitoring and logs.
* Lambda is well suited for **event-driven and short-running workloads**.
* Lambda and EC2 solve different infrastructure requirements.

### In one line:

> **AWS Lambda lets you run code in response to events without managing the underlying servers.**
