#!/bin/bash
# A Tic Tac Toe game

board=(_ _ _ _ _ _ _ _ _)
slots=(0 1 2 3 4 5 6 7 8)
play=1
turn=1
sym=X
placeholder=_

print(){
	echo ========= The Board =======
 	echo " ${board[0]} ${board[1]} ${board[2]} "
	echo " ${board[3]} ${board[4]} ${board[5]} "
	echo " ${board[6]} ${board[7]} ${board[8]} "
	echo ===========================
}

checkboard(){
        if [ ! ${board[$1]} = "_" ] && [ ${board[$1]} = ${board[$2]} ] && [ ${board[$2]} = ${board[$3]} ]
	then
                echo "${board[$1]} won!"
		play=0
        fi
	return 1
}

checkstatus(){
	checkboard 0 1 2
	checkboard 3 4 5
	checkboard 6 7 8
	checkboard 0 4 8
	checkboard 2 4 6
	checkboard 0 3 6
	checkboard 1 4 7
	checkboard 2 5 8
}

get_turn(){
	if [ $turn -eq 1 ]; then
		echo "Player 1 turn: Select a spot ${slots[@]}"
		read slot
		turn=2
		sym=X
	else
		echo "Player 2 turn: Select a spot ${slots[@]}"
		read slot
		turn=1
		sym=O
	fi
}

reset_turn() {
		if [ $turn -eq 1 ]; then
			turn=2
		else
			turn=1
		fi
}

echo
echo "**** Staring Game: Player1 is X - Player2 is O ****"
# print the board
print

while [ $play -eq 1 ]; do
    get_turn
	if [[ ! " ${board[@]} " =~ " ${placeholder} " ]]; then
		echo "Game over! No spot available."
		play=0
		break
	elif [[ ! $slot =~ ^[0-8]$  ]]; then
		echo "Invalid input"
		reset_turn		
	elif [ ! ${board[$slot]} = _ ]; then
		echo "slot $slot occupied choose another one"
		reset_turn
	else
		board[$slot]=$sym
		print
		checkstatus

		if [ $play -eq 0 ]; then
				break
		fi
	fi
done
	
