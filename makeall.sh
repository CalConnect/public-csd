#!/bin/bash

ERRORS=()

if ! [ -d published ]
then
  mkdir published
fi

for d in csd-*/
do
  cd $d
  make clean all publish
  RESULT=$?
  if [ $RESULT -eq 0 ]
  then
    if [ -d published/documents ]
    then
      cp published/documents/*.xml ../published
    elif [ -d published ]
    then
      cp published/*.xml ../published
    else
      ERRORS+=("there isn't published dir for: ${d}")
    fi
  else
    ERRORS+=("compile error: ${d}")
  fi
  cd ..
done

l=${#ERRORS[@]}
for ((i=0; i<l; i++))
do
  echo "${ERRORS[i]}"
done