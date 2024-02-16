#!/bin/bash

#gpt vesion using screen
# Check if the screen session exists
if screen -list | grep -q "fuzzing"; then
  echo "The screen session 'fuzzing' already exists. Attaching to it..."
  screen -r fuzzing
else
  echo "Creating a new screen session 'fuzzing' and starting an interactive Docker container."
  # Create a new detached screen session that runs the Docker command
  screen -dmS fuzzing
  # Send the Docker command to the screen session for execution
  screen -S fuzzing -X stuff "docker run --rm -ti --name chfuzz --mount type=bind,source=/chfuzz,destination=/outs --mount type=tmpfs,destination=/ramdisk -e AFL_TMPDIR=/ramdisk fuzzchsh:v2 bash run12tmux.sh\n"
  echo "Screen session 'fuzzing' with Docker container started. You can attach to it with 'screen -r fuzzing'."
fi
