#!/bin/bash

# ============================================================
# Project 2: User & Permission Management
# ============================================================
# Purpose:
# Practice Linux user management, group management,
# ownership, permissions, and access control.
# ============================================================


# ============================================================
# 1. Check Current User
# ============================================================

whoami


# ============================================================
# 2. Check Current User Information
# ============================================================

id
id root


# ============================================================
# 3. Create Groups
# ============================================================

sudo groupadd developers
sudo groupadd testers
sudo groupadd managers

# Verify groups
getent group developers
getent group testers
getent group managers


# ============================================================
# 4. Create Users
# ============================================================

sudo useradd developer1
sudo useradd tester1
sudo useradd manager1

# Verify users
id developer1
id tester1
id manager1


# ============================================================
# 5. Set Passwords
# ============================================================

sudo passwd developer1
sudo passwd tester1
sudo passwd manager1


# ============================================================
# 6. Add Users to Groups
# ============================================================

sudo usermod -aG developers developer1
sudo usermod -aG testers tester1
sudo usermod -aG managers manager1

# Verify group membership
groups developer1
groups tester1
groups manager1


# ============================================================
# 7. Check User and Group Information
# ============================================================

id developer1
id tester1
id manager1

getent group developers
getent group testers
getent group managers


# ============================================================
# 8. Create Project Directories
# ============================================================

sudo mkdir -p /opt/company/IT
sudo mkdir -p /opt/company/Testing
sudo mkdir -p /opt/company/Management

# Verify directories
ls -ld /opt/company/*
 
 
# ============================================================
# 9. Create Files
# ============================================================

sudo touch /opt/company/IT/deployment.txt
sudo touch /opt/company/Testing/test-results.txt
sudo touch /opt/company/Management/company-policy.txt

# Verify files
ls -l /opt/company/IT
ls -l /opt/company/Testing
ls -l /opt/company/Management


# ============================================================
# 10. Change File Ownership
# ============================================================

sudo chown developer1:developers /opt/company/IT/deployment.txt
sudo chown tester1:testers /opt/company/Testing/test-results.txt
sudo chown manager1:managers /opt/company/Management/company-policy.txt

# Verify ownership
ls -l /opt/company/IT/deployment.txt
ls -l /opt/company/Testing/test-results.txt
ls -l /opt/company/Management/company-policy.txt


# ============================================================
# 11. Change Group Ownership
# ============================================================

sudo chgrp developers /opt/company/IT/deployment.txt

# Verify
ls -l /opt/company/IT/deployment.txt


# ============================================================
# 12. Configure File Permissions
# ============================================================

# Owner: Read + Write
# Group: Read
# Others: No access

sudo chmod 640 /opt/company/IT/deployment.txt

# Verify
ls -l /opt/company/IT/deployment.txt


# ============================================================
# 13. Configure Directory Permissions
# ============================================================

sudo chmod 750 /opt/company/IT
sudo chmod 750 /opt/company/Testing
sudo chmod 750 /opt/company/Management

# Verify
ls -ld /opt/company/IT
ls -ld /opt/company/Testing
ls -ld /opt/company/Management


# ============================================================
# 14. Test User Switching
# ============================================================

su - developer1

# Check current user
whoami

# Check group membership
groups

# Return to previous user
exit


# ============================================================
# 15. Test File Access
# ============================================================

sudo -u developer1 cat /opt/company/IT/deployment.txt

sudo -u tester1 cat /opt/company/IT/deployment.txt


# ============================================================
# 16. Test Permission Denied
# ============================================================

sudo -u tester1 cat /opt/company/Management/company-policy.txt


# ============================================================
# 17. Check Permissions and Ownership
# ============================================================

ls -l /opt/company/IT
ls -l /opt/company/Testing
ls -l /opt/company/Management

ls -ld /opt/company/IT
ls -ld /opt/company/Testing
ls -ld /opt/company/Management


# ============================================================
# 18. Check User Files
# ============================================================

cat /etc/passwd
sudo cat /etc/shadow

cat /etc/group
sudo cat /etc/gshadow


# ============================================================
# 19. Check User Password Aging
# ============================================================

sudo chage -l developer1
sudo chage -l tester1
sudo chage -l manager1


# ============================================================
# 20. Final Verification
# ============================================================

echo "===== USERS ====="

id developer1
id tester1
id manager1

echo "===== GROUPS ====="

getent group developers
getent group testers
getent group managers

echo "===== FILE OWNERSHIP & PERMISSIONS ====="

ls -l /opt/company/IT
ls -l /opt/company/Testing
ls -l /opt/company/Management

echo "===== DIRECTORY PERMISSIONS ====="

ls -ld /opt/company/IT
ls -ld /opt/company/Testing
ls -ld /opt/company/Management

echo "===== PROJECT COMPLETED ====="