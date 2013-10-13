#!/bin/bash
# source='1'
# dest='1'
# test='2'

# echo $source > /tmp/test.txt
# echo $dest >/tmp/test1.txt
# echo $test >/tmp/test2.txt
# diff /tmp/test.txt /tmp/test1.txt
# read -t5 -n1 -r -p "Press any key in the next 5 seconds..." key

# diff /tmp/test.txt /tmp/test2.txt

source=dune.iso
testing=`echo $source | cut -d"." -f1`
echo $testing

y=${source/\/*\//};
echo ${y/.*/}


#remove white space
shopt -s extglob
var='dune iso'
echo "${var//+([[:space:]])/}"

shopt -s extglob
var='dune iso'
echo "${var%%[[:space:]]*}"


a='hello:world'

b=${a%:*}

echo "$b"

a='hello:world:of:tomorrow'
echo "${a%:*}"

echo "${a%%:*}"

echo "${a#*:}"
