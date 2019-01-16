#!/usr/bin/env bash


set -o nounset

COLUMNS=${COLUMNS:-''};

if [[ "$1" == "" ]]; then
  echo "Usage : manage <command> [arguments]"
  exit
fi

CMD="$1"
shift

if [[ "$CMD" == "init" ]]; then
    RUN='git submodule init;
       git submodule update;
       git submodule foreach git checkout master;
       cd api;
       git submodule init;
       git submodule update;
       git submodule foreach git checkout master;'

elif [[ "$CMD" == "bash" ]]; then
    RUN='docker exec -it `docker ps | grep api | cut -d" " -f 1` bash'

elif [[ "$CMD" == "psql" ]]; then
    RUN='docker exec -it `docker ps | grep database | cut -d" " -f 1` bash -c "COLUMNS=\"'$COLUMNS'\" psql -U mmg_postgres mmg_db $*"'

elif [[ "$CMD" == "test-api" ]]; then
    if [[ $# == 0 ]]; then
        RUN='docker exec `docker ps | grep api | cut -d" " -f 1` bash -c "cd /opt/services/flaskapp/src/api && PYTHONPATH=. pytest --color=yes -rsx -v tests"'
    else
        RUN='docker exec `docker ps | grep api | cut -d" " -f 1` bash -c "cd /opt/services/flaskapp/src/api/tests/ && PYTHONPATH=. pytest --color=yes -rsx -v '"$*"'"'
    fi

else
    RUN='docker exec `docker ps | grep api | cut -d" " -f 1` bash -c "cd /opt/services/flaskapp/src/api/ && PYTHONPATH=. python scripts/makemegreen.py '"$CMD $*"'"'
fi

eval $RUN
