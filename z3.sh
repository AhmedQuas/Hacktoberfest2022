#!/usr/bin/env bash

check_digit(){
	if ! [[ $1 =~ ^[0-9]+$ ]]; then
		echo 'podane argumenty nie sa poprawne'
		return 1 #false
	else
		return 0 #true
	fi
	
}

if check_digit $1 && check_digit $2 && [[ "${#}" -eq 2 ]]; then
	echo "$(($1+$2)) = $1 + $2"
	echo "$(($1-$2)) = $1 - $2"
	echo "$(($1*$2)) = $1 * $2"
	echo "$(($1/$2)) = $1 / $2"
else
	echo 'podane argument/y nie jest/sa liczba'
fi
#[[ ]]-> jako test 
#test --help
#(( )) -> C syntax
#()
