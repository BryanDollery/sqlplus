#/bin/bash

sleep 0.5

if [[ $# -eq 1 ]]
then
    rlwrap /oracle/instantclient_19_6/sqlplus $1
else
    /oracle/instantclient_19_6/sqlplus -s -m 'csv on quote off' $@
fi

