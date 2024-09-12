#!/bin/bash

clear

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

echo -e "${LIGHT_BLUE}#########################################"
echo -e "# ${GREEN}Designed by onixia${LIGHT_BLUE} #"
echo -e "#########################################${NC}"

CONTAINER_NAME="elixir"
WORKING_DIR="$HOME/elixir"
IMAGE_NAME="elixirprotocol/validator:v3"

start_container() {
    echo -e "${YELLOW}Starting container...${NC}"
    docker run -it \
      --env-file ~/elixir/validator.env \
      --name $CONTAINER_NAME \
      --restart unless-stopped \
      $IMAGE_NAME
}

echo -e "${YELLOW}Checking container status...${NC}"

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" != "" ]; then
    echo -e "${RED}Container $CONTAINER_NAME is already running. Stopping and removing...${NC}"
    docker stop $CONTAINER_NAME
    sleep 30
    docker rm -f $CONTAINER_NAME
    sleep 20
fi

start_container

while true; do
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]; then
        echo -e "${RED}Container $CONTAINER_NAME is not running. Removing and restarting...${NC}"
        sleep 10
        docker rm -f $CONTAINER_NAME
        sleep 20
        start_container
    fi
    sleep 120
done
