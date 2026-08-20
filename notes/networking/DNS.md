# DNS Made Easy: Complete Beginner-Friendly Notes

> **DNS is one of the most important networking concepts for Linux, Cloud, DevOps, and AWS.**
> These notes explain DNS from the basics to practical troubleshooting in simple language.

---

# Table of Contents

1. What is DNS?
2. Why do we need DNS?
3. How DNS works
4. What happens when you open Google?
5. DNS hierarchy
6. DNS resolver
7. Recursive vs iterative queries
8. DNS records
9. DNS caching and TTL
10. DNS zones and authoritative servers
11. Forward and reverse DNS
12. DNS ports and protocols
13. DNS and DHCP
14. DNS in Linux
15. Important DNS commands
16. DNS troubleshooting
17. DNS security
18. DNS in AWS and Cloud
19. Common DNS problems
20. Interview questions and answers
21. Quick revision

---

# 1. What is DNS?

**DNS stands for Domain Name System.**

DNS translates a human-readable domain name into an IP address.

For example:

```text
google.com
    ↓
DNS
    ↓
IP Address
```

We remember names such as:

```text
google.com
amazon.com
github.com
```

But computers communicate with each other using IP addresses.

DNS works like the **phonebook of the Internet**.

### Simple example

```text
www.example.com
        ↓
       DNS
        ↓
192.0.2.10
```

---

# 2. Why Do We Need DNS?

Imagine if you had to remember the IP address of every website.

Instead of typing:

```text
google.com
```

you would need to remember an IP address.

That would be difficult because websites can also use multiple IP addresses, and those addresses can change.

DNS allows us to use easy-to-remember names instead.

### In simple words

```text
Humans use names
        ↓
DNS translates
        ↓
Computers use IP addresses
```

---

# 3. Important DNS Components

Before understanding the complete DNS process, learn these important terms.

## DNS Client

The device or application requesting DNS information.

Examples:

* Your laptop
* Browser
* Linux server
* Application running on an EC2 instance

Example:

```text
Your Browser
     |
     | "What is the IP of google.com?"
     v
DNS System
```

---

## DNS Resolver

A **DNS resolver** receives DNS queries and finds the answer.

It is also commonly called a:

* Recursive resolver
* Recursive DNS server

The resolver may be provided by:

* Your ISP
* Your company
* Your router
* A cloud provider
* A public DNS service

Example:

```text
Your Computer
      |
      v
DNS Resolver
      |
      v
Finds the IP address
```

---

## Root DNS Server

Root DNS servers are at the top of the public DNS hierarchy.

They do not usually provide the final IP address for a website.

Instead, they help direct the resolver to the correct **Top-Level Domain (TLD)** servers.

Example:

```text
Who handles .com?
      ↓
Root DNS
      ↓
Ask the .com TLD servers
```

---

## TLD DNS Server

TLD stands for **Top-Level Domain**.

Examples:

```text
.com
.org
.net
.in
.edu
```

A TLD server helps the resolver find the authoritative DNS servers for a domain.

Example:

```text
google.com
       |
       v
.com TLD Server
       |
       v
Google's Authoritative DNS Servers
```

---

## Authoritative DNS Server

An authoritative DNS server contains the DNS records for a domain or DNS zone.

For example:

```text
example.com
     |
     v
Authoritative DNS Server
     |
     +-- A Record
     +-- AAAA Record
     +-- MX Record
     +-- CNAME Record
```

This server provides the authoritative answer for records in the zone it manages.

---

# 4. How DNS Works

Let's understand the basic DNS process.

You type:

```text
google.com
```

The system needs to find:

```text
"What is the IP address for google.com?"
```

The simplified process is:

```text
User
  |
  v
Browser
  |
  v
DNS Cache
  |
  v
DNS Resolver
  |
  v
Root DNS
  |
  v
TLD DNS
  |
  v
Authoritative DNS
  |
  v
IP Address
```

Once the IP address is found, the browser can connect to the destination.

---

# 5. What Happens When You Open Google?

Suppose you enter:

```text
https://www.google.com
```

in your browser.

Here is the simplified process.

## Step 1: Browser checks its cache

The browser may already know the IP address from a previous lookup.

```text
Browser Cache
      |
      | Found?
      +---- Yes → Use the cached information
      |
      +---- No → Continue DNS lookup
```

---

## Step 2: System checks local DNS information

If needed, the operating system checks its DNS-related configuration and local information.

A local hosts file can also provide hostname mappings.

On Linux:

```text
/etc/hosts
```

Example:

```text
192.168.1.10   myserver
```

Now:

```text
myserver
   ↓
192.168.1.10
```

No public DNS lookup is needed for that specific local mapping.

---

## Step 3: Query the DNS resolver

If the answer is not available locally, the system sends a query to its configured DNS resolver.

Example:

```text
Your Laptop
     |
     | Where is google.com?
     v
DNS Resolver
```

The resolver first checks its own cache.

If it already knows the answer and the cached record is still valid, it returns the result.

---

## Step 4: Resolver contacts the Root DNS system

If the resolver does not know the answer, it begins following the DNS hierarchy.

```text
Resolver
    |
    | Where can I find .com?
    v
Root DNS
```

The root server directs the resolver toward the `.com` TLD servers.

---

## Step 5: Resolver contacts the TLD server

```text
Resolver
    |
    | Who handles google.com?
    v
.com TLD Server
```

The TLD server provides information about the authoritative name servers responsible for the domain.

---

## Step 6: Resolver contacts the authoritative server

```text
Resolver
    |
    | What is the record for www.google.com?
    v
Authoritative DNS Server
```

The authoritative server provides the appropriate DNS answer.

---

## Step 7: IP address is returned

The response travels back:

```text
Authoritative Server
        ↓
DNS Resolver
        ↓
Your Computer
        ↓
Browser
```

The browser now has the information needed to connect to the website.

---

# 6. Complete Flow: Opening a Website

The complete simplified flow is:

```text
1. User enters google.com
          |
          v
2. Browser checks cache
          |
          v
3. Local system checks hostname resolution
          |
          v
4. DNS Resolver
          |
          v
5. Root DNS
          |
          v
6. .com TLD DNS
          |
          v
7. Authoritative DNS
          |
          v
8. DNS answer / IP address
          |
          v
9. Browser connects to destination
          |
          v
10. HTTPS/TLS security
          |
          v
11. HTTP request
          |
          v
12. Server response
          |
          v
13. Browser renders webpage
```

### Important

**DNS does not load the website.**

DNS primarily helps resolve a name into an IP address or provides other DNS information.

After DNS resolution, other protocols are involved.

For example:

```text
DNS  → Finds destination information
IP   → Network addressing and routing
TCP/QUIC → Transport
TLS  → Security
HTTP → Web request and response
```

---

# 7. DNS Hierarchy

The public DNS system is hierarchical.

```text
                    Root
                     |
          ---------------------
          |         |         |
        .com       .org      .net
          |
       example
          |
        www
```

For:

```text
www.example.com
```

The hierarchy is:

```text
Root
  ↓
.com
  ↓
example.com
  ↓
www.example.com
```

---

# 8. Recursive vs Iterative DNS Queries

This is an important interview topic.

## Recursive Query

The client asks the resolver to find the final answer.

Example:

```text
Client
   |
   | "Find the IP for google.com"
   v
Recursive Resolver
```

The resolver performs the work and returns the final answer.

### Simple meaning

> **The resolver finds the answer for you.**

---

## Iterative Query

A DNS server gives the requester the best answer or referral it has.

Example:

```text
Resolver → Root Server
```

The root server may say:

```text
"I don't have the final answer.
Ask the .com TLD servers."
```

Then:

```text
Resolver → .com TLD Server
```

The TLD server may say:

```text
"Ask these authoritative name servers."
```

### Simple meaning

> **The DNS servers guide the requester toward the answer.**

---

# 9. DNS Records

DNS stores different types of information using **DNS records**.

These are very important for Cloud and DevOps engineers.

---

## A Record

An **A record** maps a domain or hostname to an IPv4 address.

```text
example.com
     ↓
A Record
     ↓
192.0.2.10
```

Remember:

```text
A = IPv4 Address
```

---

## AAAA Record

An **AAAA record** maps a hostname to an IPv6 address.

```text
example.com
     ↓
AAAA Record
     ↓
IPv6 Address
```

Remember:

```text
A     = IPv4
AAAA  = IPv6
```

---

## CNAME Record

**CNAME stands for Canonical Name.**

It creates an alias from one hostname to another hostname.

Example:

```text
www.example.com
       ↓
example.com
```

Or:

```text
app.example.com
       ↓
my-application.example.net
```

### Important

A CNAME points to a **hostname**, not directly to an IP address.

---

## MX Record

**MX stands for Mail Exchange.**

It specifies mail servers responsible for receiving email for a domain.

Example:

```text
example.com
     |
     v
MX Record
     |
     v
mail.example.com
```

MX records are important for email delivery.

---

## NS Record

**NS stands for Name Server.**

It identifies the authoritative name servers for a DNS zone.

Example:

```text
example.com
     |
     v
NS Records
     |
     +-- ns1.example.com
     |
     +-- ns2.example.com
```

---

## TXT Record

A TXT record stores text information.

Common uses include:

* Domain ownership verification
* SPF configuration
* DKIM-related configuration
* Service verification
* Security-related configuration

Example:

```text
example.com
     |
     v
TXT Record
     |
     v
Verification / Email / Other Metadata
```

---

## PTR Record

A PTR record is used for **reverse DNS**.

Normal DNS:

```text
Hostname → IP Address
```

Reverse DNS:

```text
IP Address → Hostname
```

Example:

```text
192.0.2.10
     ↓
PTR Record
     ↓
server.example.com
```

---

## SRV Record

An SRV record provides information about the location of a specific service.

It can specify information such as:

* Service
* Protocol
* Port
* Target hostname

It is commonly used by applications and enterprise services.

---

## SOA Record

**SOA stands for Start of Authority.**

It contains important administrative information about a DNS zone.

Conceptually, it identifies key information about the zone and its DNS management.

---

## CAA Record

A CAA record can specify which Certificate Authorities are allowed to issue certificates for a domain.

This is useful for controlling certificate issuance.

---

# 10. DNS Record Quick Reference

| Record | Purpose                                           |
| ------ | ------------------------------------------------- |
| A      | Hostname → IPv4 address                           |
| AAAA   | Hostname → IPv6 address                           |
| CNAME  | Hostname alias → Another hostname                 |
| MX     | Mail server information                           |
| NS     | Authoritative name servers                        |
| TXT    | Text, verification, email/security configuration  |
| PTR    | IP address → Hostname                             |
| SRV    | Service location information                      |
| SOA    | DNS zone authority and administrative information |
| CAA    | Controls allowed certificate authorities          |

### Easy way to remember

```text
A     → IPv4
AAAA  → IPv6
CNAME → Alias
MX    → Mail
NS    → Name Server
PTR   → Reverse Lookup
TXT   → Text/Verification
```

---

# 11. What is DNS Caching?

DNS caching means temporarily storing DNS answers.

Example:

```text
google.com → IP address
```

Instead of asking DNS servers again every time, the answer can be reused while it remains valid.

Caching can happen at different levels:

```text
Browser Cache
      ↓
Operating System Cache
      ↓
DNS Resolver Cache
```

### Benefits

* Faster DNS resolution
* Reduced network traffic
* Reduced load on DNS servers
* Better performance

---

# 12. What is TTL?

**TTL stands for Time To Live.**

It determines how long a DNS answer can normally be cached.

Example:

```text
example.com
TTL = 300 seconds
```

This means the DNS answer can generally be cached for:

```text
5 minutes
```

After the TTL expires, a new lookup may be required.

### Simple example

```text
DNS Record
    |
    | TTL = 300 seconds
    v
Cached
    |
    v
TTL expires
    |
    v
Fresh DNS lookup may be needed
```

---

# 13. Why Is TTL Important?

TTL creates a balance between caching and receiving updated DNS information.

### Short TTL

```text
Faster DNS changes
```

But it can result in more DNS queries.

### Long TTL

```text
More caching
```

But changes may take longer to be reflected by caches that still hold older information.

This is important when changing:

* Application endpoints
* Load balancers
* Servers
* Cloud infrastructure
* DNS providers

---

# 14. DNS Zone

A **DNS zone** is an administrative portion of the DNS namespace.

For example:

```text
example.com
```

A DNS zone may contain records such as:

```text
example.com
├── A
├── MX
├── NS
├── TXT
└── CNAME
```

A DNS zone is managed by authoritative DNS servers.

---

# 15. Authoritative vs Recursive DNS

## Recursive DNS Resolver

Its job is to find the DNS answer for the client.

```text
Client
   |
   v
Recursive Resolver
   |
   v
DNS Hierarchy
```

### Main job

> Find the answer.

---

## Authoritative DNS Server

Its job is to provide authoritative records for a DNS zone.

```text
example.com
     |
     v
Authoritative DNS Server
     |
     v
DNS Records
```

### Main job

> Store and provide the official DNS records for the zone.

---

# 16. Forward DNS Lookup

Forward lookup means:

```text
Hostname → IP Address
```

Example:

```text
google.com
    ↓
IP Address
```

Command:

```bash
nslookup google.com
```

or:

```bash
dig google.com
```

---

# 17. Reverse DNS Lookup

Reverse lookup means:

```text
IP Address → Hostname
```

Example:

```text
192.0.2.10
     ↓
server.example.com
```

Reverse DNS commonly uses PTR records.

Example command:

```bash
dig -x 8.8.8.8
```

---

# 18. DNS Ports and Protocols

DNS commonly uses:

```text
Port 53
```

### UDP

Standard DNS queries commonly use:

```text
UDP 53
```

### TCP

DNS can also use:

```text
TCP 53
```

TCP is used in situations where TCP is required, such as certain DNS operations and some larger responses.

### Remember

```text
DNS
├── UDP 53
└── TCP 53
```

---

# 19. DNS over HTTPS and DNS over TLS

Traditional DNS queries are not necessarily encrypted between the client and its DNS resolver.

Modern technologies include:

## DoH — DNS over HTTPS

DNS queries are sent using HTTPS.

```text
Client
   |
   | HTTPS
   v
DNS Resolver
```

---

## DoT — DNS over TLS

DNS queries are protected using TLS.

```text
Client
   |
   | TLS
   v
DNS Resolver
```

These technologies can improve privacy and security for DNS communication between the client and resolver.

---

# 20. DNS and DHCP

DNS and DHCP are different services.

## DHCP

DHCP provides network configuration automatically.

It can provide:

```text
IP Address
Subnet Mask
Default Gateway
DNS Server
```

---

## DNS

DNS translates names into IP addresses.

```text
google.com
    ↓
IP Address
```

### Easy comparison

| DHCP                                           | DNS                          |
| ---------------------------------------------- | ---------------------------- |
| Provides network configuration                 | Resolves names               |
| Can assign IP addresses                        | Finds IP addresses for names |
| Can provide gateway and DNS server information | Returns DNS records          |

### Easy way to remember

```text
DHCP → "How should I configure my network?"

DNS → "What IP address belongs to this name?"
```

---

# 21. DNS in Linux

Linux systems need DNS configuration to resolve domain names.

Important commands include:

```bash
cat /etc/resolv.conf
```

Depending on the Linux distribution and configuration, DNS may also be managed by services such as NetworkManager or systemd-resolved.

Useful command:

```bash
resolvectl status
```

if the system uses `systemd-resolved`.

---

# 22. The `/etc/hosts` File

The hosts file allows local hostname-to-IP mappings.

On Linux:

```text
/etc/hosts
```

Example:

```text
127.0.0.1 localhost
192.168.1.10 myserver
```

Now:

```text
myserver
    ↓
192.168.1.10
```

This is useful for:

* Local testing
* Development environments
* Temporary hostname mappings
* Troubleshooting

---

# 23. The `/etc/resolv.conf` File

This file can show DNS resolver configuration.

Example:

```text
nameserver 8.8.8.8
nameserver 1.1.1.1
```

This tells the system which DNS resolvers to use.

Check it with:

```bash
cat /etc/resolv.conf
```

> On many modern Linux systems, this file may be generated or managed automatically. Do not assume manual changes will always persist.

---

# 24. Useful DNS Commands

## `nslookup`

Used to query DNS information.

```bash
nslookup google.com
```

Query a specific DNS server:

```bash
nslookup google.com 8.8.8.8
```

---

## `dig`

`dig` provides detailed DNS information.

```bash
dig google.com
```

Query an A record:

```bash
dig google.com A
```

Query an AAAA record:

```bash
dig google.com AAAA
```

Query MX records:

```bash
dig google.com MX
```

Query NS records:

```bash
dig google.com NS
```

Query TXT records:

```bash
dig google.com TXT
```

---

## Trace DNS Resolution

```bash
dig +trace google.com
```

This helps demonstrate the DNS hierarchy.

Conceptually:

```text
Root
  ↓
TLD
  ↓
Authoritative Server
  ↓
Answer
```

---

## Reverse DNS Lookup

```bash
dig -x 8.8.8.8
```

or:

```bash
nslookup 8.8.8.8
```

---

## Check DNS Configuration

```bash
cat /etc/resolv.conf
```

On systems using `systemd-resolved`:

```bash
resolvectl status
```

---

## Check Local Network Information

```bash
ip addr
```

Check the routing table:

```bash
ip route
```

---

# 25. DNS Troubleshooting

Suppose a user says:

> "I cannot open google.com."

Do not immediately assume DNS is the problem.

Troubleshoot step by step.

---

## Step 1: Check Network Interface

```bash
ip addr
```

Check whether the network interface has an IP address.

---

## Step 2: Check Default Gateway

```bash
ip route
```

Look for something similar to:

```text
default via <GATEWAY_IP>
```

---

## Step 3: Test Basic Connectivity

Test connectivity to a known IP:

```bash
ping 8.8.8.8
```

If basic IP connectivity fails, the problem may be related to:

* Network interface
* Route
* Gateway
* Firewall
* Internet connectivity

---

## Step 4: Test DNS Resolution

```bash
nslookup google.com
```

or:

```bash
dig google.com
```

If these commands fail, investigate DNS configuration and connectivity to the DNS resolver.

---

## Step 5: Check Configured DNS Servers

```bash
cat /etc/resolv.conf
```

or, where applicable:

```bash
resolvectl status
```

Check whether a valid DNS resolver is configured.

---

# 26. Common DNS Troubleshooting Scenario

Suppose:

```text
ping 8.8.8.8       → Works
ping google.com    → Fails
```

This may indicate a DNS resolution problem.

Possible checks:

```bash
nslookup google.com
dig google.com
cat /etc/resolv.conf
ip route
```

Possible causes include:

* Incorrect DNS server configuration
* DNS server unreachable
* Firewall blocking DNS traffic
* Incorrect local hostname configuration
* DNS resolver problem

---

# 27. Another Troubleshooting Scenario

Suppose:

```text
nslookup google.com
```

works, but:

```text
Website does not open
```

This does **not automatically mean DNS is working perfectly for the application**, but it does show that the tested DNS lookup succeeded.

The problem could instead be related to:

* HTTP/HTTPS connectivity
* Firewall rules
* Proxy configuration
* TLS/certificate issues
* Application or server problems
* Routing problems

Test web connectivity:

```bash
curl -I https://google.com
```

A good troubleshooting engineer separates:

```text
DNS Problem
        vs
Network Connectivity Problem
        vs
Application Problem
```

---

# 28. DNS Security Concepts

DNS is an important part of infrastructure, so DNS security matters.

Common concerns include:

* DNS spoofing
* DNS cache poisoning
* DNS-based attacks
* Unauthorized DNS changes
* DNS amplification attacks

Important protections and technologies include:

* DNSSEC
* Access control
* Secure DNS management
* DNS over HTTPS
* DNS over TLS
* Monitoring and logging

---

# 29. What is DNSSEC?

**DNSSEC stands for Domain Name System Security Extensions.**

DNSSEC adds mechanisms that help DNS resolvers verify the authenticity and integrity of DNS data.

Simplified idea:

```text
DNS Answer
    +
Cryptographic Validation
    ↓
More confidence that the DNS data is authentic
```

DNSSEC does not simply mean that all DNS traffic is encrypted.

---

# 30. DNS in Cloud and DevOps

DNS is extremely important in Cloud and DevOps environments.

You may use DNS for:

* Application domains
* Load balancers
* Microservices
* Kubernetes services
* Internal services
* API endpoints
* Email configuration
* Domain verification
* SSL/TLS certificate validation
* Failover and traffic routing

---

# 31. DNS Example in AWS

In AWS, DNS is commonly used with services such as:

```text
Application
     |
     v
DNS
     |
     v
Load Balancer
     |
     v
EC2 Instances / Containers
```

For example:

```text
www.example.com
       |
       v
DNS Record
       |
       v
Application Load Balancer
       |
       v
EC2 / ECS / Other Application Resources
```

DNS allows users to access an application using a stable domain name instead of remembering infrastructure IP addresses.

---

# 32. Public DNS vs Private DNS

## Public DNS

Used for publicly accessible resources.

Example:

```text
www.example.com
```

Users on the Internet can resolve the public DNS record.

---

## Private DNS

Used inside private networks.

Example:

```text
database.internal
```

Private DNS can help internal applications communicate using names instead of hard-coded IP addresses.

This is useful in:

* AWS VPCs
* Kubernetes clusters
* Corporate networks
* Internal microservices

---

# 33. Why DNS Is Important in DevOps

Imagine an application server changes.

Without DNS:

```text
Application
    ↓
Hard-coded IP address
    ↓
Server changes
    ↓
Configuration must be updated
```

With DNS:

```text
Application
    ↓
app.example.com
    ↓
DNS record updated
    ↓
New infrastructure
```

DNS provides flexibility and abstraction between applications and underlying infrastructure.

This is one reason DNS is important in:

* Cloud migration
* Blue/Green deployments
* Load balancing
* Failover
* High availability

---

# 34. DNS and Load Balancing

A domain can direct users toward load balancing infrastructure.

Example:

```text
Users
  |
  v
www.example.com
  |
  v
DNS
  |
  v
Load Balancer
  |
  +---------+
  |         |
  v         v
Server 1  Server 2
```

The DNS layer and load balancer perform different jobs.

### DNS

Helps clients find the destination.

### Load Balancer

Distributes application traffic according to its configuration.

---

# 35. DNS Interview Questions and Answers

## Q1. What is DNS?

**Answer:**

DNS stands for Domain Name System. It translates human-readable domain names into IP addresses and provides other DNS information through records such as A, AAAA, MX, and CNAME records.

---

## Q2. What happens when you type `google.com` into a browser?

**Answer:**

The browser first checks available cached DNS information. If the required answer is not available locally, the system queries a DNS resolver. If the resolver does not have a valid cached answer, it follows the DNS hierarchy by obtaining information from the root, TLD, and authoritative DNS servers. After receiving the required DNS answer, the browser can connect to the destination, establish a secure connection for HTTPS, send the HTTP request, and receive the response.

---

## Q3. What is the difference between a recursive and authoritative DNS server?

**Answer:**

A recursive DNS resolver finds answers on behalf of clients. An authoritative DNS server provides the official DNS records for the DNS zone it manages.

---

## Q4. What is an A record?

**Answer:**

An A record maps a hostname to an IPv4 address.

```text
example.com → IPv4 address
```

---

## Q5. What is an AAAA record?

**Answer:**

An AAAA record maps a hostname to an IPv6 address.

---

## Q6. What is a CNAME record?

**Answer:**

A CNAME record creates an alias from one hostname to another hostname.

---

## Q7. What is TTL in DNS?

**Answer:**

TTL stands for Time To Live. It specifies how long DNS information can generally be cached before a fresh lookup may be required.

---

## Q8. What is the difference between DNS and DHCP?

**Answer:**

DHCP provides network configuration, such as IP address, gateway, and DNS server information. DNS resolves names and returns DNS records, such as mapping a hostname to an IP address.

---

## Q9. Which port does DNS use?

**Answer:**

DNS commonly uses port 53. DNS commonly uses UDP for standard queries and can also use TCP when required.

---

## Q10. What is reverse DNS?

**Answer:**

Reverse DNS maps an IP address back to a hostname and commonly uses PTR records.

---

## Q11. What is DNS caching?

**Answer:**

DNS caching stores DNS answers temporarily so future requests can be answered faster without repeating the entire lookup process.

---

## Q12. How would you troubleshoot a DNS issue in Linux?

**Answer:**

I would first verify basic network connectivity using `ip addr`, `ip route`, and appropriate connectivity tests. Then I would test DNS resolution using `nslookup` or `dig`. I would check the configured DNS resolvers using `/etc/resolv.conf` or `resolvectl status`, depending on the system, and determine whether the issue is local configuration, DNS resolver connectivity, or DNS resolution itself.

---

# 36. Quick Revision Cheat Sheet

```text
DNS = Domain Name System

Main Purpose:
Domain Name → IP Address

Example:
google.com → IP address
```

### DNS Lookup Flow

```text
Browser/Client
      ↓
Cache / Local Resolution
      ↓
Recursive Resolver
      ↓
Root
      ↓
TLD
      ↓
Authoritative Server
      ↓
DNS Answer
```

### Important Records

```text
A     → IPv4
AAAA  → IPv6
CNAME → Alias
MX    → Mail
NS    → Name Server
TXT   → Text / Verification
PTR   → Reverse DNS
SRV   → Service
SOA   → Zone Authority Information
CAA   → Certificate Authority Control
```

### Important Commands

```bash
nslookup google.com
dig google.com
dig google.com A
dig google.com AAAA
dig google.com MX
dig google.com NS
dig google.com TXT
dig +trace google.com
dig -x 8.8.8.8
cat /etc/resolv.conf
resolvectl status
ip addr
ip route
curl -I https://google.com
```

### Important Ports

```text
DNS → UDP 53
DNS → TCP 53
```

---

# Key Takeaways

* DNS translates domain names into IP addresses and provides other DNS information.
* DNS follows a hierarchical structure involving root, TLD, and authoritative servers.
* Recursive resolvers find answers on behalf of clients.
* Authoritative servers provide official DNS records for their zones.
* DNS records have different purposes, including A, AAAA, CNAME, MX, NS, TXT, and PTR.
* TTL controls how long DNS answers can generally be cached.
* DNS troubleshooting requires separating DNS issues from general network and application connectivity issues.
* DNS is a fundamental skill for Linux, AWS, Cloud, and DevOps engineers.
* Understanding DNS is essential for working with applications, load balancers, internal services, cloud infrastructure, and production troubleshooting.

---

## Final Mental Model

```text
User enters a domain name
          ↓
DNS finds the destination
          ↓
Client gets DNS answer
          ↓
Network connection is established
          ↓
TLS secures HTTPS communication
          ↓
HTTP request is sent
          ↓
Server sends response
          ↓
Browser/Application processes the response
```

> **Remember: DNS answers the question "Where should I go?" It is one of the first important steps before an application can communicate with a service using its domain name.**
