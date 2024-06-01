# Update Metadata from Google Photos JSON Backup

This script updates the metadata of JPG files using the information from Google Photos JSON backup files. The script processes all JSON and JPG files in the current directory and its subdirectories. It updates the creation date of the JPG files based on the `creationTime.timestamp` from the corresponding JSON files and ensures no backup copies of the original files are kept.

## Requirements

- **ExifTool**: A platform-independent Perl library plus a command-line application for reading, writing, and editing meta information in a variety of files.
- **jq**: A lightweight and flexible command-line JSON processor.
- **Perl**: Installed by default on most Unix-based systems, including macOS and Linux.

## Installation

### Install ExifTool

#### Ubuntu/Debian
```bash
sudo apt-get install exiftool jq ```

#### Mac
```bash
brew install exiftool jq```
