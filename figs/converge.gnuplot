set terminal pdf enhanced dashed size 8in,4in
set output "figs/converge.pdf"

#set tmargin 0
#set bmargin 0
#set lmargin 0
#set rmargin 0

set xtics scale 0 nomirror
set ytics scale 0 nomirror

set style line 1 linetype 1 linecolor rgb "#56B4E9" linewidth 3 pointtype 1
set style line 2 linetype 2 linecolor rgb "#E69F00" linewidth 3 pointtype 2
set style line 3 linetype 3 linecolor rgb "#009E73" linewidth 3 pointtype 3
set style line 4 linetype 4 linecolor rgb "#F0E442" linewidth 3 pointtype 4
set style line 5 linetype 5 linecolor rgb "#0072B2" linewidth 3 pointtype 5
set style line 6 linetype 6 linecolor rgb "#D55E00" linewidth 3 pointtype 6
set style line 7 linetype 7 linecolor rgb "#CC79A7" linewidth 3 pointtype 7
set style line 8 linetype 8 linecolor rgb "#000000" linewidth 3 pointtype 8

set grid

set style fill transparent solid 0.5 border
set style data lines

set xlabel "Step"
set ylabel "{\hat{R}^p}"

set xrange [0:2500]
set yrange [1:1.02]

plot \
"Rp1.csv" title "PF0" linestyle 1, \
"Rp2.csv" title "MUPF0" linestyle 2, \
"Rp3.csv" title "CUPF0" linestyle 3, \
"Rp4.csv" title "PF1" linestyle 4,\
"Rp5.csv" title "MUPF1" linestyle 5,\
"Rp6.csv" title "CUPF1" linestyle 6
