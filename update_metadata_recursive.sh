#!/bin/bash

# Find all JSON files in the current directory and subdirectories
find . -type f -name '*.json' | while read jsonfile; do
  # Extract the base name of the file (e.g., IMG_0001.jpg from IMG_0001.jpg.json)
  jpgfile="${jsonfile%.json}"
  if [ -f "$jpgfile" ]; then
    # Extract creationTime timestamp from the JSON file
    creationTime=$(jq -r '.creationTime.timestamp' "$jsonfile")
    
    # Convert creationTime from timestamp to a readable format using perl
    creationTimeFormatted=$(perl -e "use POSIX qw(strftime); print strftime('%Y:%m:%d %H:%M:%S', localtime($creationTime));")
    
    # Update the metadata from JSON and set the creation date, overwrite original
    exiftool -overwrite_original -json="$jsonfile" \
             "-CreateDate=$creationTimeFormatted" \
             "-DateTimeOriginal=$creationTimeFormatted" \
             "-FileModifyDate=$creationTimeFormatted" \
             "$jpgfile"
  else
    echo "File $jpgfile does not exist."
  fi
done
