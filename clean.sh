#!/bin/bash
#Script designed to remove comment and empty lines from files
#ideal for files like smb.conf

file=$1

sed '/^#\|^;\|^\s*$/d' $file > $file.bak
mv $file $file-orig
mv $file.bak $file

#${file##*/}
#sed '/^;/d' ~/smb.conf

exit 0