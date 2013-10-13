#!/bin/bash
#script designed to perform an md5sum check of files being copied



rm -f /tmp/md5check_source.txt /tmp/md5check_dest.txt
read -p "Are files BluRay (yes or no): " bluray
echo $bluray
for each in `cat ~/files.to.copy`
do
echo $each
if [ "$bluray" = no ]
then
cp /costamovies/$each /movies
#md5sum /costamovies/$each >> /tmp/md5check_source.txt
#md5sum /movies/$each >> /tmp/md5check_dest.txt
else
cp /costamovies/BluRay/$each /movies/BluRay/
#md5sum /costamovies/BluRay/$each >> /tmp/BluRay/md5check_source.txt
#md5sum /movies/BluRay/$each >> /tmp/BluRay/md5check_dest.txt
fi

done


#sed -r 's/^(\S+\s+){2}//' /movies/md5checkreceiving.txt
#sed -r 's/^(\S+\s+){2}//' /movies/md5check.txt

#diff /movies/checksource.txt /movies/check_destination.txt

exit 0