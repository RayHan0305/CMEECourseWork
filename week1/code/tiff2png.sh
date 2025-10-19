#!/bin/bash

# Check if the files are provided.
if ls *.tif; then
    for f in *.tif; 
        do  
            echo "Converting $f"; 
            convert "$f"  "$(basename "$f" .tif).png"; 
        done
else
    echo "Please provide .tif files."
fi