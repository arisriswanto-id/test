#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # #
# Title : Docker Command Instruction                #
# Author: Aris Riswanto                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # #

# [0] Notes #==============================================

# Port Development = 9nnn (example: 9001) | domain => name-dev.alvindocs.com
# Port Production  = 8nnn (example: 8001) | domain => name.alvindocs.com

# =========================================================

# [1] Development #=======================================

# if fresh code, install composer
docker run --rm -v $(pwd)/src:/app composer install

# don't forget .env file

# set permission 777 (full access) for src folder
chmod 777 src -R

docker-compose config                           # Verify docker compose development config
docker-compose -p productalvindocscom-dev up -d # Start all service
docker-compose -p productalvindocscom-dev ps    # Show service status
docker-compose -p productalvindocscom-dev down  # Stop and remove all service

# =========================================================

# [2] Production #========================================

docker-compose -f docker-compose.yaml -f docker-compose.production.yaml build --no-cache     # Build image
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml build app --no-cache # Build image with specific service
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml config               # Verify docker compose production config
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml up -d                # Start all service
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml ps                   # Show service status
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml down --volume        # Stop and remove all service

# Deploying changes for production environment
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml down --volume
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml build app
docker-compose -f docker-compose.yaml -f docker-compose.production.yaml up -d

# =========================================================

docker-compose build --no-cache
docker-compose build app # Build image with specific service
docker-compose up -d
docker-compose ps
docker-compose down --volume
docker-compose exec app bash
docker-compose logs app -f
