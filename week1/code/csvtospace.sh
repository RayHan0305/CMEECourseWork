#!/bin/bash

# Check if a filename is given
if [ -z "$1" ]; then
  echo "Please provide a .csv file."
  echo "Usage: ./csvtospace.sh path/to/filename.csv"
  exit 1
fi

# Check if file exists
if [ ! -f "$1" ]; then
  echo "File '$1' not found!"
  exit 1
fi

# Define input and output filenames
input="$1"
output="result/${input%.csv}.txt"

# Convert commas to spaces and save to new file
echo "Converting '$input' to '$output' ..."
tr ',' ' ' < "$input" > "$output"

echo "Done!"
