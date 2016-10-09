#!/bin/bash

fullList=$(ls -Rl $PWD)
fullList=( ${fullList[*]} )

for i in $(seq 0 $((${#fullList[*]}-8))) ; do
	string=${fullList[$i]}
	name=${fullList[$(($i+8))]}
	if (( ${#string}==10 )) && [ "${string[0]}" = "-" ] ; then
	if  [[ $string=="*w*" || $string=="*x*" || $string=="*r*" || $string=="*-*"  ]] ; then
		echo $string $name
	fi
	fi
done

