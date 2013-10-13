#!/bin/bash
#script designed to perform an md5sum check of files being copied
shopt -s extglob
checkdir='/home/hgraham/moviechecks'
source='/home/hgraham/moviechecks/md5check_source.txt'
dest='/home/hgraham/moviechecks/md5check_dest.txt'

read -p "Are files BluRay (yes or no): " bluray
echo $bluray

for each in `cat ~/files.to.copy`
do
echo $each
if [ "$bluray" = no ]
then

md5source=`md5sum /costamovies/$each`
echo "${md5source%%[[:space:]]*}" > $source

md5dest=`md5sum /movies/$each`
echo "${md5dest%%[[:space:]]*}" > $dest

y=${each/\/*\//};
name=${y/.*/}

diff $source $dest > $checkdir/$name.txt

else

md5source=`md5sum /costamovies/BluRay/$each`
echo "${md5source%%[[:space:]]*}" > $source

md5dest=`md5sum /movies/BluRay/$each`
echo "${md5dest%%[[:space:]]*}" > $dest

y=${each/\/*\//};
name=${y/.*/}
diff $source $dest > $checkdir/$name.txt

fi
done


exit 0