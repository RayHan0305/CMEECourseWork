#!/bin/bash

# Check if the files are provided.
if ! ls *.tif 1> /dev/null 2>&1; then
    echo "Please provide .tif files."
    exit 1
fi


for f in *.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png"; 
    done