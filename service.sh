#!/bin/bash

app=$2
port=$3
user=$4
targetDir=$5

start(){
    cd ${targetDir}
    nohup java -jar *.jar --server.port=${port} >>/dev/null 2>&1& echo $! > service.pid
    cd -
    
}


stop(){
    pid=`cat service.pid`
    kill -9 ${pid}
    kill -9 ${pid}
    kill -9 ${pid}
}


case $1 in
start)
    start
    ;;
stop)
    stop
    ;;
    
restart)
    stop
    sleep 5
    start
    ;;
*)
    echo "[start|stop|restart]"
    ;;
    
esac
