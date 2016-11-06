#! /bin/bash

# Check for output directory, and create it if missing
#if [ ! -d "$output" ]; then
#  mkdir output
#fi

#./neural-zoom.sh 92fXY3q.jpg 92fXY3q.jpg 75 0 1

main(){
	# 1. input image
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"
	
	# 2. Style image
	style=$2
	style_dir=`dirname $style`
	style_file=`basename $style`
	style_name="${style_file%.*}"
	

	# 4. Zoom value
	zoom=$4
	
	#5. Rotation value
	rotation_value=$5
	
	#6. Number of frames
	
	num_frames=$6
	
	width=`convert $input_file -format "%w" info:`
	height=`convert $input_file -format "%h" info:`

widthcrop=`echo $width $zoom | awk '{print $1-$2}'`
heightcrop=`echo $height $zoom | awk '{print $1-$2}'`


convert -rotate $rotation_value -gravity center -crop "$widthcrop"x"$heightcrop"+0+0 $input_file "$num_frames"_"""$clean_name""_zoom_""$zoom""_rotation_degrees_""$rotation_value".png

#convert -scale "$scale""%" -scale 1000% -resize "$width"x"$height" $input_file "$clean_name"_"pixelated_""scale_""$scale".png
#convert -scale "$scale""%" -scale 1000% $input_file "$clean_name"_"pixelated_""scale_""$scale".png


}

retry=0

neural_style(){
	echo "Neural Style Transfering "$1
	if [ ! -s $3 ]; then
		th neural_style.lua -content_image $1 -style_image $2 -output_image $3 \
				-image_size 1000 -print_iter 100 -backend cudnn -gpu 0 -save_iter 0 \
				-style_weight 20 -num_iterations 10 
				#-original_colors 1
	fi
	if [ ! -s $3 ] && [ $retry -lt 3 ] ;then
			echo "Transfer Failed, Retrying for $retry time(s)"
			retry=`echo 1 $retry | awk '{print $1+$2}'`
			neural_style $1 $2 $3
	fi
	retry=0
}
main $1 $2 $3 $4 $5 $6
