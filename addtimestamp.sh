#!/bin/bash

STRING="add text to vid"



let HOURS=$2*60*60
let MINS=$3*60

let offset=$HOURS+$MINS

echo $STRING

echo $HOURS

input=$1
output="timed.mp4" # +$input
#"./M2U00029.mp4"

#ffprobe -loglevel error -show_entries format=duration -of default=nw=1:nk=1 "$input"

#ffmpeg -i ./M2U00029.mp4 -s 640x480 -vf drawtext="fontfile=/Library/Fonts/Futura.ttc: \
#text='Stack Overflow': fontcolor=white: fontsize=24: box=1: boxcolor=black@0.5: \
#boxborderw=5: x=20: y=20" -codec:a copy outputer.mp4



#was the drawtext line
# "drawtext=fontfile=/Library/Fonts/Futura.ttc:text='frame %{n}\\:
# %{pict_type}\\: \


#decrementing text
#'%{eif\:$duration-t\:d}'
ffmpeg  -output_ts_offset 1145 -i "$input" -s 640x480 -vf \
"drawtext=fontfile=/Library/Fonts/Futura.ttc:text=' \
time=%{pts \\: hms \\: $offset }'  :fontcolor=white:fontsize=24:x=20:y=30:box=1:boxcolor=black@0.5:boxborderw=10,format=yuv420p" \
-c:v libx264 -c:a copy -movflags +faststart $output


