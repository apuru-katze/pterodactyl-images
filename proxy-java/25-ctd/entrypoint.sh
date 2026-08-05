#!/bin/bash
set -e

cd /home/container || exit 1

# Configure colors
CYAN='\033[0;36m'
RESET_COLOR='\033[0m'

# Verify Velocity-CTD
echo "[INFO] Verifying Velocity-CTD..."

if [ ! -f server.jar ]; then
    echo "[ERROR] server.jar tidak ditemukan!"
    exit 1
fi

CURRENT_SHA256=$(sha256sum server.jar | awk '{print $1}')

EXPECTED_SHA256=$(
curl -fsSL \
https://api.github.com/repos/GemstoneGG/Velocity-CTD/releases/latest |
jq -r '
.assets[]
| select(.name | test("^velocity-ctd-.*\\.jar$"))
| .digest
' |
head -n1 |
sed 's/^sha256://'
)
    
echo "Expected: $EXPECTED_SHA256"
if [ -z "$EXPECTED_SHA256" ]; then
    echo "[ERROR] Gagal mengambil SHA256 dari GitHub."
    exit 1
fi

if [ "$CURRENT_SHA256" != "$EXPECTED_SHA256" ]; then
    echo "[ERROR] Velocity-CTD verification failed!"
    echo "[ERROR] Expected: $EXPECTED_SHA256"
    echo "[ERROR] Actual:   $CURRENT_SHA256"
    echo "[ERROR] SILAHKAN REINSTALL SERVER UNTUK FIX ISSUE INI!"
    exit 1
fi

echo "[INFO] Velocity-CTD verified."

# Print Current Java Version
java -version

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}STARTUP /home/container: ${MODIFIED_STARTUP} ${RESET_COLOR}"

# Run the Server
# shellcheck disable=SC2086
eval ${MODIFIED_STARTUP}