#!/bin/bash
#script designed to perform an md5sum check of files being copied

read -p "Input where the source is mounted: " source
read -p "Input where the destination is mounted: " destination

<<<<<<< HEAD

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
=======
rm /tmp/md5check.txt
rm /tmp/md5checkreceiving.txt
rm /tmp/checkincoming.txt
rm /tmp/checksource.txt
for each in `cat ~/files.to.copy`
do
cd $destination
md5sum $source/$each >> $destination/md5check.txt
md5sum --check md5check_incoming.txt

cp $source/$each $destination

md5sum $destination/$each >> $destination/md5checkreceiving.txt
md5sum --check md5checkreceiving.txt

cat $destination/md5checkreceiving.txt | cut -d" " -f1 > $destination/check_destination.txt
cat $destination/md5check_source.txt | cut -d" " -f1 > $destination/checksource.txt
>>>>>>> 56ef4a7f258e8abe4e76a4ef7eec63b18af52259

done


#sed -r 's/^(\S+\s+){2}//' $destination/md5checkreceiving.txt
#sed -r 's/^(\S+\s+){2}//' $destination/md5check.txt

<<<<<<< HEAD
#diff /movies/checksource.txt /movies/check_destination.txt
=======
diff $destination/checksource.txt $destination/check_destination.txt
>>>>>>> 56ef4a7f258e8abe4e76a4ef7eec63b18af52259

exit 0