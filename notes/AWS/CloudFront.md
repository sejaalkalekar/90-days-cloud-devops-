# Amazon CloudFront

## 1. What is Amazon CloudFront?

**Amazon CloudFront** is an AWS **Content Delivery Network (CDN)** service.

It helps deliver websites, applications, videos, APIs, and other content to users with **lower latency and better performance**.

Instead of every user requesting content directly from a server located far away, CloudFront can cache content at locations closer to users.

### Simple Example

Without CloudFront:

```text
User in India
     ↓
Application Server in USA
     ↓
Content
```

With CloudFront:

```text
User in India
     ↓
CloudFront Edge Location
     ↓
Cached Content
```

The content can be delivered from a location closer to the user.

---

# 2. What is a CDN?

**CDN (Content Delivery Network)** is a globally distributed network of servers used to deliver content closer to end users.

A CDN helps reduce:

* Latency
* Network distance
* Load on the origin server
* Response time for cached content

Example:

```text
                 CloudFront
              /      |       \
             /       |        \
          India     USA      Europe
           User     User      User
```

Users can receive cached content from CloudFront locations closer to them.

---

# 3. Why Use CloudFront?

CloudFront can be used to:

* Improve website performance
* Reduce latency
* Cache content
* Reduce origin server load
* Deliver content globally
* Add HTTPS support
* Protect applications with AWS security services
* Serve dynamic and static content

---

# 4. What is an Origin?

The **origin** is the location where CloudFront gets the original content.

Common origins include:

* Amazon S3
* Application Load Balancer
* EC2
* API Gateway
* Any publicly accessible HTTP server

Example:

```text
User
 ↓
CloudFront
 ↓
Origin
 ↓
Content
```

---

# 5. CloudFront with S3

One of the most common CloudFront architectures is:

```text
User
 ↓
CloudFront
 ↓
Amazon S3
```

For example, a static website can store:

```text
index.html
style.css
script.js
images/
```

in S3.

CloudFront can distribute these files globally.

---

# 6. CloudFront with Application Load Balancer

CloudFront can also sit in front of an application.

```text
User
 ↓
CloudFront
 ↓
Application Load Balancer
 ↓
EC2 Instances
```

Here:

* CloudFront → Content delivery and caching
* ALB → Traffic distribution
* EC2 → Application hosting

---

# 7. CloudFront Distribution

A **CloudFront distribution** is the configuration that tells CloudFront how to deliver your content.

It defines things such as:

* Origin
* Cache behavior
* Allowed HTTP methods
* HTTPS configuration
* Domain name
* Security settings

Simple flow:

```text
User
 ↓
CloudFront Distribution
 ↓
Origin
```

---

# 8. Edge Locations

**Edge Locations** are locations where CloudFront caches and delivers content closer to users.

Example:

```text
                CloudFront
             Global Network
            /       |       \
           ↓        ↓        ↓
        India     Europe    USA
       Edge       Edge      Edge
```

When content is cached at an edge location, users nearby may receive it without CloudFront needing to fetch it from the origin every time.

---

# 9. Regional Edge Caches

CloudFront also uses **Regional Edge Caches** between edge locations and origins.

A simplified architecture is:

```text
User
 ↓
Edge Location
 ↓
Regional Edge Cache
 ↓
Origin
```

Regional edge caches can help reduce repeated requests to the origin.

---

# 10. How CloudFront Works

Consider a user requesting:

```text
https://example.com/logo.png
```

The simplified process is:

```text
User
 ↓
CloudFront
 ↓
Is object cached?
 ├── Yes → Return cached object
 │
 └── No
       ↓
     Origin
       ↓
     Content
       ↓
CloudFront Cache
       ↓
     User
```

This is called a **cache hit** or **cache miss** depending on whether the object was already available in the cache.

---

# 11. Cache Hit

A **cache hit** happens when the requested content is already available in the CloudFront cache.

```text
User
 ↓
CloudFront
 ↓
Object Found
 ↓
Return Content
```

The origin does not need to provide the object again.

This can improve performance and reduce origin requests.

---

# 12. Cache Miss

A **cache miss** happens when CloudFront does not have the requested object in its cache.

```text
User
 ↓
CloudFront
 ↓
Object Not Found
 ↓
Origin
 ↓
Content
 ↓
CloudFront Cache
 ↓
User
```

CloudFront fetches the content from the origin and can cache it for future requests.

---

# 13. Cache TTL

**TTL (Time To Live)** controls how long CloudFront keeps an object in its cache before it needs to revalidate or fetch it again, depending on the cache configuration.

Common concepts include:

* Minimum TTL
* Maximum TTL
* Default TTL

Example:

```text
Object
 ↓
CloudFront Cache
 ↓
TTL = 1 hour
```

After the relevant caching period, CloudFront may need to obtain or validate a newer version.

---

# 14. Cache Behavior

A **cache behavior** defines how CloudFront handles requests for a particular path pattern.

For example:

```text
/images/*
```

could have different caching settings from:

```text
/api/*
```

Example:

```text
example.com/images/*
        ↓
     Cache

example.com/api/*
        ↓
  Forward to Origin
```

This allows different types of content to be handled differently.

---

# 15. Static vs Dynamic Content

CloudFront can deliver both **static and dynamic content**.

### Static Content

Examples:

* HTML
* CSS
* JavaScript
* Images
* Videos

These are often good candidates for caching.

### Dynamic Content

Examples:

* API responses
* Personalized pages
* User-specific data

Dynamic requests may need to be forwarded to the origin instead of being served from a shared cache.

---

# 16. CloudFront HTTPS

CloudFront supports **HTTPS** for secure communication between users and CloudFront.

Example:

```text
User
 ↓
HTTPS
 ↓
CloudFront
 ↓
Origin
```

You can use an SSL/TLS certificate with a custom domain.

AWS Certificate Manager (**ACM**) can be used to manage certificates for CloudFront.

---

# 17. CloudFront Custom Domain

By default, a CloudFront distribution gets a domain similar to:

```text
d123example.cloudfront.net
```

You can use your own domain:

```text
www.example.com
```

with CloudFront.

A common setup is:

```text
User
 ↓
www.example.com
 ↓
Route 53
 ↓
CloudFront
 ↓
Origin
```

Route 53 can use an **Alias record** to route the domain to the CloudFront distribution.

---

# 18. CloudFront with Route 53

A common AWS architecture is:

```text
User
 ↓
www.example.com
 ↓
Route 53
 ↓
CloudFront
 ↓
S3 / ALB
```

Responsibilities:

* **Route 53** → DNS
* **CloudFront** → CDN and caching
* **S3 / ALB** → Origin

---

# 19. CloudFront Origin Access Control

When using S3 as an origin, **Origin Access Control (OAC)** can be used to allow CloudFront to access private S3 content.

A common secure architecture is:

```text
User
 ↓
CloudFront
 ↓
OAC
 ↓
Private S3 Bucket
```

The S3 bucket does not need to be publicly accessible just to serve content through CloudFront.

### Important

For new S3 + CloudFront deployments, **Origin Access Control (OAC)** is generally preferred over the older Origin Access Identity (OAI) approach.

---

# 20. CloudFront Security

CloudFront can work with AWS security services such as:

* AWS WAF
* AWS Shield
* AWS Certificate Manager
* AWS Identity and Access Management

Example:

```text
User
 ↓
CloudFront
 ↓
AWS WAF
 ↓
Origin
```

WAF can help filter unwanted web requests.

---

# 21. AWS WAF with CloudFront

**AWS WAF (Web Application Firewall)** can be associated with CloudFront to inspect and filter HTTP/HTTPS requests.

For example, WAF can help protect against common web attacks.

Simple architecture:

```text
User
 ↓
CloudFront
 ↓
AWS WAF
 ↓
Application
```

CloudFront distributes content while WAF provides web request filtering.

---

# 22. CloudFront and DDoS Protection

CloudFront integrates with **AWS Shield** for DDoS protection.

A simplified architecture is:

```text
Internet
   ↓
CloudFront
   ↓
AWS Shield
   ↓
Application
```

AWS Shield helps protect AWS applications from distributed denial-of-service attacks.

---

# 23. CloudFront Invalidation

Sometimes you update content at the origin but CloudFront still has an older cached version.

You can use a **CloudFront invalidation** to remove cached objects.

Example:

```text
Old index.html
      ↓
CloudFront Cache
      ↓
Update Origin
      ↓
Create Invalidation
      ↓
CloudFront Fetches New Content
```

Example invalidation path:

```text
/*
```

This invalidates all cached objects in the distribution.

---

# 24. Cache-Control Headers

Applications and origins can use HTTP caching headers such as:

```text
Cache-Control
```

These headers help control how content should be cached.

For example:

```text
Cache-Control: max-age=3600
```

This indicates that the response can be cached for 3600 seconds, subject to the applicable caching configuration.

---

# 25. CloudFront Compression

CloudFront can compress supported content to reduce the amount of data transferred to users.

Examples:

* HTML
* CSS
* JavaScript
* Text-based content

Compression can help reduce:

* Data transfer
* Page load time
* Bandwidth usage

---

# 26. CloudFront HTTP Methods

CloudFront can be configured to allow specific HTTP methods.

Common methods include:

```text
GET
HEAD
OPTIONS
POST
PUT
PATCH
DELETE
```

For a static website, typically only read-oriented methods are required.

For APIs, additional methods may be needed.

---

# 27. CloudFront Cookies, Headers and Query Strings

CloudFront cache behavior can be configured to forward selected:

* Query strings
* Headers
* Cookies

to the origin.

This is important for dynamic applications.

Example:

```text
/api/products?category=shoes
```

The query string may affect which response should be returned.

---

# 28. CloudFront Logging

CloudFront provides logging capabilities that can help analyze requests.

Logs can help with:

* Troubleshooting
* Traffic analysis
* Security investigation
* Usage analysis

CloudFront also provides metrics through **Amazon CloudWatch**.

---

# 29. CloudFront Monitoring

CloudFront integrates with **Amazon CloudWatch**.

You can monitor metrics related to:

* Requests
* Data transfer
* Error rates
* Cache behavior

Example:

```text
CloudFront
    ↓
CloudWatch
    ↓
Metrics
    ↓
Monitoring
```

---

# 30. CloudFront Price Classes

CloudFront provides **price classes** that allow you to control which CloudFront edge locations are used for distribution.

This can help balance:

* Geographic coverage
* Performance
* Cost

The available price classes and supported locations can change over time, so check the current AWS documentation when configuring production distributions.

---

# 31. CloudFront vs S3

CloudFront and S3 serve different purposes.

| Feature                | S3               | CloudFront                   |
| ---------------------- | ---------------- | ---------------------------- |
| Main purpose           | Object storage   | Content delivery             |
| Stores files           | Yes              | No, primarily caches content |
| CDN                    | No               | Yes                          |
| Global edge caching    | No               | Yes                          |
| Static website hosting | Yes              | Can deliver it               |
| Origin                 | Can be an origin | Sits in front of origin      |

They are often used together:

```text
User
 ↓
CloudFront
 ↓
S3
```

---

# 32. CloudFront vs Route 53

These services also have different responsibilities.

| Feature           | Route 53  | CloudFront               |
| ----------------- | --------- | ------------------------ |
| Main purpose      | DNS       | CDN                      |
| Domain resolution | Yes       | No                       |
| Caching           | No        | Yes                      |
| Content delivery  | No        | Yes                      |
| Health checks     | Yes       | No                       |
| Traffic routing   | DNS-based | Request/content delivery |

Common architecture:

```text
User
 ↓
Route 53
 ↓
CloudFront
 ↓
Origin
```

---

# 33. CloudFront vs ALB

| Feature               | CloudFront                     | ALB                              |
| --------------------- | ------------------------------ | -------------------------------- |
| Type                  | CDN                            | Load Balancer                    |
| Main purpose          | Content delivery               | Application traffic distribution |
| Global edge locations | Yes                            | No                               |
| Caching               | Yes                            | No                               |
| HTTP/HTTPS routing    | Yes                            | Yes                              |
| Health checks         | Origin health-related features | Target health checks             |
| Typical position      | Internet edge                  | Application layer                |

They are often used together:

```text
User
 ↓
CloudFront
 ↓
ALB
 ↓
EC2
```

---

# 34. Common CloudFront Architecture

A common production-style architecture can look like:

```text
                    Users
                      ↓
                  Route 53
                      ↓
                 CloudFront
                      ↓
               AWS WAF
                      ↓
             Application Load
                Balancer
                      ↓
             ┌────────┴────────┐
             ↓                 ↓
           EC2               EC2
             └────────┬────────┘
                      ↓
                     RDS
```

Each service has a specific responsibility:

* **Route 53** → DNS
* **CloudFront** → CDN and caching
* **WAF** → Web request filtering
* **ALB** → Load balancing
* **EC2** → Application
* **RDS** → Database

---

# 35. Simple CloudFront + S3 Architecture

For a static website:

```text
                User
                  ↓
             Route 53
                  ↓
             CloudFront
                  ↓
                 OAC
                  ↓
            Private S3 Bucket
                  ↓
          HTML / CSS / JS / Images
```

This is a common way to deliver static website content securely.

---

# 36. Important CloudFront Terms

| Term                | Meaning                                     |
| ------------------- | ------------------------------------------- |
| CloudFront          | AWS CDN service                             |
| CDN                 | Content Delivery Network                    |
| Distribution        | CloudFront configuration                    |
| Origin              | Source of content                           |
| Edge Location       | Location that delivers/caches content       |
| Regional Edge Cache | Intermediate CloudFront cache layer         |
| Cache Hit           | Object found in cache                       |
| Cache Miss          | Object not found in cache                   |
| TTL                 | Cache duration                              |
| Cache Behavior      | Rules for handling requests                 |
| Invalidation        | Removes objects from CloudFront cache       |
| OAC                 | Origin Access Control                       |
| WAF                 | Web Application Firewall                    |
| Price Class         | Controls edge-location coverage for pricing |
| Viewer              | Client making request                       |
| Origin Request      | Request CloudFront sends to origin          |

---

# 37. Common CloudFront Interview Questions

### Q1. What is Amazon CloudFront?

CloudFront is AWS's CDN service used to deliver content globally with lower latency.

### Q2. What is a CDN?

A CDN is a distributed network of servers that delivers content closer to end users.

### Q3. What is an origin?

The origin is the source from which CloudFront retrieves content.

### Q4. What is a CloudFront distribution?

A distribution contains the configuration CloudFront uses to deliver content from an origin.

### Q5. What is a cache hit?

A cache hit occurs when CloudFront already has the requested object in its cache.

### Q6. What is a cache miss?

A cache miss occurs when the requested object is not available in the relevant cache, so CloudFront retrieves it from the origin.

### Q7. What is an Edge Location?

An Edge Location is a CloudFront location where content can be cached and served closer to users.

### Q8. What is CloudFront invalidation?

It is a mechanism for removing cached objects so that updated content can be fetched from the origin.

### Q9. Can CloudFront work with S3?

Yes. S3 can be configured as a CloudFront origin.

### Q10. Can CloudFront work with an ALB?

Yes. An Application Load Balancer can be used as a CloudFront origin.

### Q11. What is OAC?

Origin Access Control helps CloudFront securely access supported origins such as private S3 buckets.

### Q12. What is the difference between CloudFront and Route 53?

Route 53 primarily handles DNS, while CloudFront primarily handles content delivery and caching.

### Q13. What is the difference between CloudFront and ALB?

CloudFront is a CDN that operates at the global edge, while ALB distributes application traffic among targets in AWS.

### Q14. Does CloudFront store the original content?

No. The original content remains at the origin. CloudFront caches copies of content at its edge locations.

---

# 38. Key Takeaways

* **Amazon CloudFront is AWS's Content Delivery Network (CDN).**
* It helps deliver content with lower latency.
* CloudFront uses a global network of edge locations.
* The **origin** is where CloudFront gets the original content.
* CloudFront can work with S3, ALB, EC2, API Gateway, and other HTTP origins.
* CloudFront caches content to reduce repeated requests to the origin.
* **Cache hit** means the content is available in the cache.
* **Cache miss** means CloudFront needs to retrieve the content from the origin.
* TTL controls caching duration.
* Cache behaviors control how different requests are handled.
* CloudFront supports HTTPS and custom domains.
* **OAC** can secure CloudFront access to private S3 content.
* CloudFront integrates with **Route 53, WAF, Shield, ACM, and CloudWatch**.
* Invalidations can be used when cached content needs to be removed.
* CloudFront and ALB are often used together in production architectures.

### In one line:

> **Amazon CloudFront is a CDN that caches and delivers content from locations closer to users, improving performance while reducing load on the origin.**
