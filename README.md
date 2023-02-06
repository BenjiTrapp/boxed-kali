<p align="center">
<img height="200" src="static/boxed-kali.png">
<br>Boxed Kali in your Browser
</p>

This repository focusses on a dockerized version of Kali that can be accessed over NoVNC in your Browser. The main usage for this way is an additional isolation by the containerization approach. Personally I use this container to perform analysis of potential malicious files and penetration tests within the AWS Cloud and Active Directory.

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
gobuster



## Usage

Directly pull from GitHub and run the container:

```bash
docker pull ghcr.io/benjitrapp/boxed-kali:nightly
docker run --rm -it -p 9020:8080 -p 9021:5900 ghcr.io/benjitrapp/boxed-kali:nightly kali
```
Alternative usage over the [Makefile](https://github.com/BenjiTrapp/boxed-kali/blob/main/Makefile). The Makefile also contains all essential steps to build, run and access the boxed Kali with your browser. You can get a glimpse how it is working here:

<p align="center">
<img src="static/Herunterladen.gif">
<br>Boxed Kali in your Browser
</p>
