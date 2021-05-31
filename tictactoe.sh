#!/bin/bash
declare -a users=(p1 p2)
declare -a ids=(X O)
declare -a r=1
let moves=0
let attack=0
let v=0
let vc=0
player=1

reset(){
echo "====================="
echo "TicTacToe"
Arr=(. . . . . . . . .)
gamestatus=1
echo "====================="
echo "Game started :)"
}

play_first()
{
player=1
}

play_second()
{
player=2
}

set(){
idx=$(( $1 * 3 + $2 ))
if [ ${Arr[$idx]} == "." ]; then
        sym=${ids[0]}
        Arr[$idx]=$sym
        player=$((player%2+1))
        let moves++
        let v++
else
        echo "You can't place there!"
fi
}

random(){
        idx=$(( $RANDOM % 9 ))
        if [ ${Arr[$idx]} == "." ]; then
                sym=${ids[1]}
                Arr[$idx]=$sym
                player=$((player%2+1))
                let moves++
                let vc++
        else
                random
        fi
}

print(){
echo "r\c 0 1 2"
echo "0   ${Arr[0]} ${Arr[1]} ${Arr[2]}"
echo "1   ${Arr[3]} ${Arr[4]} ${Arr[5]}"
echo "2   ${Arr[6]} ${Arr[7]} ${Arr[8]}"
}

change_symbols()
{
        local o
        local x
        read -p 'Symbol jaki zmieni O :' o
        read -p 'Symbol jaki zmieni X :' x
        ids=($x $o)
}

checkmatch(){
if [ ${Arr[$1]} != "." ] && [ ${Arr[$1]} == ${Arr[$2]} ] && [ ${Arr[$2]} == ${Arr[$3]} ]; then
        gamestatus=0
fi
}

checkgame(){
checkmatch 0 1 2
checkmatch 3 4 5
checkmatch 6 7 8
checkmatch 0 3 6
checkmatch 1 4 7
checkmatch 2 5 8
checkmatch 0 4 8
checkmatch 2 4 6
}

while getopts ":hucro" opt; do
          case ${opt} in
                  h)    echo -e '
h - pomoc  (wszystkie parametry i ich objaśnienia)
u - grasz pierwszym (domyslnie)
c - grasz drugim
r - redefinicja symbol
o - grać kolkiem
x - grac krzyzykiem (domyslnie)
                        ';;
                r) change_symbols;;
                  c) play_second;;
                  o) ids=(O X);;
                  x) ids=(X O);;
                  u) play_first;;
         esac
done

reset
print
game(){
        local u=$player
        case $u in
                1)  sym=${ids[0]}
                        echo "Yours turn: ($sym)"
        echo ""
        echo "  Command:"
        echo "  1. set [row] [column]"
        echo "  2. restart"
         while [ 1 == 1 ]; do
                read -r cmd a b
                if [ $cmd = "set" ]; then
                        set $a $b
                        break
                elif [ $cmd = "restart" ]; then
                        reset
                        break
                else
                        echo "wrong command, try again."
                fi
        done
        print
        checkgame
        if [ $moves = 9 ]; then
                 echo "TIE"
                 exit 0
        fi
        if [ $gamestatus != 1 ]; then
                echo "Gameover"
                player=$((player%2+1))
                if [ $player = 1 ]; then
                echo "You ($sym) win!! Computer moves: $vc Your moves: $v"
        else
                echo "You lose!! Computer moves: $vc. Your moves: $v"
        fi
                while [ 1 == 1 ]; do
                        read -r cmd n
                        if [ $cmd == "restart" ]; then
                                reset
                                break
                        fi
                done
        fi
;;
2)  sym=${ids[1]}
        echo "Computer's turn: ($sym)"
        random
        print
        checkgame
        if [ $moves = 9 ]; then
                        echo "REMIS"
                        exit 0
        fi
        if [ $gamestatus != 1 ]; then
                echo "Gameover"
                player=$((player%2+1))
                if [ $player = 1 ]; then
                echo "You ($sym) win!!  Computer moves: $vc Your moves: $v"
        else
                echo "You lose!! Computer moves: $vc Your moves: $v"
        fi
                while [ 1 == 1 ]; do
                        echo "Enter "restart" to play again ;)"
                        read -r cmd n
                        if [ $cmd == "restart" ]; then  reset
                                break
                        fi
                done
        fi
;;
esac
}
until [[ $moves = 9 ]]; do
game
done
