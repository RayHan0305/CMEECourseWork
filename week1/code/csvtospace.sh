#!/bin/bash

# Check if the file is given
if [ -z "$1" ]; then
  echo "Please provide a .csv file."
  exit 1
fi

# CHeck if file exists
if [ ! -f "$1" ]; then
  echo "File '$1' not found"
  exit 1
fi

# Define input and output files
input="$1"
result_dir="../results"
filename=$(basename "$input")
output="$result_dir/${filename%.csv}.txt"

# Convert .csv to space-separated
echo "Converting '$input' to '$output' ..."
tr ',' ' ' < "$input" > "$output"
echo "Done!"
