#!/bin/bash

# Find all JSON files in the current directory and subdirectories
find . -type f -name '*.json' | while read jsonfile; do
  # Extract the directory of the JSON file
  directory=$(dirname "$jsonfile")
  
  # Extract the title from the JSON file
  title=$(jq -r '.title' "$jsonfile")

  # Construct the full path to the media file
  mediafile="$directory/$title"

  # Check if the media file exists
  if [ -f "$mediafile" ]; then
    # Extract creationTime timestamp from the JSON file
    creationTime=$(jq -r '.creationTime.timestamp' "$jsonfile")
    
    # Convert creationTime from timestamp to a readable format using perl
    creationTimeFormatted=$(perl -e "use POSIX qw(strftime); print strftime('%Y:%m:%d %H:%M:%S', localtime($creationTime));")
    
    # Update the metadata from JSON and set the creation date, overwrite original
    exiftool -overwrite_original -json="$jsonfile" \
             "-CreateDate=$creationTimeFormatted" \
             "-DateTimeOriginal=$creationTimeFormatted" \
             "-FileModifyDate=$creationTimeFormatted" \
             "$mediafile"
  else
    echo "File $mediafile does not exist."
  fi
done
