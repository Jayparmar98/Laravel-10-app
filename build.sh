#!/bin/bash

docker build -t jayparmar98/app1 ./app1
docker build -t jayparmar98/app2 ./app2
docker build -t jayparmar98/mysql ./mysql
docker build -t jayparmar98/redis ./redis

docker push jayparmar98/app1:latest 
docker push jayparmar98/app2:latest
docker push jayparmar98/mysql:latest
docker push jayparmar98/redis:latest

echo "Build and push Successfull"
exit