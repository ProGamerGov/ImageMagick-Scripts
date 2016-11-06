 #! /bin/bash

main(){
	# 1. Input File
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"
  
 # 2. 
 resize_value=$2

convert $input_file -resize $resize_value "$clean_name"_"resize".png

}

retry=0
main $1 $2
