#!/bin/bash

# Start up the react timer
cd ~/react-timer;
# Clean up previous react timer environment
docker-compose down;
docker image rm -f $(docker image ls);
# Build up new react timer environment
docker-compose up -d --build;

# Make permissions so I can do whatever I want
DIR=$(docker container inspect client | grep "Source" | grep -o "/var/.*");
PATH=${DIR::-2};
echo "Path to rsync directory: ${PATH}";
/bin/chown larry:larry -R $PATH;
/bin/chmod 777 -R $PATH;
echo $PATH;
