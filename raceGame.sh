#!/bin/bash


NUMPLAY=3
echo ''
read -p "How many players would you like in the game (number greater than 0)? " NUMPLAY #Assuming they enter a proper number greater than 0
clear
echo ''
echo Welcome to the CISC220 Racing Arena!
echo ''

case $NUMPLAY in
	3) echo User 1 press 1 to move forward, User 2 press 2, and User 3 press 3 ;;
	2) echo User 1 press 1 to move forward and User 2 press 2 ;;
	1) echo User 1 press 1 to move forward. You don\'t like challening yourself, do you? ;;
	*) echo User 1 press 1 to move forward, User 2 press 2, User 3 press 3, etc. ;;
esac

echo ''

declare -a PLAYERPOS
i=1

while (( i<=$NUMPLAY )) ; do
	PVAL=P$i
	declare -a PVAL
	for j in $(seq 1 42) ; do
		if (( $j==1 )) ; then
			PVAL=("|->")
		elif (( $j<=41 )) ; then
			PVAL+=(' ')
		else
			PVAL+=("# Lane $i #")
		fi
	done
	echo ${PVAL[*]}
	PLAYERPOS+=(${PVAL})
	i=$(($i+1))
done

echo $PLAYERPOS

