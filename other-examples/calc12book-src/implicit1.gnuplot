set size square 
set view 0,0
set isosamples 500,500
set contour base
set cntrparam levels discrete 0
unset surface
set grid
unset key
unset ztics
set xlabel '$x$'
set ylabel '$y$'
set lmargin at screen 0.05
set rmargin at screen 0.8
set bmargin at screen 0.1
set tmargin at screen 0.95
set linetype 2 lc rgb "#0074C8"
f(x,y) = x**3 + 3*x + 2 - y**2
splot [-4:6][-10:10] f(x,y) lw 3
set terminal epslatex color size 1.5,1.5 header "\\footnotesize"
set output 'implicit1.tex'
replot
