# Linux User & Permission Audit

A beginner-friendly Bash script that performs a basic Linux security 
audit:
- current user
- groups and UID
- regular user accounts (UID >= 1000)
- sudo privileges (if permitted)
- permissions for sensitive system files
- top 10 world-writable files (same filesystem)

## Run
```bash
chmod +x audit.sh
./audit.sh
