#!/bin/bash
#script to copy movies

read -p "Are files BluRay (yes or no): " bluray
echo $bluray
for each in `cat ~/files.to.copy`
do
echo $each
if [ "$bluray" = no ]
then
cp /costamovies/$each /movies

else
cp /costamovies/BluRay/$each /movies/BluRay/

fi

done

exit 0