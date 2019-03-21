#!/bin/bash

# Fixed bitrate
meMethod=("dia"  "hex"  "umh"  "full"  "tesa")

FFCMD="ffmpeg -hide_banner -y -benchmark -i $1 -an -pix_fmt yuv420p -c:v libx264 -b:v 2M -maxrate 2M -bufsize 2M -bf 2 "
  
for index in ${!meMethod[*]}; do
     mthd=${meMethod[$index]}
     (time $FFCMD -motion-est $index test-$mthd-fb.mov) 2> $mthd-fb.log
done

