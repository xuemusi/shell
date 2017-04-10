cppath='/home/cp/*'
cpback='/home/back/'
ignore='/home/cp/a/*'
cp -f  -r  `find $cppath  -type d -path $ignore  -prune -o -print | sed 1d ` $cpback
