# sgi-extract

NOTE: This is work in progress. Some tools may not work or exist yet.

This is a collection of command line tools for working with SGI disc images found at these sites: 

* [Internet Archive](archive.org/search?query=sgi&and%5B%5D=mediatype%3A%22software%22)
* [Bitsavers](bitsavers.org/bits/SGI/mips/cd/)
* [WinWorld](winworldpc.com/search?q=irix)
* [IRIXNet](irixnet.org/files.html)

These tools help extract files from SGI discs in three stages:

1. zip2dir.sh - From zip to disc, tarball, or file tree.

   .Z, .zip, .gz, .tbz  =>  disc, tarball, file tree

2. iso2tar.sh - From disc to tarball.  EFS and non-EFS discs are handled automatically.  Bin/cue discs are converted to isos automatically.

   .iso, .img, .bin/.cue, .efs  =>  .tar

3. tardist2files.sh - From SGI tardist to file tree. 

   .tar, .tardist  =>  .idb, .sw, .man  =>  file tree

A common feature of these tools is auto generation of output file and output directory names, making them amenable to batch conversions, e.g., `find sgi_disc_dir -name "*.iso" -exec iso2tar {} \;`.

## Prerequisites

```
brew install sevenzip
brew install bchunk
brew install go
go install github.com/sgi-demos/efs2tar
go install github.com/sgi-demos/sgix
```

## Example usage

```
zip2dir sgi-disc.Z
bincue2iso sgi-disc.cue
iso2tar sgi-disc.iso
tar2dir sgi-disc.tar
sgix sgi-disc/
```
