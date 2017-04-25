
docker rmi $(docker images | awk '{print $3}' | sed -n '2,$p')

