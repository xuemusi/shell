#!/bin/bash
:<<NOTES
$1 JS目录
$2 HTML目录
NOTES
function ergodic(){  
    for file in ` ls $1 `  
    do  
		if [ -d $1"/"$file ]  
        then  
             ergodic $1"/"$file  $2
        else
			myfix="js"
			postfix="${file##*.}" #文件后缀
			filename="${file%.*}" #文件名不含后缀
			mytime=$((`date '+%s'` - 60))  #当前时间戳
			file_time=`stat -c %Y $1'/'$file` #文件最后修改时间
			#判断是否是js文件，并且更新时间比当前时间少一分钟之内 这里的时间可根据具体业务来配置
			if [ "${postfix}" = "${myfix}" ] && [ ${filename}"."${postfix} = "${file}" ] && [ $mytime -lt $file_time ]
		 	then
				replace $2 $file
			fi
        fi  
    done  
}
:<<NOTES
$1 HTML文件夹目录
$2 文件名
NOTES
function replace(){
	#避免重复替换，定义变量
	_new=''
	_old=''
	(IFS=$'\n';
    for text in `find $1  -type f -name "*.html" |  xargs grep "$2"`
    do
		#获取字符串最后出现的位置
		let pos=`echo "$text" | awk -F ''/$2'' '{printf "%d", length($0)-length($NF)}'`
		let yinhao=`echo "$text" | awk -F ''\"\>'' '{printf "%d", length($0)-length($NF)}'`
		if [ $pos -eq 0 ] || [ $yinhao -eq 0 ] 
		then
			return #找不到则返回
		fi
		fil_len=${#2} #字符长度
		str=${text:$pos:(($yinhao - $pos - 2))}
		if [ "$str"x = x ]
		then
			#第一个版本赋予v1版本
			old=$2
			new=$2?v1
		else
			#获取老版本
			old=${text:(($pos - $fil_len)):(($yinhao - $pos - 2 + $fil_len))}
			vlen=`echo "$str" | awk -F ''v'' '{printf "%d", length($0)-length($NF)}'`
			ov=$((${str:$vlen} + 1))
			new=$2?v$ov
		fi
		#a=`sed -n '/$old/p' -rl $1`
		#echo $a
		if [ "$old" != "$new" ] && [ "$_old" != "$old" ] && [ "$_new" != $new ]
		then
			_old=$old
			_new=$new
			sed -i "s/$old/$new/g" `grep $old -rl $1`
			echo $text
			echo $old" => "$new 
			echo 'done'
			echo '----'
		fi
    done
	);
}
INIT_PATH=`pwd` 
html='/home/app_h5'
js='/home/app_h5'
#ergodic $INIT_PATH $INIT_PATH
ergodic $js $html
