# 🔐 Linux User & Permission Management Lab

A hands-on Linux project demonstrating how to manage **users, groups, ownership, and permissions** in a real-world company-style environment.

The project simulates how different teams in an organization can be given appropriate access to Linux server resources while preventing unauthorized access.

---

## 📌 Project Overview

In a real organization, not every employee should have access to every file or directory.

For example:

- Developers need access to application files.
- DevOps engineers need access to deployment and server files.
- Managers may need access to reports.
- Users should not be able to access resources outside their responsibilities.

This project demonstrates how Linux **Users, Groups, Ownership, and Permissions** can be used to implement this type of access control.

---

## 🎯 Project Objective

The main objectives of this project are:

- Create and manage Linux users
- Create and manage groups
- Add users to appropriate groups
- Create department-specific directories
- Configure group ownership
- Configure Linux permissions
- Test authorized access
- Test unauthorized access
- Understand how Linux access control works

---

## 🏢 Real-World Scenario

Imagine joining a company called **ABC Technologies**.

The company has three departments:

```text
ABC Technologies
│
├── 👨‍💻 Developers
│   ├── Alice
│   └── Bob
│
├── 🛠️ DevOps
│   └── Charlie
│
└── 📊 Managers
    └── David