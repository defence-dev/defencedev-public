
# Installation Guide

This guide explains how to install the adapted FortiGate WAN1 automation script.
Login credentials are stored in the configuration file.

## 1. Requirements
- Ubuntu/Debian-based system
- `sshpass` installed
- SSH access to your FortiGate
- Correct credentials (username/password)
- Modified script with correct HOST/USER/PASSWORD values

## 2. Install Required Packages
```bash
sudo apt update
sudo apt install -y sshpass openssh-client
```

## 3. Create Log Directory
The script writes logs to:
```
/opt/scripts/log/
```
Create it manually:
```bash
sudo mkdir -p /opt/scripts/log
sudo chmod 777 /opt/scripts/log
```
(Adjust permissions as needed.)

## 4. Edit Script Parameters
Open the script:
```bash
nano config.sh
```
Update:
```
HOST="HOST_IP"
USER="USER"
PASSWORD="PASSWORD"
PORT=11022
```

## 5. Run Script
```bash
chmod +x fgt_gw_check.sh
./fgt_gw_check.sh
```

## 6. What the Script Does
- Connects via SSH using `sshpass`
- Disables `wan1`
- Waits **60 seconds**
- Re-enables `wan1`
- Logs each step into `/opt/scripts/log/...`

## Security Warning
This original version uses **plain‑text passwords** and should not be used in production.
