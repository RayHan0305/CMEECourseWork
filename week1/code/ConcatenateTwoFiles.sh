#!/bin/bash

# Check if the files are provided
if [ $# -ne 3 ]; then
    echo "PLease provide the files."
    exit 1
fi

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3