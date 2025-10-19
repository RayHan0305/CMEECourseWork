#!/bin/bash

# Check if the files are provided.
# compgen -G "*.tif" is used to checks if any .tif files exist
if compgen -G "*.tif" > /dev/null; then
    for f in *.tif; 
        do  
            echo "Converting $f"; 
            convert "$f"  "$(basename "$f" .tif).png"; 
        done
else
    echo "Please provide .tif files."
fi