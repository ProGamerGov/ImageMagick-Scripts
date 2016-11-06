#! /bin/bash

main(){
	# 1. input image
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"


	# 2. First scale value
	scale=$2
	
	width=`convert $input_file -format "%w" info:`
	height=`convert $input_file -format "%h" info:`

convert -scale "$scale""%" -scale 1000% -resize "$width"x"$height" $input_file "$clean_name"_"pixelated_""scale_""$scale".png
#convert -scale "$scale""%" -scale 1000% $input_file "$clean_name"_"pixelated_""scale_""$scale".png


}

retry=0
main $1 $2
