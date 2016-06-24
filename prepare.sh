#!/bin/bash -x
echo Input:$1 Output:$2 
filename=$1
pdfjam --landscape --nup 2x1 $1
pages=$(pdftk ${filename%.*}-pdfjam.pdf dump_data | grep Pages | cut -d " " -f2)
./splitPDF.py ${filename%.*}-pdfjam.pdf $(seq 1 $pages) 
for i in $(seq 2 2 $pages); do pdf180 output$i.pdf; rm output$i.pdf; mv output$i-rotated180.pdf output$i.pdf; done
pdfjoin output*.pdf
mv output$pages-joined.pdf $2
rm output*
rm input*
