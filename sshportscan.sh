#!/bin/bash

RHOST="root@host"
PASSWD="password"
PORT=1
TPORT=1025

#(sleep 5;echo $PASSWD)|socat PTY,LINK=SSH,raw,echo=1 EXEC:"ssh $RHOST",pty,ctty,setsid,nonblock,raw,echo=1
(socat PTY,nonblock,LINK=SSH,echo=0,raw exec:"ssh $RHOST",pty,setsid,ctty,nonblock,echo=0)&
sleep 3;echo $PASSWD > SSH
sleep 3
while [[ $PORT -lt $TPORT ]];do
echo "~C" > SSH
sleep 0.01
echo "-L 54545:localhost:$PORT" > SSH
sleep 0.01
### DO PORTSCAN
if [ -z "$(curl -m 1 localhost:54545 2>&1| egrep 'refused|Empty reply|timed out')" ]; then echo "$PORT open" ;fi
echo "~C" > SSH
sleep 0.01
echo "-KL 54545" > SSH
sleep 0.01
PORT=`expr $PORT + 1`
echo "echo alive" > SSH
done
pkill socat
