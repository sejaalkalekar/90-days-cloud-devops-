# IP Addressing & Subnetting Basics

## 1. What is an IP Address?

An **IP (Internet Protocol) address** is a logical address assigned to a device on a network. It allows devices to identify and communicate with each other.

Example:

```text
192.168.1.10
```

An IP address is used for:

* Identifying a device on a network
* Delivering packets to the correct destination
* Communication between devices
* Routing traffic between different networks

---

## 2. IPv4 Address

IPv4 uses a **32-bit address** divided into four 8-bit sections called **octets**.

Example:

```text
192.168.1.10
```

Binary representation:

```text
11000000.10101000.00000001.00001010
```

Each octet can contain a value from:

```text
0 – 255
```

Therefore, an IPv4 address contains:

```text
32 bits = 4 × 8 bits
```

---

## 3. Network Portion and Host Portion

An IPv4 address consists of two logical parts:

```text
Network Portion + Host Portion
```

Example:

```text
192.168.1.10/24
```

With `/24`:

```text
Network: 192.168.1
Host:   10
```

The network portion identifies the network, while the host portion identifies a device within that network.

---

## 4. What is a Subnet Mask?

A **subnet mask** determines which part of an IP address represents the network and which part represents the host.

Example:

```text
IP Address:  192.168.1.10
Subnet Mask: 255.255.255.0
CIDR:        /24
```

Binary:

```text
IP:   11000000.10101000.00000001.00001010
Mask: 11111111.11111111.11111111.00000000
```

`1` bits represent the network portion.

`0` bits represent the host portion.

---

## 5. CIDR Notation

CIDR stands for **Classless Inter-Domain Routing**.

Instead of writing the complete subnet mask, we can use a prefix length.

Example:

```text
192.168.1.10/24
```

`/24` means the first **24 bits** are network bits.

Common examples:

| CIDR | Subnet Mask     | Total Addresses |
| ---- | --------------- | --------------: |
| /8   | 255.0.0.0       |      16,777,216 |
| /16  | 255.255.0.0     |          65,536 |
| /24  | 255.255.255.0   |             256 |
| /25  | 255.255.255.128 |             128 |
| /26  | 255.255.255.192 |              64 |
| /27  | 255.255.255.224 |              32 |
| /28  | 255.255.255.240 |              16 |
| /29  | 255.255.255.248 |               8 |
| /30  | 255.255.255.252 |               4 |

---

## 6. Private IP Addresses

Private IP addresses are used inside local/private networks and are not directly routable on the public Internet.

### Private IPv4 ranges

```text
10.0.0.0/8
```

Range:

```text
10.0.0.0 – 10.255.255.255
```

```text
172.16.0.0/12
```

Range:

```text
172.16.0.0 – 172.31.255.255
```

```text
192.168.0.0/16
```

Range:

```text
192.168.0.0 – 192.168.255.255
```

Examples:

```text
10.0.0.5
172.16.10.20
192.168.1.100
```

---

## 7. Public IP Address

A **public IP address** is globally routable on the Internet.

Example:

```text
8.8.8.8
```

Public IP addresses are generally assigned by Internet service providers or cloud providers.

---

## 8. Network Address

The **network address** identifies the subnet itself.

Example:

```text
IP: 192.168.1.10/24
```

Network address:

```text
192.168.1.0
```

---

## 9. Broadcast Address

The **broadcast address** is used to communicate with all hosts within an IPv4 subnet.

For:

```text
192.168.1.0/24
```

Broadcast address:

```text
192.168.1.255
```

---

## 10. Usable Host Addresses

For a traditional IPv4 subnet, the network address and broadcast address cannot normally be assigned to hosts.

For:

```text
192.168.1.0/24
```

We have:

```text
Network Address:   192.168.1.0
First Host:        192.168.1.1
Last Host:         192.168.1.254
Broadcast:         192.168.1.255
```

Usable hosts:

```text
254
```

Formula:

```text
Usable Hosts = 2^host_bits - 2
```

For `/24`:

```text
Host bits = 32 - 24 = 8

2^8 - 2
= 256 - 2
= 254
```

---

## 11. What is Subnetting?

**Subnetting** is the process of dividing one large network into smaller networks called **subnets**.

Example:

```text
192.168.1.0/24
```

can be divided into smaller `/26` networks:

```text
192.168.1.0/26
192.168.1.64/26
192.168.1.128/26
192.168.1.192/26
```

Each `/26` subnet contains:

```text
64 total addresses
62 usable host addresses
```

---

## 12. Why Do We Use Subnetting?

Subnetting helps with:

* Efficient IP address utilization
* Network organization
* Network security
* Reducing broadcast domains
* Separating departments or workloads
* Better network management
* Designing cloud networks

Example:

```text
Company Network
      |
      +-- HR Subnet
      |
      +-- IT Subnet
      |
      +-- Finance Subnet
      |
      +-- Management Subnet
```

---

## 13. Subnetting Example

Given:

```text
Network: 192.168.10.0/24
```

Suppose we need **4 subnets**.

### Step 1: Borrow bits

To create 4 subnets:

```text
2^2 = 4
```

Borrow 2 host bits.

Original:

```text
/24
```

New prefix:

```text
/26
```

### Step 2: Calculate subnet size

```text
32 - 26 = 6 host bits

2^6 = 64 addresses
```

Each subnet has:

```text
64 total addresses
62 usable hosts
```

### Step 3: Identify the subnets

```text
Subnet 1:
192.168.10.0/26
Hosts: 192.168.10.1 – 192.168.10.62
Broadcast: 192.168.10.63

Subnet 2:
192.168.10.64/26
Hosts: 192.168.10.65 – 192.168.10.126
Broadcast: 192.168.10.127

Subnet 3:
192.168.10.128/26
Hosts: 192.168.10.129 – 192.168.10.190
Broadcast: 192.168.10.191

Subnet 4:
192.168.10.192/26
Hosts: 192.168.10.193 – 192.168.10.254
Broadcast: 192.168.10.255
```

---

## 14. Subnetting Quick Reference

| CIDR | Host Bits | Total IPs | Usable Hosts |
| ---- | --------: | --------: | -----------: |
| /24  |         8 |       256 |          254 |
| /25  |         7 |       128 |          126 |
| /26  |         6 |        64 |           62 |
| /27  |         5 |        32 |           30 |
| /28  |         4 |        16 |           14 |
| /29  |         3 |         8 |            6 |
| /30  |         2 |         4 |            2 |

Formula:

```text
Host Bits = 32 - Prefix Length

Total Addresses = 2^Host Bits

Usable Hosts = 2^Host Bits - 2
```

---

## 15. Default Gateway

A **default gateway** is the device, usually a router, that forwards traffic from the local network to other networks.

Example:

```text
PC
 |
 | 192.168.1.10
 |
Router
 |
 | 192.168.1.1
 |
Internet
```

The PC can use:

```text
Default Gateway: 192.168.1.1
```

---

## 16. DNS vs IP Address

An IP address identifies a device/network location.

DNS translates human-readable domain names into IP addresses.

Example:

```text
www.example.com
       ↓
DNS
       ↓
93.x.x.x
```

---

## 17. Useful Linux Commands

### Display IP addresses

```bash
ip addr
```

or:

```bash
ip a
```

### Display routing table

```bash
ip route
```

### Check default gateway

```bash
ip route | grep default
```

### Test connectivity

```bash
ping 8.8.8.8
```

### Test DNS resolution

```bash
nslookup google.com
```

or:

```bash
dig google.com
```

### Display network interfaces

```bash
ip link
```

---

## 18. Practical Example

Suppose a Linux server has:

```text
IP Address: 192.168.10.20/24
Gateway:    192.168.10.1
DNS:        8.8.8.8
```

This means:

```text
Network:       192.168.10.0
Server IP:     192.168.10.20
Gateway:       192.168.10.1
Broadcast:     192.168.10.255
Usable Range:  192.168.10.1 – 192.168.10.254
```

---

## 19. Cloud Networking Connection

IP addressing and subnetting are fundamental concepts in AWS networking.

For example, an AWS VPC may use:

```text
VPC
10.0.0.0/16
```

The VPC can then be divided into subnets:

```text
10.0.1.0/24 → Public Subnet
10.0.2.0/24 → Public Subnet
10.0.3.0/24 → Private Subnet
10.0.4.0/24 → Private Subnet
```

This allows different workloads to be separated logically.

Example:

```text
                VPC
            10.0.0.0/16
                 |
       +---------+---------+
       |                   |
   Public Subnets      Private Subnets
       |                   |
      ALB                EC2/RDS
```

---

## 20. Interview Questions

### Q1. What is an IP address?

An IP address is a logical address used to identify a device or network interface and enable communication over an IP network.

### Q2. What is subnetting?

Subnetting is the process of dividing a larger IP network into smaller logical networks.

### Q3. What is CIDR?

CIDR stands for Classless Inter-Domain Routing. It represents an IP network using an IP address and prefix length, such as:

```text
192.168.1.0/24
```

### Q4. How many usable hosts are available in a /24 network?

```text
2^8 - 2 = 254
```

So, a traditional `/24` IPv4 subnet has **254 usable host addresses**.

### Q5. What is the difference between public and private IP?

A private IP is used within private networks and is not directly routable over the Internet. A public IP is globally routable and can be used for Internet communication.

### Q6. What is a default gateway?

A default gateway is the router or network device used to forward traffic destined for networks outside the local subnet.

### Q7. Why is subnetting important in cloud networking?

Subnetting allows cloud networks to be logically segmented, improving organization, routing control, security, and IP address utilization.

---

## 21. Key Takeaways

```text
IPv4 = 32 bits
1 Octet = 8 bits
CIDR = Network Prefix Length
/24 = 255.255.255.0
/24 = 256 total addresses
/24 = 254 traditional usable hosts

Private IPv4:
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16

Subnetting = Dividing a network into smaller networks
```

### Important for Cloud/DevOps

Before working with AWS VPCs, EC2, load balancers, RDS, routing tables, and security groups, understand:

* IPv4 addressing
* CIDR notation
* Subnet masks
* Network and broadcast addresses
* Private/public IPs
* Subnetting
* Default gateways
* Routing basics
* DNS basics
