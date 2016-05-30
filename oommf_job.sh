#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Running OOMMF in batch mode. The command will terminate all OOMMF instances after done
#oommf.sh boxsi -pause 0 -threads 8 -kill all $1.mif

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#"odtcols" will extract column "13" and "19" which correspond to applied field Bx and Magnetization direction mx and removing the comments with sed.
#oommf.sh odtcols col 13 19 14 20 <$1.odt | sed '/#/d' > $2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Data Processing, Calculating absolute value of B and M
#awk '{print sqrt($1*$1+$3*$3),sqrt($2*$2+$4*$4)}' $2 > $3

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Plotting with gnuplot and making a video
#gnuplot "script gnuplot"
#echo '#!/bin/gnuplot' > plot.gpi
#echo 'n=0' >> plot.gpi
#echo 'do for [i=1:1200:1]{' >> plot.gpi
#echo 'n=n+1' >> plot.gpi
#echo 'set xrange [0:400]' >> plot.gpi
#echo 'set yrange [0:1]' >> plot.gpi
#echo 'set term png size 1600,1200' >> plot.gnu
#echo "set output sprintf('hyst%04.0f.png',n)" >> plot.gpi
#echo "set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5" >> plot.gpi
#echo 'set pointintervalbox 3' >> plot.gpi
#echo "plot '"$3"' using 1:2 every ::1::n with lines ls 1, '"$3"' using 1:2 every ::n::n with points ls 1" >> plot.gpi
#echo 'reset}' >> plot.gpi
echo '#!/bin/gnuplot' > plot.gpi
echo 'n=0' >> plot.gpi
echo 'do for [i=1:1200:1]{' >> plot.gpi
echo '	n=n+1' >> plot.gpi
echo ' 	set key at 350,0.2' >> plot.gpi
echo '	set xlabel "Applied Field (mT)"' >> plot.gpi
echo '	set xrange [0:400]' >> plot.gpi
echo '	set ylabel "Mean Magnetization(M/Ms)"' >> plot.gpi
echo '	set yrange [0:1]' >> plot.gpi
echo '	set term png size 1600,1200' >> plot.gpi
echo "	set output sprintf('hyst%04.0f.png',n)" >> plot.gpi
echo "	if (n<=201) {plot '"$3"' using 1:2 every ::1::n t '0_deg' with lines lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::n::n t 'point' with points lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5} else {" >>  plot.gpi
echo "			if (201<n && n<=402) {plot '"$3"' using 1:2 every ::1::201 t '0_deg' with lines lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::202::n t '30_deg' with lines lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::n::n t 'point' with points lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5} else {" >>  plot.gpi
echo "						if (402<n && n<=604) {plot '"$3"' using 1:2 every ::1::201 t '0_deg' with lines lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::202::402 t '30_deg' with lines lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::403::n t '60_deg' with lines lc rgb '#ff0012' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::n::n t 'point' with points lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5} else {" >> plot.gpi
echo "										if (604<n && n<=805) {plot '"$3"' using 1:2 every ::1::201 t '0_deg' with lines lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::202::402 t '30_deg' with lines lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::403::604 t '60_deg' with lines lc rgb '#ff0012' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::605::n t '90_deg' with lines lc rgb '#d700ff' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::n::n t 'point' with points lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5} else {" >> plot.gpi
echo "															if (805<n && n<=1006) {plot '"$3"' using 1:2 every ::1::201 t '0_deg' with lines lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::202::402 t '30_deg' with lines lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::403::603 t '60_deg' with lines lc rgb '#ff0012' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::604::805 t '90_deg' with lines lc rgb '#d700ff' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::806::n t '120_deg' with lines lc rgb '#00ff1d' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::n::n t 'point' with points lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5} else {" >> plot.gpi
echo "																					plot '"$3"' using 1:2 every ::1::201 t '0_deg' with lines lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::202::402 t '30_deg' with lines lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::403::603 t '60_deg' with lines lc rgb '#ff0012' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::604::805 t '90_deg' with lines lc rgb '#d700ff' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::806::1006 t '120_deg' with lines lc rgb '#00ff1d' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::1007::n t '150_deg' with lines lc rgb '#ff8d00' lt 1 lw 2 pt 7 pi -1 ps 1.5, '"$3"' using 1:2 every ::n::n t 'point' with points lc rgb '#000000' lt 1 lw 2 pt 7 pi -1 ps 1.5}}}}}" >> plot.gpi

echo 'set pointintervalbox 3' >> plot.gpi
echo '}' >> plot.gpi
chmod +x plot.gpi
./plot.gpi
ffmpeg -framerate 6 -i hyst%04d.png -c:v libx264 -vf "fps=60,format=yuv420p" $3.mp4 #making a video
rm *.png #cleaning up the images, can be removed but better not removed ;).
