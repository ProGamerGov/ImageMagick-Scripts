#! /bin/bash

# Check for output directory, and create it if missing
#if [ ! -d "$output" ]; then
#  mkdir output
#fi

#./neural-zoom.sh 92fXY3q.jpg 92fXY3q.jpg 75 75 1 1 
#./neural-zoom.sh content_image style_image zoom_value rotation_value num_frames

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


#convert -rotate $rotation_value -gravity center -crop "$widthcrop"x"$heightcrop"+0+0 $input_file "$num_frames"_"""$clean_name""_zoom_""$zoom""_rotation_degrees_""$rotation_value".png

neural_style $input $style $out_file
v_frames=0

###############################################

for r in `seq 1 $num_frames`;
do 

v_frames=`echo $v_frames 1 | awk '{print $1+$2}'`

"$v_frames_""$clean_name".png

convert -rotate $rotation_value -gravity center -crop "$widthcrop"x"$heightcrop"+0+0 $input_file "$v_frames_""$clean_name".png
out_file="$v_frames_""$clean_name".png
neural_style $input $style $out_file

done

###############################################


convert -rotate $rotation_value -gravity center -crop "$widthcrop"x"$heightcrop"+0+0 $input_file "$num_frames"_"""$clean_name".png



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
