#!/bin/bash

# USAGE:
# ./portscanner2.sh <IP PREFIX> <PORT>
# E.G.: ./portscanner2.sh 10.0.5 53

trap "rm -f $errfile" EXIT

set -o errexit # Exit on most errors

# Assign input arguments to variables
prefix=$1
port=$2

# Assign socket connection error file
errfile="/tmp/portscan_err"

echo "ip,port"

for host in $1.{1..254}; do
  timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>$errfile && echo "$host,$port"
done

# Check for presence of stderr
if [ -s $errfile ]; then
  echo "Presence of errors from connections!"
  cat $errfile
  rm $errfile
  exit 1
fi

