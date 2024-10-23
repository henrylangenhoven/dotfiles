#!/usr/bin/bash

docker compose -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.brp-adapter.yml -f docker-compose.robot-in-docker.yml --profile everything pull