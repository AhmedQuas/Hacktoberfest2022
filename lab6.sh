#!/bin/bash

ulimit -u 1000
#zad6.0
get_result(){
	denominator=$(($1-$2))
	if [[ $denominator -eq 0 ]]; then
		echo "Mianownik nie moze byc 0"
		exit -1
	else
		result=$[($1+$2)/$denominator]
		echo "$result"
	fi
}
#zad6.1
factorial_recurisve(){
	if [[ $# -eq 1 ]]; then
		if (( $1 < 0 )); then
			echo "Argument powinien byc liczba Naturalna"
			exit 1
		elif (( $1 == 0 )); then
			echo 1
		else
			echo $(($1 * $(factorial_recurisve $(($1 - 1)) ) )) 
		fi
	else
		echo "Podano nie wlasciwa liczbe arg"
		exit -1
	fi
}
#zad6.2
factorial(){
	if [[ $# -eq 1 ]]; then
		if (( $1 < 0 )); then
			echo "Argument powinien byc liczba Naturalna"
			exit 1
		fi
		f1=0
		for (( i = 0; i <= "$1"; i++ )); do
			if [[ "$i" == 0 ]]; then
				f1=1
			else
				f1=$(("$f1"*"$i"))
			fi
		done
		echo "factorial($1) = $f1"
	else
		echo "Funkcja powinna przyjmowac 1 arg"
		exit -1
	fi
}
#zad6.3
sum_args(){
	sum=0
	for item in "$@"; do
		sum=$(($sum+$item))
	done
	echo "sum_args() = $sum"
}


get_result "$@"

factorial_recurisve "$1"

factorial "$1"

sum_args "$@"

