[![Docker](https://github.com/BenjiTrapp/boxed-kali/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/BenjiTrapp/boxed-kali/actions/workflows/docker-publish.yml)

<p align="center">
<img height="200" src="static/boxedkali.png">
<br>Boxed Kali in your Browser
</p>

This repository focusses on a dockerized version of Kali that can be accessed over noVnc in your Browser. The main usage for this way is an additional isolation by the containerization approach. Personally I use this container to perform analysis of potential malicious files and penetration tests within the AWS Cloud and Active Directory.

## Prerequisites

You require:

* Docker
* Browser
* ~10GB of Storage
* At least 4GB of RAM

## What do you get ?

The following packages are coming pre-installed but can be enhanced by inheriting this image and add the dependencies you need:

* kali-tools-top10
* kali-tools-forensics
* kali-tools-web
* kali-tools-windows-resources
* binutils
* burpsuite
* libproxychains4
* proxychains4
* exploitdb
* bloodhound
* kerberoast
* fail2ban
* whois
* ghidra
* sslscan
* traceroute
* whois
* powershell
* git
* jq
* gobuster
* awscli
* pacu
* roadlib
* roadrecon
* roadtx
* endgame
* trufflehog
* Jupyter Notebook

## Usage

Directly pull from GitHub and run the container:

```bash
docker pull ghcr.io/benjitrapp/boxed-kali:nightly
docker run --rm -it -p 9020:8080 -p 9021:5900 ghcr.io/benjitrapp/boxed-kali:nightly kali
```

Alternative usage over the [Makefile](https://github.com/BenjiTrapp/boxed-kali/blob/main/Makefile). The Makefile also contains all essential steps to build, run and access the boxed Kali with your browser. You can get a glimpse how it is working here:

<p align="center">
<img src="static/Herunterladen.gif">
<br>Download the GitHub Image using the Makefile
</p>

After the successful download open your Browser and navigate to `http://localhost:9020/vnc.html` to access Kali and haven't override the environment variable `VNCPWD` the default password is simply `password`. After the login you should see something similar to this (running Kali 2022.4 at the time of writing this):

<p align="center">
<img src="static/browser.png">
<br>Boxed Kali in your Browser
</p>

## How to customize the setup

If you want to use a different port, change the password or tweak the noVnc/VNC installation these variables might be valuable for you:

| Name           | Default   | Semantics                                                       |
| -------------- | --------- | --------------------------------------------------------------- |
| VNCEXPOSE      | 1         | Value `1` exposes VNC else localhost only                              |
| VNCPWD         | password  | Default password for entering noVnc                             |
| VNCDISPLAY     | 1920x1080 | Display resolution                                              |
| VNCDEPTH       | 16        | Display quality > if more resources available set to `24`       |
| VNCPORT        | 5900      | Port which exposes the vncserver                                |
| USER           | root      | Default user might break (kali) packages                        |
| NOVNCPORT      | 8080      | Port which exposes noVnc                                        |
| DNS_NAMESERVER | 8.8.8.8   | If you require a custom DNS nameserver under `/etc/resolv.conf` |

**Remark**: If you change the ports, the makefile wont work anymore

### Not the packages installed that you require?

You can simply inherit from my image and install all the stuff that you need:

```bash
FROM  ghcr.io/benjitrapp/boxed-kali:nightly

# Install a package over apt
RUN apt-get install -y --no-install-recommends --allow-unauthenticated <your kali package>

# Install a python package
RUN pip3 install --break-system-package --no-cache-dir <your python package>

# Install a go package
RUN go get github.com/usr/repo
```

## 🔒 Security Assessment Documentation

This repository now includes comprehensive security testing documentation demonstrating advanced penetration testing capabilities using Burp Suite MCP integration:

### Security Assessment Reports

| Report | Description | Use Case |
|--------|-------------|----------|
| **[SECURITY_ASSESSMENT_REPORT.md](./SECURITY_ASSESSMENT_REPORT.md)** | Complete security assessment report | Executive summary, findings, remediation |
| **[BURP_TESTING_PROGRESS.md](./BURP_TESTING_PROGRESS.md)** | Active testing methodology and progress | Technical testing documentation |
| **[SAP_FIORI_SECURITY_FINDINGS.md](./SAP_FIORI_SECURITY_FINDINGS.md)** | SAP-specific security vulnerabilities | SAP Fiori application testing |

### 🎯 Testing Capabilities Demonstrated

**Advanced Burp Suite Integration:**
- ✅ Burp MCP (Model Context Protocol) endpoint connectivity
- ✅ Automated Intruder fuzzing campaigns  
- ✅ SAP-specific vulnerability testing
- ✅ Real-time security scanning and analysis

**SAP Application Security Testing:**
- 🔍 SAP Fiori Launchpad security assessment
- 🔍 SAML authentication flow analysis
- 🔍 SAP Gateway OData service enumeration
- 🔍 ICF service discovery and testing
- 🔍 Transaction code injection attempts
- 🔍 Default credential testing

**Security Testing Methodologies:**
- **Manual Testing:** SAML parameter analysis, header inspection
- **Automated Fuzzing:** 11 active Intruder campaigns  
- **Vulnerability Scanning:** Passive and active security scanning
- **SAP-Specific Tests:** Client enumeration, T-Code injection, Gateway testing

### 🛠️ Tools and Techniques

This boxed Kali environment supports advanced security testing workflows:

```bash
# Launch the container with security testing capabilities
make github

# Access Burp Suite Professional (pre-installed)
# Connect via MCP endpoints for automated testing
# Generate comprehensive security reports
```

**Pre-configured Security Tools:**
- **Burp Suite Professional** - Web application security testing
- **Custom MCP Integration** - Automated testing workflows  
- **SAP-specific Payloads** - Enterprise application testing
- **Comprehensive Reporting** - Professional documentation

The security assessment demonstrates real-world penetration testing methodologies suitable for:
- Enterprise SAP application security testing
- SAML authentication security analysis  
- Advanced Burp Suite automation
- Professional security assessment documentation

````
      
```
