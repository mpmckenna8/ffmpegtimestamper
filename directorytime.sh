
let offset=0

mkdir timedvis

extension=$1

let HOURS=$2
let MINS=$3
let SECS=${4:-0}

let offset=$HOURS*60*60+$MINS*60+$SECS



for i in *.$1 
do
    echo "got a file $i"
	
	output="timedvis/"$HOURS-$MINS-$SECS-"timed.mp4"
	
	ffmpeg  -output_ts_offset 1145 -i "$i" -s 640x480 -vf \
	"drawtext=fontfile=/Library/Fonts/Futura.ttc:text=' \
	time=%{pts \\: hms \\: $offset }'  :fontcolor=white:fontsize=24:x=20:y=30:box=1:boxcolor=black@0.5:boxborderw=10,format=yuv420p" \
	-c:v libx264 -c:a copy -movflags +faststart $output

    ffprobe -loglevel error -show_entries format=duration -of default=nw=1:nk=1 \
    "$i"
    addoffset="$(ffprobe -loglevel error -show_entries format=duration -of default=nw=1:nk=1 $i)"

    let offset=$offset+${addoffset%.*}

    let HOURS=$offset/3600
    
    let minsleft=$offset%3600
    let MINS=$minsleft/60
    let SECS=$minsleft%60

    echo $offset

done


