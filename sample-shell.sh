#!/bin/bash
#z1
file -i $1
#z2
cat $1 | wc -l
#z3
cat $1 | wc -m
#z4
du -h $1
#z5
grep $2 $1 | wc -l 
#z6
cat $1 | grep -v $2 | wc -l
#z7
cat $1 | head -n 5| tail -n 1

