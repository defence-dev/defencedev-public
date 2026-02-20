# Installation Guide

This document describes how to deploy the Ubuntu Internet Connection
Monitoring Script in a clean and production-ready manner.

------------------------------------------------------------------------

## System Requirements

-   Ubuntu Server 20.04 or newer
-   Bash
-   ping utility (usually preinstalled)
-   Root or sudo privileges
-   Cron (optional for auto-start)

------------------------------------------------------------------------

## Step 1 -- Create Directory Structure

Create a dedicated directory for scripts and logs:

``` bash
sudo mkdir -p /opt/scripts
sudo mkdir -p /opt/scripts/log
```

Set proper permissions (optional but recommended):

``` bash
sudo chmod 755 /opt/scripts
sudo chmod 755 /opt/scripts/log
```

------------------------------------------------------------------------

## Step 2 -- Copy Script

Copy the monitoring script into the scripts directory:

``` bash
sudo cp check_internet.sh /opt/scripts/
```

Or create it manually:

``` bash
sudo nano /opt/scripts/check_internet.sh
```

Paste the script content and save.

------------------------------------------------------------------------

## Step 3 -- Make Script Executable

``` bash
sudo chmod +x /opt/scripts/check_internet.sh
```

Verify:

``` bash
ls -l /opt/scripts/
```

You should see execute permissions enabled.

------------------------------------------------------------------------

## Step 4 -- Test Manual Execution

Run the script manually to confirm it works:

``` bash
sudo /opt/scripts/check_internet.sh
```

Check log file creation:

``` bash
ls /opt/scripts/log/
```

------------------------------------------------------------------------

## Step 5 -- Configure Auto-Start (Cron)

Edit root crontab:

``` bash
sudo crontab -e
```

Add the following line:

``` cron
@reboot sleep 180 && /bin/bash /opt/scripts/check_internet.sh
```

Explanation: - Waits 3 minutes after system boot - Starts the monitoring
script

------------------------------------------------------------------------

## Optional -- Run as Non-Root User

You may run the script as a dedicated system user:

1.  Create user:

``` bash
sudo adduser monitoruser
```

2.  Adjust permissions:

``` bash
sudo chown -R monitoruser:monitoruser /opt/scripts
```

3.  Configure cron for that user:

``` bash
crontab -e
```

------------------------------------------------------------------------

## Optional -- Systemd Deployment (Recommended for Production)

Create service file:

``` bash
sudo nano /etc/systemd/system/internet-monitor.service
```

Add:

``` ini
[Unit]
Description=Internet Connectivity Monitoring Script
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /opt/scripts/check_internet.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

Enable and start service:

``` bash
sudo systemctl daemon-reload
sudo systemctl enable internet-monitor.service
sudo systemctl start internet-monitor.service
```

Check status:

``` bash
sudo systemctl status internet-monitor.service
```

------------------------------------------------------------------------

## Log Verification

Monitor logs in real time:

``` bash
tail -f /opt/scripts/log/check_internet_$(date +%Y-%m-%d).log
```

------------------------------------------------------------------------

## Uninstall

To remove the monitoring setup:

``` bash
sudo systemctl stop internet-monitor.service
sudo systemctl disable internet-monitor.service
sudo rm /etc/systemd/system/internet-monitor.service
sudo rm -rf /opt/scripts
```

Reload systemd:

``` bash
sudo systemctl daemon-reload
```

------------------------------------------------------------------------

## Notes

-   Replace default ping target with your preferred monitoring endpoint.
-   Ensure sufficient disk space for log files.
-   Consider implementing log rotation for long-term usage.
