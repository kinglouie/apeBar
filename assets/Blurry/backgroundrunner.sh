#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARAMS=$(echo $@ | tr -d ' ' | tr -d '-')

if grep -Fq "$PARAMS" "$DIR/bgs.txt"
then
    exit 1
else
  "$DIR/Blurry" "$@" &
  BLURRY_PID=$!
  echo "$BLURRY_PID:$PARAMS" >> "$DIR/bgs.txt"
fi


while sleep 3; do
  if [ $(osascript -e 'tell application "Übersicht" to get hidden of widget id "apebar-index-coffee"') == "true" ] || [ $(kill -0 $BLURRY_PID) ]
  then
    kill -9 $BLURRY_PID
    sed -i '' "/$PARAMS/d" "$DIR/bgs.txt"
    exit 1
  fi
done
