#! /bin/bash
# Prepare the content for streaming
ffmpeg -i ref-rec709-12s.mxf -an -pix_fmt yuv420p -c:v libx264 -bf 2 -g 50 -keyint_min 50 -sc_threshold 0 -b_strategy 0 -crf 18 -maxrate 500k -bufsize 1M rep-0500k.mp4

ffmpeg -i ref-rec709-12s.mxf -an -pix_fmt yuv420p -c:v libx264 -bf 2 -g 50 -keyint_min 50 -sc_threshold 0 -b_strategy 0 -crf 18 -maxrate 1000k -bufsize 1M rep-1000k.mp4

ffmpeg -i ref-rec709-12s.mxf -an -pix_fmt yuv420p -c:v libx264 -bf 2 -g 50 -keyint_min 50 -sc_threshold 0 -b_strategy 0 -crf 18 -maxrate 2000k -bufsize 1M rep-2000k.mp4