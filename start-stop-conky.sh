#!/bin/bash

cd $(dirname $0)

# 1 for conky on the right
CONKY_RIGHT=1


if pgrep conky ; then
  killall conky
else
  cd ./conky/

  if [ $CONKY_RIGHT -eq 1 ]; then
    conky -c calendar.lua &
    conky -c main.lua &
  fi
fi
