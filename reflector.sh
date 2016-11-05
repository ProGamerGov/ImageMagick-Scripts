#! /bin/bash

main(){
	# 1. input image
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"


	# 2. First scale value
	scale=$2


#convert -scale "$scale""%" -scale 1000% $input_file "$clean_name"_"pixelated_""scale_""$scale".png
 
 convert $input_file -alpha on   -virtual-pixel transparent \
      \( +clone -flip -channel A -evaluate multiply .35 +channel \) -append \
      +distort Barrel '0,0,0,1  0,0,-.35,1.5  32,32' \
      -gravity North  -crop 100x100+0-5\! \
      -background black -compose Over -flatten    "$clean_name"_"relection_arc".png

}

retry=0
main $1 $2 
 
 
 
