#!/usr/bin/env bash

# Set environment variables
ENV_VARS="\
APP_ENV=dev\
"

server_pid=""

exec </dev/tty

# Start the server immediately once
echo "Starting initial server..."
env $ENV_VARS go run main.go &
server_pid=$!

while true; do
    read -rsn1 key
    if [[ "$key" == "r" ]]; then
        echo -e "\n[r] pressed — reloading..."

        # Kill old server
        if [[ -n "$server_pid" ]]; then
            pkill -P "$server_pid"
            kill -9 "$server_pid" 2>/dev/null || true
        fi

        echo "Starting new server..."
        env $ENV_VARS go run main.go &
        server_pid=$!
    fi
done

