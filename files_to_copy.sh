#!/bin/bash

IFS=$'\n'

rm -f ~/files_copied.txt
rm -f ~/files.to.copy
filescopied=`ls /movies/BluRay/`
files=`ls /costamovies/BluRay/`

for each in $filescopied
do
echo $each >> ~/files_copied.txt
done

for each in $files; do
testc=`grep $each ~/files_copied.txt`
if [ -z $testc ]; then
echo $each >> ~/files.to.copy
fi
done




