#!/bin/bash
#
# zip2dir.sh
#
# name.zip, .gz, .tbz, .Z => name (creates dir)
#
# Unzip zip files (.zip, .gz, .tbz, .Z, etc.) via 7zz into a new directory based on the name of the zip.
# Do nothing if the directory already exists.
#
# Prereq:
#     brew install sevenzip
#
# Examples:
#     zip2dir.sh ./SGI/disc_images/812-0470-002.7z
#     find . -name "*.7z" -exec zip2dir.sh {} \;
#

mkdir sgi-disc && tar xvf sgi-disc.tar -C sgi-disc



fullfile=$1                                     # filename with full path
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

		//
		// iso2tar .iso, .img -> tar
		//      TBD
		// efs2tar .iso, .img -> tar
		//      efs2tar -in sgi_disc.iso
		//      find disc_dir -name "*.iso" -exec efs2tar {} \;
		// .Z, .zip, .gz, .tbz -> dir (brew install sevenzip)
		// 		7zz x ./SGI/disc_images/812-0470-002.7z -o./SGI/disc_images/812-0470-002
		//      find . -name "*.7z" -exec 7zz x {} -oextracted \;
		// .bin,.cue -> .iso (brew install bchunk)
		//      bchunk 62impact2.bin 62impact2.cue 62impact2.iso
		// ~/archive/SGI/disc_images/812-0542-001.7z -> 812-0542-001
		//      basename "~/archive/SGI/disc_images/812-0542-001.7z" .7z
		// ~/archive/SGI/disc_images/812-0542-001.7z -> ~/archive/SGI/disc_images
		//      dirname "~/archive/SGI/disc_images/812-0542-001.7z"
		//