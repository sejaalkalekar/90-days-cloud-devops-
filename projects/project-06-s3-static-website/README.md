# 🌐 Hosting a Static Website on Amazon S3

> **90 Days of AWS Cloud & DevOps**

## 📌 Project Overview

This project demonstrates how to host a **static website using Amazon S3** without managing a traditional web server such as Apache or Nginx.

A simple HTML/CSS website was uploaded to an Amazon S3 bucket, static website hosting was enabled, the required access permissions were configured, and the website was accessed through the S3 website endpoint.

---

## 🎯 Project Objective

The main objectives of this project were to:

* Understand how Amazon S3 can be used for static website hosting.
* Create and configure an S3 bucket for website files.
* Upload HTML and CSS files to S3.
* Enable S3 Static Website Hosting.
* Configure the index document.
* Understand S3 bucket policies and object access.
* Access and verify the website through the S3 website endpoint.
* Troubleshoot an `403 AccessDenied` error.
* Understand the difference between S3 website hosting and traditional server-based hosting.

---

## 🏗️ Architecture

```text
                 👤 User
                    │
                    ▼
               🌐 Browser
                    │
                    ▼
          S3 Website Endpoint
                    │
                    ▼
               🪣 S3 Bucket
                │       │
                ▼       ▼
           index.html  style.css
                │
                ▼
          Static Website
```

### Architecture Flow

```text
Browser
   ↓
S3 Website Endpoint
   ↓
S3 Bucket
   ↓
index.html
   ↓
style.css
   ↓
Website displayed
```

---

## ☁️ AWS Services Used

| Service                       | Purpose                              |
| ----------------------------- | ------------------------------------ |
| **Amazon S3**                 | Store and serve static website files |
| **S3 Static Website Hosting** | Host the static website              |
| **S3 Bucket Policy**          | Configure access to website objects  |

---

## 🛠️ Technologies Used

* HTML
* CSS
* Amazon S3
* AWS Management Console
* JSON
* Web Browser

---

## 📁 Project Structure

```text
project-08-s3-static-website/
│
├── README.md
├── implementation.md
├── project-report.pdf
│
├── website/
│   ├── index.html
│   └── style.css
│
└── screenshots/
    ├── 01-s3-bucket-created.png
    ├── 02-website-files-uploaded.png
    ├── 03-static-website-hosting.png
    ├── 04-bucket-policy.png
    ├── 05-s3-website-endpoint.png
    └── 06-final-hosted-website.png
```

---

# 🚀 Implementation

## 1. Create an S3 Bucket

Created a dedicated S3 bucket for the static website.

**Region:**

```text
ap-south-1 — Asia Pacific (Mumbai)
```

The bucket was configured specifically for this learning project.

---

## 2. Prepare Website Files

A simple static website was created using:

```text
index.html
style.css
```

The HTML file contains the website structure and content, while the CSS file provides styling.

---

## 3. Upload Website Files

The website files were uploaded to the S3 bucket.

```text
S3 Bucket
│
├── index.html
└── style.css
```

---

## 4. Enable Static Website Hosting

Static website hosting was enabled from:

```text
S3
 → Bucket
 → Properties
 → Static website hosting
```

The following configuration was used:

```text
Hosting type: Host a static website
Index document: index.html
```

---

## 5. Configure Bucket Policy

The required bucket-level access permission was configured to allow the website objects to be retrieved.

Example policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
    }
  ]
}
```

> **Note:** Public access was intentionally configured for this learning project. Sensitive or private data should not be exposed through a public S3 bucket.

---

# 🔍 Verification

After completing the configuration, the S3 website endpoint was opened in a web browser.

The website successfully displayed the content stored in the S3 bucket.

### Expected Flow

```text
User
 ↓
S3 Website Endpoint
 ↓
index.html
 ↓
style.css
 ↓
Static Website
```

---

# 🐛 Troubleshooting

During the practical, the website initially returned:

```text
403 Forbidden
Code: AccessDenied
Message: Access Denied
```

### Cause

The website files existed and static website hosting was enabled, but the required access permission for retrieving the objects had not yet been configured.

### Solution

A bucket policy allowing:

```text
s3:GetObject
```

was configured for the website objects.

After configuring the required permission, the website became accessible through the S3 website endpoint.

### Key Lesson

> **Static website hosting configuration and access permissions are separate settings.**

Enabling static website hosting does not automatically make S3 objects publicly readable.

---

# 📸 Screenshots

### 1. S3 Bucket Created

**[SCREENSHOT — 01 S3 Bucket Created]**

Shows the S3 bucket created for the project.

---

### 2. Website Files Uploaded

**[SCREENSHOT — 02 Website Files Uploaded]**

Shows `index.html` and `style.css` inside the S3 bucket.

---

### 3. Static Website Hosting

**[SCREENSHOT — 03 Static Website Hosting]**

Shows static website hosting enabled and `index.html` configured as the index document.

---

### 4. Bucket Policy

**[SCREENSHOT — 04 Bucket Policy]**

Shows the S3 bucket policy used to allow the required object access.

---

### 5. S3 Website Endpoint

**[SCREENSHOT — 05 S3 Website Endpoint]**

Shows the S3 static website endpoint configuration.

---

### 6. Final Website

**[SCREENSHOT — 06 Final Hosted Website]**

Shows the successfully hosted static website in the browser.

---

# 🧠 Key Learnings

Through this project, I learned:

* Amazon S3 can be used to host static websites.
* S3 stores website files as objects inside a bucket.
* `index.html` can be configured as the website's index document.
* Static website hosting is different from traditional EC2-based hosting.
* Bucket policies control access to S3 resources.
* Public access must be configured carefully.
* A `403 AccessDenied` error can occur when the required object permissions are missing.
* S3 website hosting does not require an EC2 instance or traditional web server.

---

# ⚖️ S3 vs EC2 Website Hosting

### Traditional EC2 Hosting

```text
User
 ↓
Internet
 ↓
EC2
 ↓
Apache / Nginx
 ↓
Website Files
```

Requires management of:

* EC2 instance
* Operating system
* Web server
* Security groups
* Server maintenance

### S3 Static Website Hosting

```text
User
 ↓
S3 Website Endpoint
 ↓
S3 Bucket
 ↓
Website Files
```

No EC2 instance or traditional web server is required for the basic static website.

---

# 🔐 Security Considerations

For this learning project, public access was configured so that users could access the website through the S3 website endpoint.

For production environments, publicly exposing an S3 bucket should be carefully evaluated.

A production-oriented architecture can use:

```text
User
 ↓
CloudFront
 ↓
S3
```

This can provide:

* HTTPS
* CDN caching
* Custom domain support
* Better control over access to the S3 origin

---

# 🚀 Possible Improvements

This project can be extended by adding:

* **Amazon CloudFront** for CDN and HTTPS
* **Custom domain** using DNS
* **Route 53** for domain management
* **CI/CD pipeline** for automatic deployments
* **GitHub Actions** for automated S3 uploads
* **Terraform** for Infrastructure as Code
* Custom error pages
* Additional HTML/CSS/JavaScript content

---

# 🧹 Cleanup

After completing the practical, temporary resources can be removed.

### Cleanup Steps

1. Delete the website objects.
2. Empty the S3 bucket.
3. Delete the S3 bucket.

This helps avoid leaving an unnecessary publicly accessible resource.

---

# 📊 Project Outcome

| Item                           | Result |
| ------------------------------ | ------ |
| S3 bucket created              | ✅      |
| Website files uploaded         | ✅      |
| Static website hosting enabled | ✅      |
| Index document configured      | ✅      |
| Bucket policy configured       | ✅      |
| Website endpoint tested        | ✅      |
| Website successfully displayed | ✅      |
| 403 error investigated         | ✅      |

---

# 🎯 Skills Demonstrated

### AWS

* Amazon S3
* S3 Bucket Management
* S3 Object Management
* Static Website Hosting
* Bucket Policies
* Access Permissions

### Cloud

* Object Storage
* Static Website Hosting
* Public vs Private Access
* Resource-Based Policies
* Basic Cloud Architecture

### Troubleshooting

* HTTP 403 AccessDenied
* S3 permission troubleshooting
* Website endpoint verification

---

# 📄 Detailed Project Report

For the complete project documentation, implementation screenshots, troubleshooting details, architecture, and project analysis, see:

**[Project Report — `project-report.pdf`](./project-report.pdf)**

---

# 📌 Project Summary

**Project:** Hosting a Static Website on Amazon S3
**Day:** 46/90
**Track:** AWS Cloud & DevOps
**AWS Service:** Amazon S3
**Region:** `ap-south-1`
**Status:** Completed

---

## 💡 Key Takeaway

> **Amazon S3 can host static website content without requiring a traditional web server, while access permissions determine who can retrieve the stored objects.**

This project provided hands-on experience with S3 bucket management, static website hosting, access policies, troubleshooting, and basic AWS cloud architecture.
