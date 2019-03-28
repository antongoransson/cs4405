#! /bin/bash
# Fragment the different videos

lib/bento4/bin/mp4fragment rep-0500k.mp4 rep-0500k-frag.mp4

lib/bento4/bin/mp4fragment rep-1000k.mp4 rep-1000k-frag.mp4

lib/bento4/bin/mp4fragment rep-2000k.mp4 rep-2000k-frag.mp4

# Manually set fragments
lib/bento4/bin/mp4fragment --fragment-duration 2000 audio.mp4 audio-frag.mp4