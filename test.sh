#/bin/bash

blue=12
grey=240
red=9
green=10
yellow=231
white=255

tput setaf $blue; echo "Running test for sqlplus"
tput setaf $grey; echo "creating test network"
docker network create oracle-test-network
port=$((30001 + RANDOM % 1000))
tmp="oracle-test-server-$port"
tput setaf $grey; echo "creating oracle-xe test server"
docker run --name "$tmp" --net=oracle-test-network -p $port:1521 -d --rm -e ORACLE_ALLOW_REMOTE=true -e ORACLE_ENABLE_XDB=true oracleinanutshell/oracle-xe-11g
tput setaf $grey; echo "waiting for server to start ~30 seconds"
sleep 30
tput setaf $grey; echo "got bored, refusing to wait any longer"
url=system/oracle@//$tmp:$port/xe
result=$(docker run --name sqlplus --net=oracle-test-network -it --rm sqlplus $url @/tmp/test.sql)

if [[ $result -eq 'X' ]]
then
	tput setaf $green; echo "passed"
else
	tput setaf $red; echo "failed: got $result, expected 'X'"
fi

tput setaf $grey; echo "cleaning up"
docker rm -f $tmp
docker network rm oracle-test-network
tput setaf $white;
