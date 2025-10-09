#!/bin/bash

# Check if a filename is given
if [ -z "$1" ]; then
  echo "Please provide a .csv file."
  exit 1
fi

# Create output filename (replace .csv with _space.txt)
input = "$1"
output = "${input%.csv}_space.txt"

# Convert commas to spaces and save to new file
echo "Converting '$input' to space-separated file..."
tr -s ',' ' ' < "$input" > "$output"

echo "Done! Output file saved as '$output'."
exit 0
