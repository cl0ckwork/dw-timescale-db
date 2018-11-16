#!/bin/bash

docker build - < Dockerfile

var=$(docker ps -a -l | tail -n 1 | awk '{print $1}'| tail -1)

#docker commit "$var" new_test_image

img=$(docker images | head -n 2 | awk '{print $3}' | tail -1)

echo "$img"

docker tag "$img"  new_test_image

docker run -t -d new_test_image

var=$(docker ps -a -l | tail -n 1 | awk '{print $1}'| tail -1)

echo "$var"

docker cp ~/tweets.csv "$var":/

docker cp ~/tweets.sql "$var":/

docker exec -i -t "$var" sh -c "service postgresql start && sed -i '0,/peer/{s/peer/trust/}' /etc/postgresql/10/main/pg_hba.conf && sed -i '0,/peer/{s/peer/trust/}' /etc/postgresql/10/main/pg_hba.conf && service postgresql restart && psql -U postgres < tweets.sql"

docker commit "$var" new_test_image

docker stop "$var"
