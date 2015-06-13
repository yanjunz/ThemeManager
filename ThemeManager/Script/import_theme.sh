#!/bin/sh

#  import_theme.sh
#  ThemeManagerDemo
#
#  Created by zhuangyanjun on 7/8/13.
#  Copyright (c) 2013年 Leejune. All rights reserved.



inner_import_theme()
{
org=`pwd`
cd $1 &&
/usr/libexec/PlistBuddy -c "Delete res" config.plist
find res -name "*@2x.png" | while read line
do
#echo $line
if [ "$line" ]
then
line=${line%%@2x.png}
#path1=${line#res/}
echo "line=$line"
#path1=${line##*/}
#echo "path1=$path1"
path1=${line#res/}
path2=${path1%@2x.png}
echo "path2=$path2"
path3=${path2//\//_}

echo $path3
#echo "Add res:$path3 string \"/$line\""
/usr/libexec/PlistBuddy -c "Add res:$path3 string \"/$line.png\"" config.plist
fi
done
cd $org
}

inner_import_theme res/themes/classic/
inner_import_theme res/themes/orange/
