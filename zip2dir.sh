#!/bin/bash
#
# zip2dir.sh
#
# name.zip, .gz, .tbz, .Z => name (creates dir)
#
# Unzip zip files (.zip, .gz, .tbz, .Z, etc.) via 7zz into a new directory based on the name of the zip.
# Do nothing if the directory already exists.  Multiple passes may be required if zip files are embedded 
# within other zip files (no automatic recursion).
#
# Prereq:
#     brew install sevenzip
#
# Examples:
#     zip2dir.sh ./SGI/disc_images/812-0470-002.7z
#     find . -name "*.7z" -exec zip2dir.sh {} \;
#
fullfile="$1"                                   # filename with full path
filename=$(basename -- "$fullfile")             # filename without full path
extension="${filename##*.}"                     # file extension
dirname=$(dirname "$fullfile")                  # full path without filename
basename=$(basename "$filename" ".$extension")  # filename without full path and without extension
outputdir="${dirname}/${basename}"              # full path with basename

if [ ! -d "$outputdir" ] && [ ! -f "$outputdir" ]; then
    mkdir "$outputdir"
    echo OK: dir created: $outputdir
else
    echo ERROR: dir/file exists: $outputdir
    exit 1
fi

7zz x $fullfile -o$outputdir
