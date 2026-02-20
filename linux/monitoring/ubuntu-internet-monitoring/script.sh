#!/bin/bash

PING_IP="8.8.8.8"        # IP to ping
MAX_LOST_PINGS=3        # Number of lost pings before restarting service
LOG_FILE="/opt/scripts/log/check_internet_$(date +%Y-%m-%d).log" # Location for log file


echo "Check connectivity script is executed on $(date)"  >> $LOG_FILE

lost_pings=0   # Define variable to enable tracking lost pings
# Loop indefinitely
while :
do
    # Ping the IP once, wait for up to 1 second
    if ping -c 1 -W 1 $PING_IP > /dev/null; then
        echo "Ping to $PING_IP OK"
        if [ $lost_pings -ge $MAX_LOST_PINGS ]; then
        echo "$(date): Ping to $PING_IP OK" >> $LOG_FILE
        fi
        lost_pings=0
    else
        # Ping failed, log the date, time, and IP
        if [ $lost_pings -lt $MAX_LOST_PINGS ]; then
        echo "$(date): Ping to $PING_IP failed and it is $lost_pings" >> $LOG_FILE
        fi
        # Count the number of consecutive lost pings
        lost_pings=$((lost_pings + 1))
        # If the number of lost pings has reached the limit, restart the service
        if [ $lost_pings -eq $MAX_LOST_PINGS ]; then
            echo "$(date): We reach treshold of loosing $MAX_LOST_PINGS ping in a row" >> $LOG_FILE
        fi
    fi
    # Wait for 3 seconds before pinging again
    sleep 3
    # Check if the date has changed
    if [ "$(date +%Y-%m-%d)" != "$(date -r "$LOG_FILE" +%Y-%m-%d)" ]; then
        # Create a new log file for the new day
        LOG_FILE="/opt/scripts/log/check_internet_$(date +%Y-%m-%d).log"
        echo "Script is executed on $(date)" >> "$LOG_FILE"
    fi

done