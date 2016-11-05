 #! /bin/bash

main(){
	# 1. defines
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"

convert $input_file -colorspace Gray "$clean_name"_"greyscale".png

}

retry=0
main $1
Contact GitHub API Training Shop Blog About
© 2016 GitHub, Inc. Terms Pr
 
