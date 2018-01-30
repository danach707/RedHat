#!/bin/bash
x=0
while [ $x -lt 5000 ]
do
  echo $x
  x=$[$x+1]
done

eval "ls -l"
eval "pwd"
