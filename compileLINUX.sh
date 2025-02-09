#!/bin/bash

echo "Compiling game to .phlox format..."

if [ ! -f "./lettuce" ]; then
    echo "Error: lettuce executable not found in current directory!"
    ls
    read -p "Press enter to continue..."
    exit 1
fi

if [ ! -f "GameInfo.json" ]; then
    echo "Error: GameInfo.json not found!"
    ls
    read -p "Press enter to continue..."
    exit 1
fi

mkdir -p build

if [ ! -f source/*.phs ]; then
    echo "Error: No .phs files found in source directory!"
    ls source
    read -p "Press enter to continue..."
    exit 1
fi

if [ ! -d "assets" ]; then
    echo "Warning: No assets directory found!"
    mkdir -p assets
fi

command="./lettuce GameInfo.json"
for f in source/*.phs; do
    command="$command \"$f\""
done
command="$command -o build/Data.phlox"

echo "Executing: $command"
eval $command

if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    read -p "Press enter to continue..."
    exit 1
fi

if [ ! -f "build/Data.phlox" ]; then
    echo "Error: build/Data.phlox was not created!"
    read -p "Press enter to continue..."
    exit 1
fi

if [ ! -s "build/Data.phlox" ]; then
    echo "Error: build/Data.phlox is empty!"
    read -p "Press enter to continue..."
    exit 1
fi

echo "Build successful!"
read -p "Press enter to continue..."