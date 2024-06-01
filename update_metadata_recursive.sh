#!/bin/bash

process_file() {
  jsonfile="$1"
  directory=$(dirname "$jsonfile")
  title=$(jq -r '.title' "$jsonfile")
  mediafile="$directory/$title"

  if [ -f "$mediafile" ]; then
    creationTime=$(jq -r '.creationTime.timestamp' "$jsonfile")
    creationTimeFormatted=$(perl -e "use POSIX qw(strftime); print strftime('%Y:%m:%d %H:%M:%S', localtime($creationTime));")
    exiftool -overwrite_original -json="$jsonfile" \
             "-CreateDate=$creationTimeFormatted" \
             "-DateTimeOriginal=$creationTimeFormatted" \
             "-FileModifyDate=$creationTimeFormatted" \
             "$mediafile"
  else
    echo "File $mediafile does not exist."
  fi
}

export -f process_file

find . -type f -name '*.json' | parallel -j 8 process_file {}
