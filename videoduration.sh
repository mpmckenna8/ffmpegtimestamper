#!/bin/bash

echo "Length of Video"

input=$1
#"./M2U00029.mp4"

ffprobe -loglevel error -show_entries format=duration -of default=nw=1:nk=1 "$input"
