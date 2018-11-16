#!/bin/bash

# creates the new docker image from ubuntu and install timescaledb into it
docker build - < Dockerfile

# get the id of last running container in variable var
var=$(docker ps -a -l | tail -n 1 | awk '{print $1}'| tail -1)

#docker commit "$var" new_test_image

# get the id of last running image in variable img
img=$(docker images | head -n 2 | awk '{print $3}' | tail -1)

# pring variable img (id of new created image)
echo "$img"

# tag the docker image with some name
docker tag "$img"  new_test_image

# run the docker image with container running in background
docker run -t -d new_test_image

# get the id of last running container in variable var
var=$(docker ps -a -l | tail -n 1 | awk '{print $1}'| tail -1)

# print variable var (id of running container)
echo "$var"

# copy tweets data to docker container
docker cp ~/tweets.csv "$var":/

# copy tweets sql file to docker container
docker cp ~/tweets.sql "$var":/

# execute command on container to start postgresql server, make postgres user be available 
# without password by changing pg_hba.conf file, restart the postgres server
# and finally run the tweets.sql file to create database & table to load data tweets.csv
docker exec -i -t "$var" sh -c "service postgresql start && sed -i '0,/peer/{s/peer/trust/}' /etc/postgresql/10/main/pg_hba.conf && sed -i '0,/peer/{s/peer/trust/}' /etc/postgresql/10/main/pg_hba.conf && service postgresql restart && psql -U postgres < tweets.sql"

# save the changes to docker image named as new_test_image
docker commit "$var" new_test_image

# stop the container running in the background to free up resources
docker stop "$var"
