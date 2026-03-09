#!/bin/bash
# Ensure the script exits on unhandled errors
set -e

# Activate Python virtual environment
source /home/rpi/ecoworthy/venv/bin/activate

# Directory of scripts
SCRIPT_DIR="/home/rpi/ecoworthy"

# List of scripts and their arguments
declare -A SCRIPTS=(
    ["ewbatlog-mqtt-A.py"]="ewbatlog-mqtt.py -m A5:C2:37:49:F9:47 -i 10"
    ["ewbatlog-mqtt-B.py"]="ewbatlog-mqtt.py -m A5:C2:37:49:FA:BC -i 10"
    ["ewbatlog-mqtt-C.py"]="ewbatlog-random.py -m E2:E7:79:82:55:BF"
    ["ewbatlog-mqtt-D.py"]="ewbatlog-random.py -m E2:E7:79:8C:A0:A3"
)

# Function to run a script with auto-restart
run_script() {
    local name="$1"
    local cmd="$2"
    local log_file="$SCRIPT_DIR/${name}.log"

    # Start in background, auto-restart on failure
    while true; do
        echo "$(date '+%F %T') Starting $cmd" >> "$log_file"
        python3 $SCRIPT_DIR/$cmd >> "$log_file" 2>&1
        echo "$(date '+%F %T') $cmd exited unexpectedly. Restarting in 5s..." >> "$log_file"
        sleep 5
    done
}

# Start all scripts in background
for key in "${!SCRIPTS[@]}"; do
    run_script "${key}" "${SCRIPTS[$key]}" &
done

# Wait for all background jobs to finish (they won't, unless manually stopped)
wait
