#!/bin/bash


NUMPLAY=3
echo ''
read -p "How many players would you like in the game (number greater than 0)? " -n1 NUMPLAY #Assuming they enter a proper number greater than 0
clear
echo ''
echo Welcome to the CISC220 Racing Arena!
echo ''

if (($NUMPLAY==0)) ; then
	NUMPLAY=3
elif [ "$NUMPLAY" -eq "$NUMPLAY" ] 2>/dev/null; then #If the character is not a number
	NUMPLAY=$NUMPLAY
else
	NUMPLAY=3
fi

case $NUMPLAY in
	3) echo User 1 press 1 to move forward, User 2 press 2, and User 3 press 3 ;;
	2) echo User 1 press 1 to move forward and User 2 press 2 ;;
	1) echo User 1 press 1 to move forward. You don\'t like challening yourself, do you? ;;
	*) echo User 1 press 1 to move forward, User 2 press 2, User 3 press 3, etc. ;;
esac

echo ''

car="|->"
declare -a PLAYERPOS
declare -a PLAYERCOUNT
i=1
period="."
space=" "

while (( i<=$NUMPLAY )) ; do
	PVAL=P$i
	for j in $(seq 1 44) ; do
		if (( $j==1 )) ; then
			PVAL=$car
		elif (( $j>3 && $j<=43 )) ; then
			PVAL+="."
		elif (( $j<=3 )) ; then
			continue
		else
			PVAL+="#.Lane.$i.#"
		fi
	done
	echo "${PVAL//$period/$space}"
	echo ''
	PLAYERPOS+=($PVAL)
	PLAYERCOUNT+=(0)
	i=$(($i+1))
done

maxpos=0
currentWinner=0

while (( $maxpos<40 )) ; do
	read -n1 turnNum
	if [ "$turnNum" -eq "$turnNum" ] 2>/dev/null ; then
		turnNum=$turnNum
	else
		continue
	fi
	if (( $turnNum<1 || $turnNum>$NUMPLAY )) ; then
		continue
	fi	
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
	currentIndex=$(($turnNum-1))
	currentMove=${PLAYERCOUNT[$currentIndex]}
	PLAYERCOUNT[$currentIndex]=$(($currentMove+1))
	string=${PLAYERPOS[$currentIndex]}
	string="${string:0:42}#.Lane.$turnNum.#"
	echo ''
	PLAYERPOS[$currentIndex]=${string/"|->"/"~|->"}
	for num in ${PLAYERCOUNT[*]} ; do
		if (( $num>$maxpos )) ; then
			maxpos=$num
			currentWinner=$turnNum
		fi
	done
	for player in ${PLAYERPOS[*]} ; do
		echo "${player//$period/$space}"
		echo ''
	done
done

echo Player $currentWinner WINS!

echo ''
