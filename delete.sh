container=$(docker ps -a -f name=springbootdemo -q)
echo $container
if [ -n "$container" ] ;then
 docker rm -f $(docker ps -a -f name=springbootdemo -q)
fi
