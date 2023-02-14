#!/bin/bash
#
# iso2tar.sh - .iso, .img, .efs => .tar
#
# Convert .iso, .img, and .efs files to .tar files via hdiutil (ISO 9660) 
# and efs2tar (SGI EFS). Do nothing if the .tar file already exists.
#
# Prereqs:
#     Mac (for hdiutil)
#     go install github.com/sgi-demos/efs2tar
#
# Examples:
#     iso2tar image.iso
#     find . -name "*.iso" -exec iso2tar.sh {} \;
#
fullfile="$1"                                   # filename with full path
filename=$(basename -- "$fullfile")             # filename without full path
extension="${filename##*.}"                     # file extension
dirname=$(dirname "$fullfile")                  # full path
basename=$(basename "$filename" ".$extension")  # base filename without extension
fullbasename="${dirname}/${basename}"
tarfile="$fullbasename".tar

if [ ! -d "$tarfile" ] && [ ! -f "$tarfile" ]; then
    # mount the disk image and get the device and mount names
	IFS=$'\n' read -d'\n' dev_name mount_name < <(
		hdiutil attach -readonly "${fullfile}" | grep $basename | awk '{print $1; print $2}'
	)

	# if hdiutil didn't work, try efs2tar

	# tar the volume mount
	ls -l "$mount_name"

	# unmount the device
	hdiutil detach "$dev_name"
else
    echo ERROR: file exists: $tarfile
    exit 1
fi

