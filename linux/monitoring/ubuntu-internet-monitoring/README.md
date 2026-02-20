# Disclaimer

Users utilize this repository entirely at their own risk, and the author assumes no liability for any damages, misconfigurations, or operational issues resulting from its use.

-   Limitation of Liability
-   Use at Your Own Risk
-   No Warranty Disclaimer

# Ubuntu Internet Connection Monitoring Script

## Overview

This Bash script continuously monitors internet connectivity on an
Ubuntu system by sending periodic ICMP echo requests (ping) to a defined
target IP address.

It tracks consecutive packet loss events, logs connectivity status, and
automatically rotates log files on a daily basis.

The script is lightweight and suitable for servers, remote locations,
edge devices, homelabs, and infrastructure monitoring setups.

More about this script: https://defencedev.com/projects/wordpress/wordpress-automatically-website-backup-script/


------------------------------------------------------------------------

## Features

-   Continuous connectivity monitoring
-   Configurable target IP address
-   Detection of consecutive failed pings
-   Threshold-based logging
-   Automatic daily log rotation
-   Minimal system resource usage
-   Cron integration support
-   Simple Bash implementation

------------------------------------------------------------------------

## How It Works

1.  The script sends a single ping request at defined intervals.
2.  If the ping succeeds, it logs a success entry.
3.  If the ping fails:
    -   It increments a counter of consecutive failures.
    -   When the failure threshold is reached, it logs a threshold
        event.
4.  Logs are written to a file named by date.
5.  The script runs continuously until stopped.

------------------------------------------------------------------------

## Directory Structure

    ubuntu-internet-monitoring/
    ├── check_internet.sh
    ├── config.example
    └── README.md

------------------------------------------------------------------------

## Installation

### 1. Create Required Directories

``` bash
sudo mkdir -p /opt/scripts/log
sudo mkdir -p /opt/scripts
```

### 2. Create the Script File

``` bash
sudo nano /opt/scripts/check_internet.sh
```

Paste the script content and save.

### 3. Make Script Executable

``` bash
sudo chmod +x /opt/scripts/check_internet.sh
```

------------------------------------------------------------------------

## Configuration

Inside the script you can modify the following variables:

  -----------------------------------------------------------------------
  Variable                                  Description
  ----------------------------------------- -----------------------------
  `PING_IP`                                 Target IP address to monitor
                                            (default: 8.8.8.8)

  `MAX_LOST_PINGS`                          Number of consecutive failed
                                            pings before threshold is
                                            triggered

  `LOG_DIR`                                 Directory where logs are
                                            stored

  `SLEEP_INTERVAL`                          Seconds between ping attempts
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## Run Manually

``` bash
sudo bash /opt/scripts/check_internet.sh
```

------------------------------------------------------------------------

## Run Automatically at Boot (Crontab)

Open root crontab:

``` bash
sudo crontab -e
```

Add:

``` cron
@reboot sleep 180 && /bin/bash /opt/scripts/check_internet.sh
```

This waits 3 minutes after boot and starts the monitoring script.

------------------------------------------------------------------------

## Example Log Output

    Check connectivity script is executed on Thu 2025-11-28 12:00:00 UTC
    Thu 2025-11-28 12:00:03: Ping to 8.8.8.8 OK
    Thu 2025-11-28 12:00:06: Ping to 8.8.8.8 failed and it is 1
    Thu 2025-11-28 12:00:09: Ping to 8.8.8.8 failed and it is 2
    Thu 2025-11-28 12:00:12: We reach threshold of losing 3 pings in a row

Log file naming format:

    check_internet_YYYY-MM-DD.log

------------------------------------------------------------------------

## Production Recommendations

-   Replace `8.8.8.8` with:
    -   Your ISP gateway
    -   Upstream router
    -   Internal DNS server
-   Ensure log directory has sufficient disk space
-   Consider running via systemd for better process management
-   Implement proper log rotation if used long-term

------------------------------------------------------------------------

## Security Notes

-   No external dependencies
-   No external API calls
-   Can run as non-root user if permissions allow

------------------------------------------------------------------------

## Use Cases

-   Detect ISP instability
-   Identify packet loss patterns
-   Monitor remote branch offices
-   Track uptime reliability
-   Collect data for SLA verification

------------------------------------------------------------------------

## License

Add your preferred license (MIT, Apache-2.0, etc.)

------------------------------------------------------------------------

## Author

DefenceDev\
Infrastructure & Network Automation\
https://defencedev.com
