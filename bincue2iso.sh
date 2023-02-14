#!/bin/bash
#
# bincue2iso.sh
#
# .bin,.cue => .iso
#
# Converts .bin and .cue file pairs to .iso.
#
# Prereq:
#     brew install bchunk
#
# Examples:
#     bincue2iso.sh ./SGI/disc_images/812-0470-002.cue
#     find ~/sgi-discs -name "*.cue" -print -exec ./bincue2iso.sh {} \;
# 
fullfile="$1"                                   # filename with full path
filename=$(basename -- "$fullfile")             # filename without full path
extension="${filename##*.}"                     # file extension
dirname=$(dirname "$fullfile")                  # full path
basename=$(basename "$filename" ".$extension")  # base filename without extension
fullbasename="${dirname}/${basename}"
cuefile="$fullbasename".cue
binfile="$fullbasename".bin
isofile="$fullbasename".iso
ughfile="$fullbasename".ugh

if [ -d "$isofile" ] || [ -f "$isofile" ]; then
    echo ERROR: file exists: $isofile
    exit 1
fi

bchunk "$binfile" "$cuefile" "$fullbasename"

if [ -f "$isofile" ]; then
    echo OK: created "$isofile"
    # rm "$binfile" "$cuefile"
else
    echo ERROR: could not create "$isofile"
    # rm "$ughfile"
fi
