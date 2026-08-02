# 🌐 TCP/IP Model

## 📖 Introduction

The **TCP/IP (Transmission Control Protocol / Internet Protocol)** Model is the standard networking model used on the **Internet** and in **modern cloud environments**.

Unlike the **OSI Model**, which has **7 layers**, the **TCP/IP Model has 4 layers** and is used in real-world networking.

Every time you:

- 🌍 Open a website
- 📧 Send an email
- ☁️ Connect to AWS
- 🔑 SSH into an EC2 instance
- 📦 Download a file

...your computer uses the **TCP/IP Model**.

---

# 🎯 Why Cloud Engineers Should Learn TCP/IP

Almost every AWS service communicates using the TCP/IP model.

Understanding TCP/IP helps you troubleshoot:

- EC2 Connectivity Issues
- SSH Problems
- Website Not Opening
- DNS Failures
- Load Balancer Issues
- API Communication
- VPC Networking

---

# 🏗️ TCP/IP Architecture

```
+---------------------------+
| Application Layer         |
+---------------------------+
| Transport Layer           |
+---------------------------+
| Internet Layer            |
+---------------------------+
| Network Access Layer      |
+---------------------------+
```

---

# 📚 TCP/IP Layers

| Layer | Responsibility |
|--------|----------------|
| Application | User Applications |
| Transport | Reliable Communication |
| Internet | Routing & IP Addressing |
| Network Access | Physical Network Communication |

---

# 🟦 Layer 4 – Application Layer

## 📖 What is it?

The Application Layer provides network services directly to users and applications.

This is where users interact with the network.

Examples

- Web Browser
- Email
- FTP
- SSH
- DNS

---

## Common Protocols

| Protocol | Purpose |
|----------|---------|
| HTTP | Websites |
| HTTPS | Secure Websites |
| DNS | Domain Name Resolution |
| FTP | File Transfer |
| SMTP | Sending Emails |
| SSH | Remote Login |

---

## AWS Examples

- Route 53
- API Gateway
- Application Load Balancer
- CloudFront

---

## Real-world Example

```
https://amazon.com
```

The browser starts communication at the Application Layer.

---

# 🟨 Layer 3 – Transport Layer

## 📖 What is it?

The Transport Layer ensures that data is delivered correctly between two devices.

It is responsible for:

- Reliable communication
- Error checking
- Data segmentation
- Port numbers
- Flow control

---

## Two Main Protocols

### TCP (Transmission Control Protocol)

Reliable communication.

Features

- Connection-oriented
- Error checking
- Packet recovery
- Ordered delivery

Examples

- HTTPS
- SSH
- FTP
- Email

---

### UDP (User Datagram Protocol)

Fast communication.

Features

- No error checking
- No acknowledgements
- Faster than TCP

Examples

- Video Streaming
- Online Gaming
- Voice Calls
- DNS Queries

---

# 📌 Common Ports

| Service | Port |
|----------|------|
| SSH | 22 |
| FTP | 21 |
| HTTP | 80 |
| HTTPS | 443 |
| SMTP | 25 |
| DNS | 53 |

---

## AWS Examples

- Security Groups
- Network Load Balancer

---

# 🟥 Layer 2 – Internet Layer

## 📖 What is it?

The Internet Layer is responsible for routing packets between networks using IP addresses.

Responsibilities

- IP Addressing
- Routing
- Packet Forwarding

---

## Common Protocols

- IP
- ICMP
- ARP

---

## AWS Examples

- VPC
- Route Tables
- Internet Gateway
- NAT Gateway
- Transit Gateway
- Network ACL

---

# 🟩 Layer 1 – Network Access Layer

## 📖 What is it?

This layer handles communication with the physical network.

Responsibilities

- Sending data over cables or Wi-Fi
- MAC Addressing
- Ethernet Communication

---

## Technologies

- Ethernet
- Wi-Fi
- Fiber
- Switches

---

# 📦 Data Encapsulation

When data is sent, each TCP/IP layer adds its own information.

```
Application Data
↓

TCP Segment

↓

IP Packet

↓

Ethernet Frame

↓

Bits
```

At the destination, these headers are removed in reverse order.

---

# 🌍 Real-world Example

Suppose you open

```
https://github.com
```

### Step 1

Application Layer

Browser creates an HTTPS request.

↓

### Step 2

Transport Layer

TCP establishes a reliable connection using Port **443**.

↓

### Step 3

Internet Layer

IP determines the destination IP address and routes the packet.

↓

### Step 4

Network Access Layer

The data is transmitted through Ethernet or Wi-Fi to the destination server.

↓

GitHub's server receives the request and sends a response back.

---

# 🔄 TCP Three-Way Handshake

Before TCP sends data, it establishes a connection using the **Three-Way Handshake**.

### Step 1

Client sends

```
SYN
```

---

### Step 2

Server replies

```
SYN + ACK
```

---

### Step 3

Client responds

```
ACK
```

Connection Established ✅

```
Client              Server

SYN  ------------>

      <--------- SYN + ACK

ACK  ------------>

Connection Ready
```

---

# ❌ TCP Connection Termination

When communication is complete, TCP closes the connection using a **Four-Way Handshake**.

```
FIN

ACK

FIN

ACK
```

---

# 🆚 TCP vs UDP

| Feature | TCP | UDP |
|----------|-----|-----|
| Reliable | ✅ | ❌ |
| Connection | Connection-Oriented | Connectionless |
| Speed | Slower | Faster |
| Error Checking | Yes | No |
| Packet Ordering | Yes | No |
| Used For | Web, SSH, FTP | Streaming, Gaming, DNS |

---

# 🔄 TCP/IP vs OSI Model

| OSI Model | TCP/IP Model |
|------------|--------------|
| Application | Application |
| Presentation | Application |
| Session | Application |
| Transport | Transport |
| Network | Internet |
| Data Link | Network Access |
| Physical | Network Access |

---

# ☁️ AWS Services Mapped to TCP/IP Layers

| AWS Service | TCP/IP Layer |
|-------------|--------------|
| Route 53 | Application |
| API Gateway | Application |
| CloudFront | Application |
| Application Load Balancer | Application |
| SSH | Application |
| Security Groups | Transport |
| Network Load Balancer | Transport |
| VPC | Internet |
| Route Tables | Internet |
| Internet Gateway | Internet |
| NAT Gateway | Internet |
| Network ACL | Internet |
| EC2 Network Interface (ENI) | Network Access |

---

# 🌍 Common Troubleshooting Based on TCP/IP Layers

| Problem | Layer |
|----------|-------|
| Website Not Opening | Application |
| SSH Connection Refused | Transport |
| Port 22 Closed | Transport |
| Incorrect Route Table | Internet |
| Wrong IP Address | Internet |
| Cable/Wi-Fi Issue | Network Access |

---

# 📝 Common Networking Commands

## Check IP Address

```bash
ip addr
```

---

## Check Routing Table

```bash
ip route
```

---

## Test Connectivity

```bash
ping google.com
```

---

## Trace Packet Route

```bash
traceroute google.com
```

---

## Display Listening Ports

```bash
ss -tuln
```

---

## DNS Lookup

```bash
nslookup google.com
```

---

# ⭐ Best Practices

- ✔ Understand the responsibility of each TCP/IP layer.
- ✔ Learn common TCP/UDP ports (22, 80, 443, 53).
- ✔ Use TCP for reliable communication and UDP for speed-sensitive applications.
- ✔ Use networking tools like `ping`, `traceroute`, and `ss` for troubleshooting.
- ✔ Know how AWS networking services map to the TCP/IP model.
- ✔ Always troubleshoot from the bottom layer upward to isolate network issues efficiently.

---

# 📝 Quick Summary

| Layer | Responsibility | Examples |
|--------|----------------|----------|
| Application | User Services | HTTP, HTTPS, SSH, DNS |
| Transport | Reliable Communication | TCP, UDP |
| Internet | Routing & IP Addressing | IP, ICMP, ARP |
| Network Access | Physical Communication | Ethernet, Wi-Fi |

---
