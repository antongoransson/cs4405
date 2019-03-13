# Gives encoding information
# encoder, bitrate, resolution, fps
# ffprobe -i Rally-Reference.mov

# Defince codec for video: -c:v
# Define for audio: = none
# Uses lot of default options
# ffmpeg -i Rally-Reference.mov -c:v libx264 -an out-h264-default.mp4


# Define quality level: -crf -> constant rate factor. The lower it is the higher the bitrate and quality is
# The higher crf is the lower the bitrate and quality
# 16 = defined as visually no difference
# ffmpeg -i Rally-Reference.mov -c:v libx264 -an -crf 16 out-crf16.mp4

# Lowest quality
# ffmpeg -i Rally-Reference.mov -c:v libx264 -an -crf 51 out-crf51.mp4

# Specify bitrate: maxrate
# Buffsize telling the encoder when to check so bitrate is not exceeded
# ffmpeg -i Rally-Reference.mov -c:v libx264 -an -crf 20 -maxrate 2M -bufsize 1M out-constrained.mp4

# Reduce framerate
# Individual pictures higher quality, motion lower quality
ffmpeg -i Rally-Reference.mov -c:v libx264 -an -crf 20 -maxrate 2M -bufsize 1M -r 10 out-lowfps.mp4