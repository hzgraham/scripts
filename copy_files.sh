#!/bin/bash
#script designed to perform an md5sum check of files being copied

read -p "Input where the source is mounted: " source
read -p "Input where the destination is mounted: " destination

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

done


#sed -r 's/^(\S+\s+){2}//' $destination/md5checkreceiving.txt
#sed -r 's/^(\S+\s+){2}//' $destination/md5check.txt

diff $destination/checksource.txt $destination/check_destination.txt

exit 0