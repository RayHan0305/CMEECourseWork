#!/bin/bash

# Check if the file is provided
if [ -z "$1" ]; then
    echo "The file is not provided."
    exit 1
fi

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo