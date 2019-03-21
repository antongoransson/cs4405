#!/bin/bash
 
 # Fixed quality --> crf 24
meMethod=("dia"  "hex"  "umh"  "full"  "tesa")

FFCMD="ffmpeg -hide_banner -y -benchmark -i $1 -an -pix_fmt yuv420p -c:v libx264 -crf 24 -bf 2 "
  
for index in ${!meMethod[*]}; do
     mthd=${meMethod[$index]}
     (time $FFCMD -motion-est $index test-$mthd-fq.mov) 2> $mthd-fq.log
done

