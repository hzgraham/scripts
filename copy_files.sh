#!/bin/bash
#script designed to perform an md5sum check of files being copied


rm /movies/md5check.txt
rm /movies/md5checkreceiving.txt
rm /movies/checkincoming.txt
rm /movies/checksource.txt
for each in `cat ~/files.to.copy`
do
cd /movies/
md5sum /costamovies/$each >> /movies/md5check.txt
md5sum --check md5check_incoming.txt

cp /costamovies/$each /movies

md5sum /movies/$each >> /movies/md5checkreceiving.txt
md5sum --check md5checkreceiving.txt

cat /movies/md5checkreceiving.txt | cut -d" " -f1 > /movies/check_destination.txt
cat /movies/md5check_source.txt | cut -d" " -f1 > /movies/checksource.txt

done


#sed -r 's/^(\S+\s+){2}//' /movies/md5checkreceiving.txt
#sed -r 's/^(\S+\s+){2}//' /movies/md5check.txt

diff /movies/checksource.txt /movies/check_destination.txt

exit 0