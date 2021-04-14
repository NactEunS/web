container=$(docker ps -a -f name=$STAGE_NAME -q)
echo $container
if [ -n "$container" ] ;then
 docker rm -f $(docker ps -a -f name=$STAGE_NAME -q)
fi
