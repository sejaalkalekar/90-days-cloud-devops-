# 📅 Day 18 — Amazon S3 Static Website Hosting

**Date:** 15 August 2026

## 🎯 Goal
Deploy a static website using Amazon S3 and understand how S3 Static Website Hosting works.

## 📚 Topics Covered
- Amazon S3
- Buckets & Objects
- Static Website Hosting
- Bucket Policies
- Block Public Access
- Website Endpoint

## 💻 Hands-on Practice
- Created an S3 bucket
- Uploaded HTML, CSS, and JS files
- Enabled Static Website Hosting
- Configured Bucket Policy
- Disabled Block Public Access (Lab Environment)
- Verified website accessibility

## 📸 Screenshots
> Screenshots are available in:
> `assets/aws-console-screenshots/`

- Bucket created
- Website hosting enabled
- Bucket policy
- Website running successfully

## ⚠️ Challenges
- Received **403 Access Denied**
- Website wasn't publicly accessible

## ✅ Solution
- Updated the Bucket Policy
- Disabled Block Public Access (for learning purposes)
- Verified the correct Website Endpoint URL

## 💡 Key Takeaways
- Amazon S3 is an object storage service.
- Bucket names must be globally unique.
- Static Website Hosting uses a Website Endpoint, not the REST API endpoint.
- Bucket Policies control public access permissions.
- Block Public Access settings override public bucket policies.

## 📚 Related Notes
- [Amazon S3](../notes/aws/s3.md)

## 📖 Related Cheat Sheets
- [AWS CLI Cheat Sheet](../resources/aws-cli-cheatsheet.md)

## 🚀 Related Project
- [AWS S3 Static Website Hosting](../projects/aws-s3-static-website/README.md)

## ⏱️ Time Spent
**2 Hours**

## 📌 Next Step
Learn Amazon CloudFront and Route 53.