#! /bin/bash

VBR="4500k"
FPS="30"
QUAL="ultrafast"

YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
KEY="urff-w6zh-amub-g08f-4cxj"

VIDEO_SOURCE="video.mp4"
AUDIO_SOURCE="music.mp3"

ffmpeg \
-re -f lavfi -i "movie=filename=$VIDEO_SOURCE:loop=0, setpts=N/(FRAME_RATE*TB)" \
-thread_queue_size 512 -i "$AUDIO_SOURCE" \
-map 0:v:0 -map 1:a:0 \
-map_metadata:g 1:g \
-vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR -maxrate 4500k \
-acodec libmp3lame -ar 44100 -threads 3 -qscale:v 3 -b:a 320k -bufsize 512k \
-f flv "$YOUTUBE_URL/$KEY"
