#!/bin/bash

# Create a temporary file on the target filesystem
tempfile=$(mktemp /data/shreddiesXXXXXX)

# Ensure the temporary file is removed when the script exits
trap 'rm -f "$tempfile"' EXIT

# Overwrite the free space with random data
dd if=/dev/urandom of="$tempfile" bs=10M status=progress

# Record the start time
start=$(date +%s)

# Run the dd command and pipe its output to logger
dd if=/dev/zero of=/dev/sda bs=10M status=progress 2>&1 | logger

# Record the end time
end=$(date +%s)

# Calculate and print the duration
duration=$((end - start))
echo "The operation took $duration seconds." | logger
echo "The operation took $duration seconds."
