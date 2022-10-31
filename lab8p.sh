#!/bin/bash 

#z0
function z0(){
	#$1->src file
	#$2->dst file
	#$3->dst file
	if ! [[ -r $1 ]];then
    	echo "You do not have permission to read this file. Exiting..."
    	exit -1
	fi
	if [[ -f $2 ]];then
    	echo "1st destination file exist"
    	if [[ -w $2 ]];then
    		echo "You have write permission to 1st destination file"
    	else
    		echo "You do NOT have write permission to 1st destination file. Exiting..."
    	fi
    	>$2
	else
		touch $2
	fi
	if [[ -f $3 ]];then
    	echo "2st destination file exist"
    	if [[ -w $3 ]];then
    		echo "You have write permission to 2st destination file"
    	else
    		echo "You do NOT have write permission to 2st destination file. Exiting..."
    	fi
    	>$3
	else
		touch $3
	fi

	counter=1
	while IFS= read -r line;do
		if [[ $((counter%2)) == 0 ]];then
			echo "#$counter $line">>"$3"
		else
			echo "#$counter $line">>"$2"
		fi
		#echo "$counter" testing purpouse
		counter=$((counter+1))
	done<"$1" 
}

#z1
function z1(){
	#$1->directory location
	#$2->dir/files to create
	
	if [[ -d $1 ]];then
    	echo "Source directory exist"
    else
    	echo "Source directory do not exist. Exiting..."
    	exit 1
	fi
	if [[ -w $1 ]];then
    	echo "You have permission to create files/directories here"
    else
    	echo "You do not have permission to create files/directories here. Exiting..."
    	exit 2
	fi
	if [[ -f $2 ]];then
    	echo "File as 2nd arg exist"
    else
    	echo "File as 2nd arg do not exist. Exiting..."
    	exit 3
	fi
	if [[ -r $2 ]];then
    	echo "You have permission to read that file"
    else
    	echo "You do not have permission to read that file. Exiting..."
    	exit 4
	fi
	while IFS= read -r line;do
		#if line match regex
		if [[ $line == D:* ]];then
			dir_path=$(echo ${line} | cut -c 3- )
			full_path=$1$dir_path
			#echo "$dir_path" test purpouse
			if ! [[ -d $full_path ]];then
				mkdir -p $full_path
			fi
		elif [[ $line == F:* ]];then
			file_path=$(echo ${line} | cut -c 3- )
			full_file_path=$1$file_path
			#echo "$file_path" test purpouse
			if ! [[ -f $full_file_path ]];then
				#get dir path
				file_name=$(echo ${line} | rev | cut -d / -f1 | rev )
				file_name_len="${#file_name}"
				dir_full_path="${full_file_path::-(file_name_len+1)}"
				if [[ -d $dir_full_path ]];then
					touch "$dir_full_path/$file_name"
				else
					mkdir -p "$dir_full_path"
					touch "$dir_full_path/$file_name"
					#create a subdirectories
				fi
			fi
		#else
			#do not match any pattern
		fi		
	done<"$2" 
	#hint
	#echo "F:/payhe/to/dir" | rev | cut -d / -f1 | rev
}

function cutter(){
	test="D:/path/to/directory"
}
function test2(){
	x="D:/path/to/directory"
	file_name=$(echo ${x} | rev | cut -d / -f1 | rev )
	file_name_len="${#file_name}"
	echo "$x"
	echo "${x::-(file_name_len+1)}"
}

#cutter "$@"
#z0 "$@"
#test2 "$@"
z1 "$@"
