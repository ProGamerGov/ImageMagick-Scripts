#! /bin/bash

main(){
	# 1. defines
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"

convert -scale 10% -scale 1000% $input_file "$clean_name"_"pixelated".png

}

retry=0
main $1
