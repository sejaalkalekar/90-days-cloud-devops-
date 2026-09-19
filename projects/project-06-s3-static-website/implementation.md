# 🛠️ Implementation — Hosting a Static Website on Amazon S3

This document contains the step-by-step implementation of hosting a static website using **Amazon S3**.

---

# 1. Prerequisites

Before starting the practical, the following were required:

* AWS account
* Access to AWS Management Console
* Basic knowledge of Amazon S3
* A web browser
* Basic HTML/CSS files

---

# 2. Prepare Website Files

First, a simple static website was created locally.

### Project Files

```text
s3-static-website/
│
├── index.html
└── style.css
```

### `index.html`

The `index.html` file contains the main structure and content of the website.

### `style.css`

The `style.css` file contains the styling for the website.

---

## 2.1 Test the Website Locally

Before uploading the files to AWS, `index.html` was opened in a web browser to verify that the website was working correctly.

### Verification

The website should load successfully in the browser with the expected HTML content and CSS styling.

**[SCREENSHOT 01 — Website Running Locally]**

---

# 3. Create an S3 Bucket

### Step 1

Open the **AWS Management Console**.

Navigate to:

```text
S3 → Create bucket
```

### Step 2 — Bucket Name

Enter a globally unique bucket name.

Example:

```text
sejal-day46-static-website-2026
```

> S3 bucket names must be globally unique.

### Step 3 — AWS Region

Select:

```text
Asia Pacific (Mumbai)
ap-south-1
```

### Step 4 — Object Ownership

Keep:

```text
ACLs disabled
```

### Step 5 — Block Public Access

For this learning project, public access needs to be configured so the S3 website endpoint can serve the website objects.

Review the **Block Public Access** settings and allow the required public access configuration.

> ⚠️ This configuration is for this learning/demo project. Public access should not be enabled for sensitive or private data.

### Step 6

Keep the remaining settings at their default values unless there is a specific requirement.

Click:

```text
Create bucket
```

### Verification

The newly created bucket should appear in the S3 bucket list.

**[SCREENSHOT 02 — S3 Bucket Created]**

---

# 4. Upload Website Files

Open the newly created bucket.

Navigate to:

```text
Objects → Upload
```

Upload:

```text
index.html
style.css
```

Click:

```text
Upload
```

After the upload completes, the objects should appear inside the bucket.

### Expected Structure

```text
S3 Bucket
│
├── index.html
└── style.css
```

### Verification

Confirm that both website files are visible under the **Objects** section.

**[SCREENSHOT 03 — Website Files Uploaded]**

---

# 5. Enable Static Website Hosting

Open the S3 bucket and navigate to:

```text
Properties
```

Scroll down to:

```text
Static website hosting
```

Click:

```text
Edit
```

### Configuration

Select:

```text
Enable
```

Choose:

```text
Host a static website
```

For the index document, enter:

```text
index.html
```

Click:

```text
Save changes
```

### Why `index.html`?

The index document tells S3 which HTML file should be served as the default webpage when the website endpoint is accessed.

### Verification

Static website hosting should now show as enabled.

An S3 **website endpoint** should also be displayed.

**[SCREENSHOT 04 — Static Website Hosting Enabled]**

---

# 6. Configure Bucket Policy

The website files need the appropriate permissions so that users can retrieve them through the website endpoint.

Navigate to:

```text
Permissions → Bucket policy
```

Click:

```text
Edit
```

Add the following policy:

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

Replace:

```text
YOUR-BUCKET-NAME
```

with the actual S3 bucket name.

### Example

If the bucket name is:

```text
sejal-day46-static-website-2026
```

the Resource should be:

```text
arn:aws:s3:::sejal-day46-static-website-2026/*
```

Save the bucket policy.

---

## 6.1 Understanding the Policy

### `Principal`

```json
"Principal": "*"
```

Indicates that the permission applies to any principal.

### `Action`

```json
"Action": "s3:GetObject"
```

Allows objects to be retrieved.

### `Resource`

```json
"Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
```

Applies the permission to objects inside the bucket.

> This public-read configuration is used only to demonstrate the S3 website endpoint in this learning project.

### Verification

Confirm that the bucket policy is displayed under **Permissions → Bucket policy**.

**[SCREENSHOT 05 — Bucket Policy Configured]**

---

# 7. Access the S3 Website Endpoint

Return to:

```text
Properties → Static website hosting
```

Copy the **Bucket website endpoint**.

Open the endpoint in a web browser.

The browser should display the website hosted from the S3 bucket.

### Expected Result

```text
Hello from Amazon S3! 🚀

This static website is hosted using Amazon S3.

Day 46/90 | AWS Cloud & DevOps
```

### Verification

The website should load successfully through the S3 website endpoint.

**[SCREENSHOT 06 — S3 Website Endpoint]**

**[SCREENSHOT 07 — Final Hosted Website]**

---

# 8. Verify CSS Loading

To verify that the website is serving more than just the HTML file, confirm that the CSS styling is applied correctly.

The browser should display the webpage using the styling defined in:

```text
style.css
```

This confirms that S3 is serving the website's static assets correctly.

---

# 9. Test Website Update

To verify that changes to the website can be deployed by replacing an S3 object, modify the `index.html` file locally.

For example, change the heading:

```html
<h1>Hello from Amazon S3! 🚀</h1>
```

to:

```html
<h1>Welcome to My AWS Static Website! 🚀</h1>
```

Upload the updated `index.html` to the S3 bucket and replace the existing file.

Refresh the website.

### Expected Result

The updated heading should appear on the website.

**[SCREENSHOT 08 — Updated Website After File Replacement]**

---

# 10. Troubleshooting — 403 AccessDenied

During the implementation, the website initially returned:

```text
403 Forbidden

Code: AccessDenied
Message: Access Denied
```

## Cause

The S3 bucket contained the website files and static website hosting was enabled, but the required access permission for retrieving the website objects had not yet been configured.

## Resolution

The required bucket policy was added with:

```text
s3:GetObject
```

permission for the website objects.

After configuring the required permission, the website endpoint successfully served the website.

### Troubleshooting Checklist

If the website returns `403 AccessDenied`, check:

```text
☑ index.html exists
☑ Static website hosting is enabled
☑ Index document is exactly: index.html
☑ Required public access configuration is allowed
☑ Bucket policy is configured correctly
☑ Bucket name in the policy is correct
☑ Resource ARN ends with /*
☑ You are opening the S3 Website Endpoint
```

---

# 11. Important Difference — Website Endpoint vs S3 Object URL

S3 provides different ways to access objects.

For this practical, the **S3 static website endpoint** should be used.

### Website Endpoint

Used for:

```text
S3 Static Website Hosting
```

It serves the website according to the configured website settings.

### S3 Object URL

Used to directly access an S3 object.

It is not the same as the S3 static website endpoint.

### Key Learning

```text
S3 Website Hosting
        ↓
Website Endpoint
        ↓
index.html
```

---

# 12. Final Architecture

After completing the implementation, the architecture was:

```text
                    Internet
                       │
                       ▼
                  Web Browser
                       │
                       ▼
             S3 Website Endpoint
                       │
                       ▼
                  S3 Bucket
                  │       │
                  ▼       ▼
             index.html  style.css
                  │
                  ▼
             Static Website
```

---

# 13. Verification Checklist

| Step | Verification                   | Status |
| ---- | ------------------------------ | ------ |
| 1    | Website created locally        | ✅      |
| 2    | S3 bucket created              | ✅      |
| 3    | Website files uploaded         | ✅      |
| 4    | Static website hosting enabled | ✅      |
| 5    | `index.html` configured        | ✅      |
| 6    | Bucket policy configured       | ✅      |
| 7    | Website endpoint accessed      | ✅      |
| 8    | Website displayed correctly    | ✅      |
| 9    | Website update tested          | ✅      |
| 10   | 403 error investigated         | ✅      |

---

# 14. Security Considerations

This project uses public access to demonstrate the S3 static website endpoint.

However, public S3 access should be used carefully.

Do not store sensitive information such as:

* Passwords
* API keys
* Personal information
* Private documents
* Confidential application data

in a publicly accessible bucket.

For production environments, a more secure architecture can use:

```text
User
 │
 ▼
CloudFront
 │
 ▼
Private S3 Bucket
```

This can provide HTTPS, caching, custom domain support, and better control over access to the S3 origin.

---

# 15. Cleanup

After completing the practical, the temporary resources can be removed.

### Steps

1. Open the S3 bucket.
2. Delete the website objects.
3. Empty the bucket.
4. Delete the bucket.

### Why Cleanup?

The bucket was configured for a learning exercise and may have public access enabled. Removing it after the practical reduces unnecessary exposure and keeps the AWS environment clean.

---

# 16. Final Outcome

The static website was successfully hosted using Amazon S3.

### Final Result

```text
Static Website
      │
      ▼
Amazon S3
      │
      ├── index.html
      └── style.css
      │
      ▼
S3 Website Endpoint
      │
      ▼
Web Browser
```

### Key Takeaway

> Amazon S3 can serve static website content without requiring an EC2 instance or a traditional web server such as Apache or Nginx.

The practical also provided hands-on experience with **S3 bucket management, object uploads, static website hosting, bucket policies, access permissions, website endpoints, and troubleshooting 403 AccessDenied errors.**
