#! /bin/bash

# mjpeg encoding
#ffmpeg -i mobile_calendar_422_cif.y4m -pix_fmt yuvj420p -c:v mjpeg -qscale:v 1 -qmin 1 -an out-mjpeg.mov

# 
#ffmpeg -i mobile_calendar_422_cif.y4m -pix_fmt yuv420p -c:v mpeg1video -qscale:v 1 -qmin 1 -an out-mpeg1-1.mov

# only use I-pictures
#ffmpeg -i mobile_calendar_422_cif.y4m -pix_fmt yuv420p -c:v mpeg1video -qscale:v 1 -qmin 1 -intra -an out-mpeg1-2.mov

#ffmpeg -i mobile_calendar_422_cif.y4m -pix_fmt yuv420p -c:v mpeg1video -qscale:v 2 -qmin 1 -intra -an out-mpeg1-3.mov

# Use I and P pictures only
ffmpeg -i mobile_calendar_422_cif.y4m -pix_fmt yuv420p -c:v mpeg1video -qscale:v 2 -qmin 1 -g 15 -bf 0 -an out-mpeg1-ip.mov

# 1 B picture between I and P
ffmpeg -i mobile_calendar_422_cif.y4m -pix_fmt yuv420p -c:v mpeg1video -qscale:v 2 -qmin 1 -g 15 -bf 1 -an out-mpeg1-ibp.mov


ffmpeg -i mobile_calendar_422_cif.y4m -pix_fmt yuv420p -c:v mpeg1video -qscale:v 2 -qmin 1 -g 15 -bf 2 -an out-mpeg1-ibbp.mov