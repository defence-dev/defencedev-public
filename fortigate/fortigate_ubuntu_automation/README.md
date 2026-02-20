
# FortiGate WAN1 Disable/Enable Script (Original Version)

This repository contains the **original, unmodified FortiGate WAN1 automation script** exactly as provided.

The script connects to a FortiGate firewall via SSH and performs:
1. Disable interface `wan1`
2. Wait 60 seconds
3. Re-enable interface `wan1`

It uses `sshpass` for non‑interactive password authentication.

## Features
- Simple SSH automation
- Logging to `/opt/scripts/log/`

## File List
- `fgt_gw_check.sh` — script with the commands
- `config.sh` — FortiGate Firewall connection parameters
- `INSTALLATION.md` — installation guide
- `README.md` — this file

## Important Notice
This script contains:
- No SSH key support
- No error handling improvements

Make sure to:
- update `config.sh` with correct values,
- secure the file properly (do not commit it to Git),
- restrict file permissions if storing sensitive credentials.

This script uses an external configuration file (`config.sh`) to store
connection details such as HOST, USER, PASSWORD, and PORT.

Use with caution and preferably only inside isolated or test environments.


## Usage
```bash
chmod +x fgt_gw_check.sh
./fgt_gw_check.sh
```
