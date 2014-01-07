#!/bin/bash
#Youtube-DL DASH Video and Audio merging script
#Written by QuidsUp
#Edited by Christoph Korn
#Edited by saitodisse

URL=$1
QualVideo=$2
QualAudio=$3

if [ -z $URL ]; then
  echo "Usage: bash you-helper.sh url"
  echo "   or: bash you-helper.sh url 137 140"
  exit
fi

#Find what quality of videos are available
if [ -z $QualVideo -o -z $QualAudio ]; then
  echo
  echo -n "Listing available videos sources"
  echo
  youtube-dl -F $URL
fi

if [ -z $QualVideo ]; then
  echo
  echo -n "Quality for Video (default 137/136): "
  read QualVideo
fi
# Set values if user has just pressed Return without typing anything
if [ -z $QualVideo ]; then
  QualVideo="137/136"
fi

if [ -z $QualAudio ]; then
  echo
  echo -n "Quality for Audio (default 141/140/139): "
  read QualAudio
fi
# Set values if user has just pressed Return without typing anything
if [ -z $QualAudio ]; then
  QualAudio="141/140/139"
fi


#Set filenames from output of youtube-dl

OutputLongName="-o""%(uploader)s - %(title)s [%(id)s, %(format)s].%(ext)s"""
FileVideoLong=$(youtube-dl --get-filename -f $QualVideo "$OutputLongName" $URL)

OutputUploader="-o""%(uploader)s"""
Uploader=$(youtube-dl --get-filename -f $QualVideo "$OutputUploader" $URL)

OutputId="-o""%(id)s.%(ext)s"""
FileVideo=$(youtube-dl --get-filename -f $QualVideo "$OutputId" $URL)
FileAudio=$(youtube-dl --get-filename -f $QualAudio "$OutputId" $URL)
echo long name: [$FileVideoLong]
echo video: $FileVideo, audio: $FileAudio

#Download Video file with First Quality Setting
echo
echo "Getting Video!"
echo
youtube-dl -f $QualVideo "$OutputId" $URL
if [[ ! -f $FileVideo ]]; then
  echo
  echo "Error video file not downloaded"
  exit
fi

#Download Audio file with Second Quality Setting
echo
echo "Getting Audio!"
echo
youtube-dl -f $QualAudio "$OutputId" $URL
if [[ ! -f $FileAudio ]]; then
  echo
  echo "Error audio file not downloaded"
  exit
fi


echo
echo "Combining Audio and Video files with MP4Box"
echo "MP4Box -add" $FileVideo $FileAudio
echo
MP4Box -add "$FileAudio" "$FileVideo"


#Remove audio file
if [[ -f "$FileAudio" ]]; then
  echo
  echo "Remove audio file"
  echo
  rm "$FileAudio"
fi

#create downloads folder
mkdir -p downloads/"$Uploader"/

#Rename to original name
if [[ -f out_"$FileVideo" ]]; then
  echo
  echo "slice away ""out_"" from video name"
  echo "old name: " out_"$FileVideo"
  echo "new name: " "$FileVideo"
  echo
  mv out_"$FileVideo" "$FileVideo"
fi

#Rename to descriptive name
if [[ -f "$FileVideo" ]]; then
  echo
  echo "Getting descriptive name and moving to downloads folder"
  echo "old name: " "$FileVideo"
  echo "new name: " "$FileVideoLong"
  echo
  mv "$FileVideo" downloads/"$Uploader"/"$FileVideoLong"
fi
