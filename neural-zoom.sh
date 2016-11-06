#! /bin/bash

main(){
	# 1. input image
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"

	style=$2
	style_dir=`dirname $style`
	style_file=`basename $style`
	style_name="${style_file%.*}"
	
	output="./output"
	out_file=$output/$input_file
  
	# 2. The amount of zoom
	zoom=$4
  
 	 #The number of frames per second
  	frames=$5
	
	
	width=`convert $input_file -format "%w" info:`
	height=`convert $input_file -format "%h" info:`

  
 

}

retry=0

neural_style(){
	echo "Neural Style Transfering "$1
	if [ ! -s $3 ]; then
		th neural_style.lua -content_image $1 -style_image $2 -output_image $3 \
				-image_size 1000 -print_iter 100 -backend cudnn -gpu 0 -save_iter 0 \
				-style_weight 20 -num_iterations 10 
			
	fi
	if [ ! -s $3 ] && [ $retry -lt 3 ] ;then
			echo "Transfer Failed, Retrying for $retry time(s)"
			retry=`echo 1 $retry | awk '{print $1+$2}'`
			neural_style $1 $2 $3
	fi
	retry=0
}

main $1 $2 $3 $4 $5





#$input_file "$clean_name"_"pixelated_""scale_""$scale".png
