#!/bin/bash

NUM1=a
RESULT=0

while true ; do

	case $NUM1 in
		*[!0-9]*) read -p "Please insert a number: " NUM1 ;;
		*) break ;;
	esac
done
echo $NUM1
