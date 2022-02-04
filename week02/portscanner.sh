#!/bin/bash

# Assign input arguments to variables
hostfile=$1
portfile=$2

# Assign socket connection error file
errfile="/tmp/portscan_err"

# Verify the input arguments
if [ ! -f $hostfile ]; then
  echo "Error: hostfile does not exist"
  exit 1
fi

if [ ! -f $portfile ]; then
  echo "Error: portfile does not exist"
  exit 1
fi

echo "host,port"

for host in $(cat $hostfile); do
  for port in $(cat $portfile); do
    timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>$errfile && echo "$host,$port"
  done
done

# Check for presence of stderr
if [ -s $errfile ]; then
  echo "Presence of errors from connections!"
  cat $errfile
  rm $errfile
  exit 1
fi

