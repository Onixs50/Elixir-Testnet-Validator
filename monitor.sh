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
IMAGE_NAME="elixirprotocol/validator:v3"

start_container() {
    echo -e "${YELLOW}Starting container...${NC}"
    docker run -it \
        --env-file ~/elixir/validator.env \
        --name $CONTAINER_NAME \
        --restart unless-stopped \
        $IMAGE_NAME
}

monitor_container() {
    echo -e "${YELLOW}Monitoring container logs...${NC}"
    while true; do
        if [ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]; then
            echo -e "${RED}Container $CONTAINER_NAME stopped. Restarting...${NC}"
            sleep 10

            # Stopping and removing the container
            echo -e "${YELLOW}Killing container...${NC}"
            docker kill $CONTAINER_NAME
            sleep 10

            echo -e "${YELLOW}Removing container...${NC}"
            docker rm $CONTAINER_NAME
            sleep 20

            # Pulling the latest image
            echo -e "${YELLOW}Pulling the latest image...${NC}"
            docker pull $IMAGE_NAME --platform linux/amd64
            sleep 30

            # Starting the container again
            start_container
            echo -e "${GREEN}Container restarted. Monitoring will resume in 1 minute...${NC}"
            sleep 60
        fi
        sleep 120
    done
}

# Initial check if the container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" != "" ]; then
    echo -e "${RED}Container $CONTAINER_NAME is already running. Killing and removing...${NC}"
    docker kill $CONTAINER_NAME
    sleep 10
    docker rm $CONTAINER_NAME
    sleep 20
fi

# Pull the latest image before starting
echo -e "${YELLOW}Pulling the latest image before starting...${NC}"
docker pull $IMAGE_NAME --platform linux/amd64
sleep 30

# Start the container
start_container

# Start monitoring the container
monitor_container
