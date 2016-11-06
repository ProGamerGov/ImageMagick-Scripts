#! /bin/bash

main(){
	# 1. input image
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"


	# 2. First scale value
	scale=$2


#convert -scale "$scale""%" -scale 1000% $input_file "$clean_name"_"pixelated_""scale_""$scale".png
 
convert -quiet "$infile" $dir/tmpI.mpc
fact=`convert xc: -format "%[fx:$amount/100]" info:`
convert $dir/tmpI.mpc \
\( +clone -fill $color -colorize 100% \) \
\( -clone 0 -modulate 100,0,100 -solarize 50% -level 0x50% -evaluate multiply $fact \) \
-compose overlay -composite "$outfile"

}

retry=0
main $1 $2 
 
 
 
