#!/bin/bash

# We want to start up and run the react timer app, from a local environment, into the docker environment.

# START up the react timer
# Go into correct directory of where the project lives
cd ~/react-timer;
# Let's stash and get most recent copy of the repo
/usr/bin/git stash
/usr/bin/git pull
# Clean up previous react timer environment, in the docker-compose.
docker-compose down;
docker image rm -f $(docker image ls);
# Build up new react timer environment
docker-compose up -d --build;

# MAKE permissions so I can do whatever I want
DIR=$(docker container inspect client | grep "Source" | grep -o "/var/.*");
PATH=${DIR::-2};
echo "Path to rsync directory: ${PATH}";
/bin/chown larry:larry -R $PATH;
/bin/chmod 777 -R $PATH;
