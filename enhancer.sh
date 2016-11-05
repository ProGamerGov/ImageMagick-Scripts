#! /bin/bash

main(){
	# 1. input image
	input=$1
	input_file=`basename $input`
	clean_name="${input_file%.*}"


	# 2. First scale value
	scale=$2


#convert -scale "$scale""%" -scale 1000% $input_file "$clean_name"_"pixelated_""scale_""$scale".png

--no-interface --no-data --no-fonts --batch commands

gimp --batch (gimp-file-save RUN-NONINTERACTIVEimage drawable filename filename)(gimp-image-delete image))(set! filelist (cdr filelist)))))


  (define (batch-auto-fix pattern  
                radius  
                amount  
                threshold)  
  (let* ((filelist (cadr (file-glob pattern 1))))  
   (while (not (null? filelist))  
      (let* ((filename (car filelist))  
          (image (car (gimp-file-load RUN-NONINTERACTIVE  
                        filename filename)))  
          (drawable (car (gimp-image-get-active-layer image))))  
       (plug-in-unsharp-mask RUN-NONINTERACTIVE  
                  image drawable radius amount threshold)  
       (gimp-levels-stretch drawable)  
       (plug-in-color-enhance RUN-NONINTERACTIVE  
                  image drawable)  
       (gimp-file-save RUN-NONINTERACTIVE  
               image drawable filename filename)  
       (gimp-image-delete image))  
      (set! filelist (cdr filelist)))))  

}

retry=0
main $1 $2
