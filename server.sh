#!/bin/sh

set -e

check_parameter() {
    local port=$1
    # Check if the parameter is provided
    if [ -z "$port" ]; then
        echo "Error! <PORT> number is required as a parameter!"
        exit 1
    fi

    # Check if the <PORT> parameter is a positive number
    local positive_number_pattern="^[0-9]+$"
    if ! echo $port | grep -Eq $positive_number_pattern; then
        echo "Error! Invalid <PORT> parameter, $port is not a positive number!"
        exit 1
    fi
}

write_server_ip() {
    # Write IP address to file
    local server_ip_file=$1
    echo $(hostname -i) > $server_ip_file
}

start_listening() {
    # Start to listen the port
    local port=$1
    echo "Start listening on port $port..."
    nc -lp $port
}

main() {
    local port=$1
    check_parameter $@
    write_server_ip "$BIND_POINT/server_ip"
    start_listening $port
}

main $@
