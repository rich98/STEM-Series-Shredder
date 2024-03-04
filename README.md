# STEM Series: Shredder

This script is written in `bash`, a type of shell script used to automate tasks on Unix-like operating systems.

## Script Breakdown

1. `tempfile=$(mktemp /data/shreddiesXXXXXX)`: Creates a temporary file in the `/data` directory. The `XXXXXX` in the filename is replaced with random characters to ensure the filename is unique.

2. `trap 'rm -f "$tempfile"' EXIT`: Sets up a "trap" that will delete the temporary file when the script exits, no matter how it exits. This is good practice to prevent temporary files from cluttering up your system.

3. `dd if=/dev/urandom of="$tempfile" bs=10M status=progress`: Writes random data to the temporary file. The `if=/dev/urandom` part means "input from /dev/urandom", which is a source of random data. The `of="$tempfile"` part means "output to the temporary file". The `bs=10M` part means "block size of 10 megabytes", which affects how much data is written at once. The `status=progress` part makes `dd` print out progress information as it runs.

4. `start=$(date +%s)`: Records the current time in seconds since 1970-01-01 00:00:00 UTC (also known as Unix time or epoch time) and stores it in the `start` variable.

5. `dd if=/dev/zero of=/dev/sda bs=10M status=progress 2>&1 | logger`: Overwrites the `/dev/sda` device (usually the first hard drive) with zeros. The `2>&1 | logger` part redirects the output of the `dd` command to the system log.

6. `end=$(date +%s)`: Records the current time in the same way as the `start` line, but stores it in the `end` variable.

7. `duration=$((end - start))`: Calculates the duration of the `dd` command by subtracting the start time from the end time.

8. `echo "The operation took $duration seconds." | logger`: Writes a message to the system log saying how long the operation took.

9. `echo "The operation took $duration seconds."`: Prints the same message to the console.

## Use Case

This script could be used for securely erasing a hard drive. It first fills the drive with random data, then overwrites it with zeros, making it very difficult to recover any data that was on the drive. It also logs how long the operation took. However, be careful with scripts like this, as they can permanently delete data!
