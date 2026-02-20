
#!/bin/bash
# Load external config
source ./config.sh

disable_commands=(
    "config system interface"
    "edit wan1"
    "set status down"
    "end"
)

enable_commands=(
    "config system interface"
    "edit wan1"
    "set status up"
    "end"
)

execute_commands() {
    local commands=("$@")
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -p $PORT $USER@$HOST << EOF
$(for cmd in "${commands[@]}"; do echo "$cmd"; done)
EOF
}

echo "$(date): Disabling wan1 interface..." >> $LOG_FILE
execute_commands "${disable_commands[@]}"

echo "$(date): Waiting for 60 seconds..." >> $LOG_FILE
sleep 60

echo "$(date): Enabling wan1 interface..." >> $LOG_FILE
execute_commands "${enable_commands[@]}"

echo "$(date): Done." >> $LOG_FILE
