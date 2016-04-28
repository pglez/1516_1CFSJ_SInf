#!/bin/bash

# Script to convert all video files from a directory (parameter) into mp4 format file

# Sanity checks
# Directory provided as an argument?
if [ $# -eq  0 ] 
then 
	Basedir=$PWD
elif [ $# -eq 1 ] && [ -d $1 ]
then  
	Basedir=$1
	[ ! "${Basedir: -1}" = "/" ] && Basedir=$Basedir"/"
else
	echo "Too many arguments or bad directory!"
	echo "Usage: videobulk [directory]"
fi
# Other sanity checks... 
# ...

# Main code

ls -1 $Basedir*.avi > /tmp/.videofiles.tmp
while read Videofile
do
	Lengthname=${#Videofile}
	Namefile=${Videofile;0;$Lengthname-4}
	mencoder $Basedir$Videofile -o $Namefile".mp4" -oac mp3lame -ovc lavc -of mp4

done < /tmp/.videofiles.tmp
rm /tmp/.videofiles.tmp

exit 0
