#!/bin/bash

OUTPUT_DIR="$HOME/.gphoto-output"
MOVIE_FILE="$OUTPUT_DIR/movie.mjpg"

mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

if [ -f "movie.mjpg" ]; then
    echo "Deleting existing movie.mjpg file..."
    rm -f "movie.mjpg"
fi

cleanup() {
    if [ ! -z "$GPHOTO_PID" ]; then
        echo "Stopping gphoto2..."
        kill $GPHOTO_PID 2>/dev/null
    fi
    exit
}

trap cleanup EXIT INT TERM

echo "Starting gphoto2 camera preview..."

gphoto2 --capture-movie &
GPHOTO_PID=$!

echo "Waiting for movie file to be created..."
sleep 2

while [ ! -f "movie.mjpg" ] || [ ! -s "movie.mjpg" ]; do
    echo "Waiting for movie.mjpg to be created and have content..."
    sleep 1
done

echo "Movie file is ready with content."
echo "Launching ffplay for preview..."

ffplay -fflags nobuffer -flags low_delay -vf "setpts=N/30/TB" -i movie.mjpg