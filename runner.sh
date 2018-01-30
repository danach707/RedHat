#!/bin/bash

#catching SIGINT (CTRL+C or kill)
trap echo $? SIGINT

#flags
cpcapfile=0
systrace=0

#check arguments
for var in "$@"
do
  if [ $var == "--debug" ]
  then
    echo setting debug
    set -x
  fi
  if [ $var == "--net-trace" ]
  then
    echo setting net-trace
    cpcapfile=1
  fi
  if [ $var == "--sys-trace" ]
  then
    echo setting sys-trace
    systrace=1
  fi
done

#executing the command
read command
eval $command
retCode=$?

if [ $retCode != 0 ]
then
  if [ $cpcapfile == 1 ]
  then
    netstat -an -e -sp IP > pcap.log
  fi
  if [ $systrace == 1 ]
  then
    ps -ejH > processes.log
    ip -s link > networkCard.log
  fi
fi

echo "Command return Code: $retCode"
