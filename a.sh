#/bin/bash

blue=12
grey=240
red=9
green=10
yellow=231
white=255

tput setaf $grey; docker network create oracle-test-network
port=$((30001 + RANDOM % 1000))
tmp="oracle-test-server-$port"
url="system/oracle@//${tmp}:${port}/xe"
echo port=$port
echo tmp=$tmp
echo url=$url

docker run --name "$tmp" --network oracle-test-network -p $port:1521 -d --rm -e ORACLE_ALLOW_REMOTE=true -e ORACLE_ENABLE_XDB=true oracleinanutshell/oracle-xe-11g
tput setaf $grey; echo "waiting for server to start ~30 seconds"
sleep 30
tput setaf $grey; echo "got bored, refusing to wait any longer"
tput setaf $green; echo $url
docker run --name sqlplus --network oracle-test-network -it --rm sqlplus $url @/tmp/test.sql
