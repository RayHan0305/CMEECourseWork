#!/bin/sh
# Author: ruixuan.han25@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2025

# Check if there is a file provided
if [ -z "$1"]; then
    echo "Error: Please provide an input file."
    exit 1
fi
# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "File '$1' not found!"
    exit 1
fi

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
exit