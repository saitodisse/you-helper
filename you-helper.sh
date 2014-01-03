#!/bin/bash
#Youtube-DL DASH Video and Audio merging script
#Written by QuidsUp
#Edited by Christoph Korn

File1New=video.mp4
File2New=audio.m4a

URL=$1
Qual1=$2
Qual2=$3

if [ -z $URL ]; then
  echo "Usage: bash you-helper.sh url 137 141"
  exit
fi

#Find what quality of videos are available
if [ -z $Qual1 -o -z $Qual2 ]; then
  echo
  echo -n "Listing available videos sources"
  echo
  youtube-dl -F $URL
fi

if [ -z $Qual1 ]; then
  echo
  echo -n "Quality for Video (default 137): "
  read Qual1
fi
# Set values if user has just pressed Return without typing anything
if [ -z $Qual1 ]; then
  Qual1="137"
fi

if [ -z $Qual2 ]; then
  echo
  echo -n "Quality for Audio (default 141): "
  read Qual2
fi
# Set values if user has just pressed Return without typing anything
if [ -z $Qual1 ]; then
  Qual2="141"
fi

#Set filenames from output of youtube-dl
File1=$(youtube-dl --get-filename -f $Qual1 $URL)
File2=$(youtube-dl --get-filename -f $Qual2 $URL)
echo $File1
echo $File2

#Download Video file with First Quality Setting
echo
echo "Getting Video!"
echo
youtube-dl -f $Qual1 $URL
if [[ ! -f $File1 ]]; then
  echo
  echo "Error video file not downloaded"
  exit
fi

#Download Audio file with Second Quality Setting
echo
echo "Getting Audio!"
echo
youtube-dl -f $Qual2 $URL
if [[ ! -f $File2 ]]; then
  echo
  echo "Error audio file not downloaded"
  exit
fi

echo
echo "Combining Audio and Video files with MP4Box"
echo "MP4Box -add" $File1 $File2
echo
MP4Box -add "$File2" "$File1"

if [[ -f "$File2" ]]; then
  #Remove audio file
  echo
  echo "Remove audio file"
  echo
  rm "$File2"
fi


if [[ -f out_"$File1" ]]; then
  #Back to original name
  echo
  echo "Back to original name"
  echo "old name: " out_"$File1"
  echo "new name: " "$File1"
  echo
  mv out_"$File1" "$File1"
fi


