# SSH: Secure Remote Access

## 1. What is SSH?

**SSH (Secure Shell)** is a network protocol used to securely connect to and manage a remote computer or server over a network.

Using SSH, you can:

* Log in to a remote Linux server
* Run commands remotely
* Manage files and directories
* Transfer files securely
* Execute scripts remotely
* Perform server administration
* Create secure tunnels and port forwarding

### Simple Example

Suppose your laptop is in Pune and your AWS EC2 Linux server is running somewhere else.

Using SSH, you can securely connect to that server:

```bash
ssh ec2-user@192.168.1.10
```

After connecting, you can run commands on the remote server as if you were sitting directly in front of it.

---

# 2. Why Do We Need SSH?

Earlier, remote connections often used protocols such as **Telnet**.

The problem with Telnet is that communication can be sent in **plain text**, meaning usernames, passwords, and commands may be exposed.

SSH solves this problem by encrypting the communication.

### SSH Provides

* **Confidentiality** – Data is encrypted.
* **Authentication** – Verifies the identity of users and servers.
* **Integrity** – Helps detect whether data was modified during transmission.
* **Secure remote access** – Safely manage remote systems.

---

# 3. How SSH Works

SSH follows a **client-server architecture**.

```text
+------------------+          Encrypted Connection          +------------------+
|                  |  ==================================>   |                  |
|   SSH Client     |                                       |   SSH Server     |
|                  |                                       |                  |
| Laptop / Local   |                                       | Remote Linux     |
| Machine          |                                       | Server           |
+------------------+                                       +------------------+
```

### SSH Client

The computer from which you initiate the connection.

Examples:

* Your laptop
* Your desktop
* A jump server

### SSH Server

The remote machine you want to access.

The SSH service usually runs as:

```text
sshd
```

---

# 4. Default SSH Port

SSH uses **port 22** by default.

```text
Client
   |
   | SSH Connection
   | Port 22
   v
Remote Server
```

You can verify whether SSH is listening on port 22:

```bash
ss -tulpn | grep ssh
```

Or:

```bash
sudo netstat -tulpn | grep ssh
```

> `netstat` may not be installed on all modern Linux systems.

---

# 5. SSH Architecture

SSH communication involves three important components:

1. **SSH Client**
2. **SSH Server**
3. **SSH Keys**

### Connection Flow

```text
SSH Client
    |
    | 1. Requests connection
    v
SSH Server
    |
    | 2. Server identity is verified
    v
Authentication
    |
    | 3. Password or SSH key authentication
    v
Encrypted SSH Session
    |
    v
Remote Server Access
```

---

# 6. Installing SSH

## On Ubuntu/Debian

Install the SSH server:

```bash
sudo apt update
sudo apt install openssh-server -y
```

Check its status:

```bash
sudo systemctl status ssh
```

Start the service:

```bash
sudo systemctl start ssh
```

Enable SSH at boot:

```bash
sudo systemctl enable ssh
```

---

## On RHEL/CentOS/Amazon Linux

Install OpenSSH server:

```bash
sudo yum install openssh-server -y
```

On newer systems, you may use:

```bash
sudo dnf install openssh-server -y
```

Check the status:

```bash
sudo systemctl status sshd
```

Start SSH:

```bash
sudo systemctl start sshd
```

Enable it at system boot:

```bash
sudo systemctl enable sshd
```

---

# 7. Checking the SSH Service

Check whether SSH is running:

```bash
sudo systemctl status sshd
```

On Ubuntu, the service may be called:

```bash
sudo systemctl status ssh
```

Check whether SSH is enabled:

```bash
sudo systemctl is-enabled sshd
```

Restart SSH:

```bash
sudo systemctl restart sshd
```

Reload SSH configuration without completely stopping the service:

```bash
sudo systemctl reload sshd
```

---

# 8. Basic SSH Connection

The basic syntax is:

```bash
ssh username@hostname
```

Example:

```bash
ssh sejal@192.168.1.100
```

You can also use a domain name:

```bash
ssh user@example.com
```

After entering the command, SSH may ask for the user's password:

```text
user@192.168.1.100's password:
```

Enter the password to connect.

---

# 9. Connecting Using a Specific Port

If SSH is configured on a port other than 22, use the `-p` option.

```bash
ssh -p 2222 username@server-ip
```

Example:

```bash
ssh -p 2222 ec2-user@192.168.1.100
```

---

# 10. SSH Authentication Methods

SSH supports multiple authentication methods.

The most common are:

1. Password authentication
2. Public key authentication

```text
              SSH Authentication
                     |
          +----------+----------+
          |                     |
     Password                SSH Keys
          |                     |
      Less secure          More secure
```

---

# 11. Password Authentication

With password authentication, you enter the remote user's password:

```bash
ssh username@server-ip
```

Example:

```bash
ssh sejal@192.168.1.100
```

Then enter:

```text
Password: ********
```

### Disadvantages

Password authentication can be vulnerable to:

* Brute-force attacks
* Weak passwords
* Password theft

For production servers, **SSH key-based authentication is generally preferred**.

---

# 12. SSH Key-Based Authentication

SSH key authentication uses a pair of cryptographic keys:

```text
Private Key  <---------------->  Public Key
```

### Private Key

* Stays on your local computer
* Must be kept secret
* Never share it publicly

### Public Key

* Can be placed on the remote server
* Used by the server to verify your identity

---

# 13. Creating an SSH Key Pair

Use:

```bash
ssh-keygen
```

You may see something like:

```text
Generating public/private rsa key pair.
Enter file in which to save the key:
```

Press **Enter** to use the default location.

SSH will create files inside:

```text
~/.ssh/
```

Example:

```text
~/.ssh/id_rsa
~/.ssh/id_rsa.pub
```

### Files

```text
id_rsa       → Private key
id_rsa.pub   → Public key
```

For modern systems, you can explicitly create an Ed25519 key:

```bash
ssh-keygen -t ed25519
```

Ed25519 is a commonly recommended modern key type.

---

# 14. The `.ssh` Directory

SSH-related files are commonly stored in:

```bash
~/.ssh
```

Check its contents:

```bash
ls -la ~/.ssh
```

Common files include:

```text
~/.ssh/
├── id_rsa
├── id_rsa.pub
├── id_ed25519
├── id_ed25519.pub
├── authorized_keys
├── known_hosts
└── config
```

### What Do These Files Do?

| File              | Purpose                                           |
| ----------------- | ------------------------------------------------- |
| `id_rsa`          | RSA private key                                   |
| `id_rsa.pub`      | RSA public key                                    |
| `id_ed25519`      | Ed25519 private key                               |
| `id_ed25519.pub`  | Ed25519 public key                                |
| `authorized_keys` | Allowed public keys for server login              |
| `known_hosts`     | Stores identities of previously connected servers |
| `config`          | Stores SSH client configuration                   |

---

# 15. Copying the Public Key to a Server

The easiest method is:

```bash
ssh-copy-id username@server-ip
```

Example:

```bash
ssh-copy-id sejal@192.168.1.100
```

This copies your public key to:

```text
~/.ssh/authorized_keys
```

on the remote server.

After that, you can connect using:

```bash
ssh sejal@192.168.1.100
```

without entering the account password.

---

# 16. Manual Public Key Setup

If `ssh-copy-id` is not available, copy the public key manually.

First, display the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the output.

On the remote server, create the `.ssh` directory if needed:

```bash
mkdir -p ~/.ssh
```

Add the public key:

```bash
nano ~/.ssh/authorized_keys
```

Paste the public key into the file.

Set the correct permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

---

# 17. SSH Key Permissions

Correct permissions are very important.

### Local Private Key

```bash
chmod 600 ~/.ssh/id_ed25519
```

Or:

```bash
chmod 400 ~/.ssh/id_ed25519
```

### SSH Directory

```bash
chmod 700 ~/.ssh
```

### Public Key

Usually:

```bash
chmod 644 ~/.ssh/id_ed25519.pub
```

### Remote Authorized Keys

```bash
chmod 600 ~/.ssh/authorized_keys
```

If permissions are too open, SSH may reject the key for security reasons.

---

# 18. Connecting Using a Private Key

Use the `-i` option:

```bash
ssh -i /path/to/private-key username@server-ip
```

Example:

```bash
ssh -i ~/.ssh/my-key.pem ec2-user@server-ip
```

For an AWS EC2 instance:

```bash
ssh -i my-key.pem ec2-user@ec2-public-ip
```

Set secure permissions first:

```bash
chmod 400 my-key.pem
```

---

# 19. SSH Host Key Verification

When connecting to a server for the first time, you may see:

```text
The authenticity of host can't be established.
Are you sure you want to continue connecting (yes/no)?
```

This happens because your system has not seen that server before.

After accepting, the server's identity is stored in:

```text
~/.ssh/known_hosts
```

The next time you connect, SSH compares the server's identity with the stored information.

### Why Is This Important?

It helps protect against situations where someone tries to impersonate the real server.

---

# 20. `known_hosts` File

View known hosts:

```bash
cat ~/.ssh/known_hosts
```

If a server's SSH host key changes, you may receive a warning such as:

```text
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
```

This can happen if:

* The server was rebuilt
* The server's SSH keys changed
* The IP address now belongs to a different server

Do **not** blindly ignore this warning.

If you have verified that the change is legitimate, remove the old entry:

```bash
ssh-keygen -R server-ip
```

Example:

```bash
ssh-keygen -R 192.168.1.100
```

Then reconnect and verify the new host key.

---

# 21. SSH Server Configuration File

The main SSH server configuration file is commonly:

```text
/etc/ssh/sshd_config
```

You can view it using:

```bash
sudo cat /etc/ssh/sshd_config
```

Or edit it:

```bash
sudo nano /etc/ssh/sshd_config
```

After making changes, test the configuration:

```bash
sudo sshd -t
```

If there are no errors, reload or restart SSH:

```bash
sudo systemctl reload sshd
```

> Always test the configuration before restarting SSH. A wrong configuration can lock you out of a remote server.

---

# 22. Important SSH Configuration Options

## Change SSH Port

Default:

```text
Port 22
```

You can change it:

```text
Port 2222
```

Then restart or reload SSH.

Connect using:

```bash
ssh -p 2222 username@server-ip
```

> Changing the port may reduce unwanted automated scans, but it should not be treated as the main security control.

---

## Disable Root Login

```text
PermitRootLogin no
```

This prevents direct SSH login as the root user.

Instead:

```text
User → SSH Login → sudo
```

This is generally safer because administration actions can be controlled and audited.

---

## Disable Password Authentication

After confirming that SSH key authentication works:

```text
PasswordAuthentication no
```

This forces users to authenticate with approved SSH keys instead of passwords.

**Important:** Test key-based login before disabling password authentication.

---

## Enable Public Key Authentication

```text
PubkeyAuthentication yes
```

This allows authentication using SSH public/private key pairs.

---

## Limit Specific Users

Allow only selected users:

```text
AllowUsers sejal devops admin
```

You can also restrict groups:

```text
AllowGroups sshusers
```

---

# 23. SSH Client Configuration

The SSH client configuration file is:

```text
~/.ssh/config
```

This file allows you to create easy names for servers.

Example:

```text
Host aws-server
    HostName 192.168.1.100
    User ec2-user
    IdentityFile ~/.ssh/my-key.pem
```

Now, instead of writing:

```bash
ssh -i ~/.ssh/my-key.pem ec2-user@192.168.1.100
```

you can simply write:

```bash
ssh aws-server
```

This is very useful when managing multiple servers.

---

# 24. Example SSH Config for Multiple Servers

```text
Host dev-server
    HostName 10.0.1.10
    User ubuntu
    IdentityFile ~/.ssh/dev-key

Host prod-server
    HostName 10.0.2.10
    User ec2-user
    IdentityFile ~/.ssh/prod-key
    Port 2222
```

Connect using:

```bash
ssh dev-server
```

or:

```bash
ssh prod-server
```

---

# 25. SSH Agent

An **SSH agent** stores private keys in memory.

This means you may not need to repeatedly provide your passphrase.

Start the agent:

```bash
eval "$(ssh-agent -s)"
```

Add your private key:

```bash
ssh-add ~/.ssh/id_ed25519
```

View loaded keys:

```bash
ssh-add -l
```

Remove all keys from the agent:

```bash
ssh-add -D
```

---

# 26. Copying Files Using SCP

**SCP (Secure Copy Protocol)** allows you to transfer files securely using SSH.

## Copy Local File to Remote Server

```bash
scp file.txt username@server-ip:/remote/path/
```

Example:

```bash
scp notes.txt sejal@192.168.1.100:/home/sejal/
```

---

## Copy Remote File to Local System

```bash
scp username@server-ip:/remote/path/file.txt .
```

Example:

```bash
scp sejal@192.168.1.100:/home/sejal/notes.txt .
```

---

## Copy a Directory

Use `-r`:

```bash
scp -r project/ username@server-ip:/home/sejal/
```

---

## Use a Specific SSH Key

```bash
scp -i my-key.pem file.txt ec2-user@server-ip:/home/ec2-user/
```

---

# 27. File Transfer Using SFTP

**SFTP (SSH File Transfer Protocol)** provides secure file transfer over SSH.

Connect:

```bash
sftp username@server-ip
```

Useful commands:

```bash
ls
```

List remote files.

```bash
pwd
```

Show the current remote directory.

```bash
lpwd
```

Show the current local directory.

```bash
put file.txt
```

Upload a file.

```bash
get file.txt
```

Download a file.

```bash
mkdir folder
```

Create a remote directory.

```bash
exit
```

Exit SFTP.

---

# 28. SCP vs SFTP

| Feature             | SCP             | SFTP                         |
| ------------------- | --------------- | ---------------------------- |
| Main purpose        | Quick file copy | File transfer and management |
| Interactive mode    | No              | Yes                          |
| Uses SSH            | Yes             | Yes                          |
| Security            | Encrypted       | Encrypted                    |
| Resume/manage files | Limited         | More flexible                |

---

# 29. Running Remote Commands Without Logging In Interactively

You can execute a command directly on a remote server:

```bash
ssh username@server-ip "command"
```

Example:

```bash
ssh sejal@192.168.1.100 "uptime"
```

Check disk space:

```bash
ssh sejal@192.168.1.100 "df -h"
```

Check running processes:

```bash
ssh sejal@192.168.1.100 "ps aux"
```

This is useful for:

* Automation
* Scripts
* Server monitoring
* DevOps tasks

---

# 30. SSH Port Forwarding

SSH can securely forward network traffic between systems.

There are three main types:

1. Local port forwarding
2. Remote port forwarding
3. Dynamic port forwarding

---

# 31. Local Port Forwarding

Local port forwarding allows you to access a remote service through your local machine.

Example:

```bash
ssh -L 8080:localhost:80 user@server-ip
```

Meaning:

```text
localhost:8080
      |
      | SSH Tunnel
      v
Remote Server
      |
      v
localhost:80
```

You can open:

```text
http://localhost:8080
```

and securely access the remote service.

### Example Use Case

Access a private database or internal web application without exposing it publicly.

---

# 32. Remote Port Forwarding

Remote port forwarding exposes a local service through a remote server.

Example:

```bash
ssh -R 8080:localhost:3000 user@remote-server
```

Conceptually:

```text
Remote Server:8080
        |
        | SSH Tunnel
        v
Your Local Machine:3000
```

This can be useful when your local system needs to make a service available through a remote server.

---

# 33. Dynamic Port Forwarding

Dynamic forwarding creates a SOCKS proxy.

Example:

```bash
ssh -D 1080 username@server-ip
```

Applications configured to use the SOCKS proxy can send their traffic through the SSH connection.

---

# 34. SSH Jump Host / Bastion Host

A **Jump Host** or **Bastion Host** is an intermediate server used to access private servers.

```text
Your Laptop
     |
     | SSH
     v
Jump Host
     |
     | SSH
     v
Private Server
```

You can use:

```bash
ssh -J user@jump-host user@private-server
```

Example:

```bash
ssh -J ubuntu@jump.example.com ubuntu@10.0.2.10
```

This is commonly used in cloud environments where private servers do not have public IP addresses.

---

# 35. SSH ProxyJump Configuration

Instead of writing a long command every time:

```bash
ssh -J ubuntu@jump-host ubuntu@10.0.2.10
```

configure it in:

```text
~/.ssh/config
```

Example:

```text
Host jump-host
    HostName jump.example.com
    User ubuntu

Host private-server
    HostName 10.0.2.10
    User ubuntu
    ProxyJump jump-host
```

Now simply run:

```bash
ssh private-server
```

---

# 36. SSH in AWS EC2

SSH is commonly used to connect to Linux EC2 instances.

Example:

```bash
ssh -i my-key.pem ec2-user@public-ip
```

The username depends on the operating system.

Common examples:

| Operating System | Common Username |
| ---------------- | --------------- |
| Amazon Linux     | `ec2-user`      |
| Ubuntu           | `ubuntu`        |
| CentOS           | `centos`        |
| RHEL             | `ec2-user`      |

Example:

```bash
ssh -i my-key.pem ubuntu@54.x.x.x
```

Before connecting, make sure:

* The EC2 instance is running.
* The correct public IP/DNS is used.
* The correct username is used.
* The private key is correct.
* SSH permissions are secure.
* The Security Group allows the required SSH traffic.

---

# 37. SSH Security Best Practices

For secure SSH access:

### 1. Use SSH Keys

Prefer key-based authentication over passwords.

### 2. Protect Your Private Key

Never:

* Share it publicly
* Upload it to GitHub
* Send it through insecure channels
* Commit `.pem` files to Git

### 3. Disable Root Login

```text
PermitRootLogin no
```

### 4. Disable Password Authentication

After verifying key-based login:

```text
PasswordAuthentication no
```

### 5. Allow Only Required Users

```text
AllowUsers sejal admin
```

### 6. Keep OpenSSH Updated

Regularly update your operating system and security packages.

### 7. Use a Firewall

Allow SSH only where required.

### 8. Limit Network Access

For example, in cloud environments, allow SSH only from trusted IP addresses when possible.

### 9. Use MFA or Centralized Access Where Appropriate

For production infrastructure, organizations may use additional identity controls instead of relying only on static SSH keys.

### 10. Monitor SSH Logs

Regularly check login attempts and suspicious activity.

---

# 38. SSH Logs

On Ubuntu/Debian, authentication logs are commonly found at:

```text
/var/log/auth.log
```

View SSH-related logs:

```bash
sudo grep ssh /var/log/auth.log
```

On RHEL-based systems, logs are commonly found at:

```text
/var/log/secure
```

View them:

```bash
sudo grep ssh /var/log/secure
```

You can also use `journalctl`:

```bash
sudo journalctl -u sshd
```

---

# 39. Common SSH Errors and Troubleshooting

## Error: Connection Refused

```text
ssh: connect to host x.x.x.x port 22: Connection refused
```

### Possible Causes

* SSH service is not running.
* SSH is listening on another port.
* A firewall is rejecting the connection.

### Check

```bash
sudo systemctl status sshd
```

Check listening ports:

```bash
sudo ss -tulpn | grep ssh
```

---

## Error: Connection Timed Out

```text
Connection timed out
```

### Possible Causes

* Wrong IP address
* Firewall blocking traffic
* Security Group blocking SSH
* Server is unreachable
* Network routing problem

Test connectivity:

```bash
ping server-ip
```

> Some servers block ICMP/ping, so a failed ping does not always mean SSH is unavailable.

---

## Error: Permission Denied

```text
Permission denied (publickey)
```

### Possible Causes

* Wrong private key
* Public key is missing from `authorized_keys`
* Wrong username
* Incorrect permissions
* Server does not accept the authentication method

Use verbose mode:

```bash
ssh -v username@server-ip
```

For more details:

```bash
ssh -vvv username@server-ip
```

---

## Error: Private Key Permissions Are Too Open

Example:

```text
WARNING: UNPROTECTED PRIVATE KEY FILE!
```

Fix it:

```bash
chmod 400 my-key.pem
```

or:

```bash
chmod 600 my-key.pem
```

---

## Error: Host Key Verification Failed

You may see:

```text
Host key verification failed
```

If you have verified that the server's host key legitimately changed, remove the old entry:

```bash
ssh-keygen -R server-ip
```

Then reconnect.

---

# 40. SSH Verbose Mode

Verbose mode helps troubleshoot SSH problems.

Basic debugging:

```bash
ssh -v username@server-ip
```

More details:

```bash
ssh -vv username@server-ip
```

Maximum common verbosity:

```bash
ssh -vvv username@server-ip
```

This helps you understand:

* Which keys SSH is trying
* Whether authentication succeeds
* Connection problems
* Configuration being used

---

# 41. Useful SSH Commands Cheat Sheet

### Connect to a Server

```bash
ssh username@server-ip
```

### Connect Using a Specific Port

```bash
ssh -p 2222 username@server-ip
```

### Connect Using a Private Key

```bash
ssh -i key.pem username@server-ip
```

### Generate a Key

```bash
ssh-keygen -t ed25519
```

### Copy Public Key

```bash
ssh-copy-id username@server-ip
```

### Remove a Known Host

```bash
ssh-keygen -R server-ip
```

### Debug SSH

```bash
ssh -vvv username@server-ip
```

### Copy a File to Remote Server

```bash
scp file.txt username@server-ip:/path/
```

### Copy a File from Remote Server

```bash
scp username@server-ip:/path/file.txt .
```

### Start SSH Agent

```bash
eval "$(ssh-agent -s)"
```

### Add a Key

```bash
ssh-add ~/.ssh/id_ed25519
```

### Run a Remote Command

```bash
ssh username@server-ip "uptime"
```

### Local Port Forwarding

```bash
ssh -L local-port:destination:destination-port username@server
```

### Connect Through a Jump Host

```bash
ssh -J user@jump-host user@private-server
```

---

# 42. Important SSH Files

## On the Client

```text
~/.ssh/config
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
~/.ssh/known_hosts
```

## On the Server

```text
/etc/ssh/sshd_config
~/.ssh/authorized_keys
```

---

# 43. SSH Connection Process – Step by Step

When you run:

```bash
ssh username@server-ip
```

SSH generally follows this process:

### Step 1: Client Contacts the Server

The SSH client sends a connection request to the SSH server.

Usually through:

```text
Port 22
```

### Step 2: Server Identity Is Checked

The client checks the server's host key.

If this is the first connection, you are asked to verify it.

The server identity is stored in:

```text
~/.ssh/known_hosts
```

### Step 3: Secure Encryption Is Established

The client and server establish an encrypted communication channel.

### Step 4: User Authentication

The server verifies the user using methods such as:

```text
Password
    OR
SSH Public Key
```

### Step 5: Secure Session Starts

After successful authentication:

```text
You → Encrypted SSH Connection → Remote Server
```

You can now safely run commands.

---

# 44. SSH vs Telnet

| Feature           | SSH           | Telnet           |
| ----------------- | ------------- | ---------------- |
| Default Port      | 22            | 23               |
| Encryption        | Yes           | No               |
| Security          | High          | Low              |
| Authentication    | Password/Keys | Usually password |
| Recommended Today | Yes           | No               |

**SSH is preferred because it encrypts communication.**

---

# 45. SSH vs RDP

| SSH                               | RDP                            |
| --------------------------------- | ------------------------------ |
| Mainly command-line remote access | Mainly graphical remote access |
| Common for Linux/Unix servers     | Common for Windows systems     |
| Lightweight                       | More resource-intensive        |
| Default port 22                   | Default port 3389              |

---

# 46. SSH in DevOps

SSH is widely used in DevOps and cloud environments.

Common use cases include:

```text
Developer/DevOps Engineer
          |
          | SSH
          v
Linux Server / EC2
          |
          +--> Deploy application
          |
          +--> Check logs
          |
          +--> Restart services
          |
          +--> Run scripts
          |
          +--> Troubleshoot issues
          |
          +--> Manage configuration
```

### Example

Check application status:

```bash
ssh user@server "systemctl status nginx"
```

Restart a service:

```bash
ssh user@server "sudo systemctl restart nginx"
```

Check disk usage:

```bash
ssh user@server "df -h"
```

---

# 47. Important Points to Remember

* SSH stands for **Secure Shell**.
* SSH provides secure remote access to systems.
* The default SSH port is **22**.
* SSH follows a **client-server model**.
* `sshd` is the SSH server service.
* SSH encrypts communication.
* Key-based authentication uses a **private key** and **public key**.
* Never share your private key.
* Public keys are commonly stored in `authorized_keys`.
* Server identities are stored in `known_hosts`.
* The main server configuration file is usually `/etc/ssh/sshd_config`.
* Use `ssh -vvv` for detailed troubleshooting.
* `scp` and `sftp` allow secure file transfers.
* SSH supports port forwarding and tunneling.
* SSH can connect through a jump/bastion host.
* Always test SSH configuration changes before restarting the service.

---

# 48. SSH Interview Questions

### Q1. What is SSH?

**SSH (Secure Shell) is a secure network protocol used to remotely access and manage servers. It encrypts communication between the client and server and supports authentication using passwords or SSH keys.**

---

### Q2. What is the default port of SSH?

**SSH uses port 22 by default.**

---

### Q3. What is the difference between SSH and Telnet?

**SSH encrypts communication and is secure, while Telnet sends communication without encryption and is not considered secure for remote administration.**

---

### Q4. What is the difference between a public key and a private key?

**The public key is placed on the server and can be shared, while the private key remains securely with the user and must never be shared. Together, they are used for SSH key-based authentication.**

---

### Q5. Where are authorized SSH public keys stored?

They are commonly stored in:

```text
~/.ssh/authorized_keys
```

---

### Q6. What is the `known_hosts` file?

**The `known_hosts` file stores information about SSH servers that a client has previously connected to. SSH uses it to help verify the identity of those servers during future connections.**

---

### Q7. What is the SSH server configuration file?

Commonly:

```text
/etc/ssh/sshd_config
```

---

### Q8. How do you troubleshoot an SSH connection?

**I first check network connectivity, verify the server IP and port, check whether the SSH service is running, verify firewall or Security Group rules, confirm the username and SSH key, check file permissions, and use `ssh -vvv` for detailed debugging.**

---

### Q9. What is an SSH Jump Host?

**An SSH Jump Host, also called a Bastion Host, is an intermediate server used to securely access servers in a private network that are not directly accessible from the internet.**

---

### Q10. How do you make SSH more secure?

**I use key-based authentication, protect private keys, disable direct root login where appropriate, disable password authentication after verifying SSH keys, restrict allowed users, limit network access with firewalls or Security Groups, keep OpenSSH updated, and monitor authentication logs.**

---

# Conclusion

SSH is one of the most important tools for **Linux, AWS Cloud, and DevOps engineers**. It provides secure remote access, encrypted communication, key-based authentication, secure file transfer, tunneling, and remote command execution.

The basic idea is simple:

```text
Your Computer
      |
      | Secure + Encrypted SSH Connection
      v
Remote Linux Server
      |
      +--> Run commands
      +--> Manage services
      +--> Transfer files
      +--> Troubleshoot
      +--> Automate tasks
```

Learning SSH properly is essential because secure remote access is used regularly when working with Linux servers, cloud infrastructure, automation, deployments, and DevOps environments.
