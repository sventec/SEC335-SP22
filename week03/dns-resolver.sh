#!/bin/bash

# USAGE:
# ./dns-resolver.sh <PREFIX> <DNS SERVER>
# E.G. ./dns-resolver.sh 10.0.5 10.0.5.22
# Note: Assumes a /24 network

# Assign input arguments to variables
prefix=$1
server=$2

echo "dns resolution for $prefix"

for host in $prefix.{1..254}; do
  nslookup $host $server | grep name
done
