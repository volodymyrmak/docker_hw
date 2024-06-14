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

connect_to_server() {
    local host=$1
    local port=$2
    echo "Connecting to server $host:$port..."
    nc $host $port
}

main() {
    check_parameter $@

    # Check if server_ip file is created
    local server_ip_file="$BIND_POINT/server_ip"
    if [ ! -f $server_ip_file ]; then
        echo "Error! No such file: $server_ip_file. Please make sure the server has been started."
        exit 1
    fi

    local host=$(cat $server_ip_file)
    local port=$1
    connect_to_server $host $port
}

main $@
