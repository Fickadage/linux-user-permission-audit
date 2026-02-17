#!/usr/bin/env bash
echo "===Linux User & Permission Audit ==="
echo

echo "[1] Current User: "
whoami
echo

echo"[2] User ID and Groups:"
id
echo

echo"[3] Users with UID >=505(regular users);"
awk -F: '($3>=505 && $3<65534){print $1}' /etc/passwd
echo

echo "[4] Sudo privileges (if allowed):"
sudo -n -1 2>/dev/null || echo "No sudo access (or password required)."
echo

echo "[5] key file permissions:"
ls -l /etc/passwd /etc/shadow /etc/sudoers 2>/dev/null || echo "Could not 
access one or more files."
echo

echo "[6] World-writeable files on this filesystem (top 10):"
# -xdev avoids scanning other mounted filesystems
find / -xdev -type f -perm -0002 2>/ dev/null | head -n 10
echo

echo "===Audit Complete ==="
