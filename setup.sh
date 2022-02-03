#!/bin/bash

#Create docker volumes
docker volume create mongodb1
docker volume create mongodb2
docker volume create mongodb3

#Createnig docker network
docker network create --driver=bridge --subnet=10.10.0.0/16 --ip-range=10.10.1.1/24 --gateway=10.10.0.1 rocketnet

#Generate mongo keyfile
openssl rand -base64 756 > $(pwd)/mongodbRSet/mongodb-keyfile/mongo.key

#Make permissions and owner for keyfile
chmod 400 $(pwd)/mongodbRSet/mongodb-keyfile/mongo.key 
chown  999:999 $(pwd)/mongodbRSet/mongodb-keyfile/mongo.key

#Create database users for rocket chat connect
echo "Creating database users"
docker run --name mongodb1 \
-v $(pwd)/mongodbRSet/mongodb-keyfile/:/opt/keyfile \
-v mongodb1:/data/db \
-v $(pwd)/mongodbRSet/users/create_users.js:/docker-entrypoint-initdb.d/create_users.js \
--env MONGO_INITDB_ROOT_USERNAME=root \
--env MONGO_INITDB_ROOT_PASSWORD=admin_pass \
--env MONGO_INITDB_DATABASE=admin \
-d mongo:4.4 --oplogSize 128
docker stop mongodb1
docker rm mongodb1

#Creating replicaset
echo "Starting mongoDB ReplicaSet"
docker-compose -f ./mongodbRSet/docker-compose.yml up -d

#sleep 5

#Creating RocketChat cluster
echo "Creating Rocketchat cluster"
docker-compose -f ./rocketchat/docker-compose.yml up -d


#Creating nginx 
docker-compose -f ./web/docker-compose.yml up -d


