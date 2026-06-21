set zeroaxis
set samples 5000
set xlabel '$x$'
set ylabel '$y$'
set grid
unset key
plot [0:4][0:6] x**3 - 6*x**2 + 9*x + 1 lw 3 lc rgb "#0074C8"
set terminal epslatex color size 3.5in,2.5in header "\\footnotesize"
set output 'calc12ex48.tex'
replot

plot [-4:4][-1:1] -x/(1 + x**2) lw 3 lc rgb "#0074C8"
set terminal epslatex color size 3.5in,2.5in header "\\footnotesize"
set output 'calc12ex49.tex'
replot

plot [-2:2] x**(1./3.) lw 3 lc rgb "#0074C8",(-x)**(1./3.) lw 3 lc rgb "#0074C8"
set terminal epslatex color size 2.5in,1.5in header "\\footnotesize"
set output 'calc12ex410.tex'
replot

set zeroaxis
set samples 5000
set xlabel '$\frac{r}{a_0}$'
set ylabel '$a_0 D\left(\tfrac{r}{a_0}\right)$'
set grid
unset key
plot [0:6] 4*(x**2)*exp(-2*x) lw 3 lc rgb "#0074C8"
set terminal epslatex color size 3.5in,2.5in header "\\footnotesize"
set output 'calc12ex412.tex'
replot

set zeroaxis
set samples 5000
set size 1,0.8
set terminal epslatex color solid rounded
set xlabel '$\tau/\epsilon$'
set output 'thermalex.tex'
set key center right vertical noautotitles spacing 12
set title 'Average Energy $U/\epsilon$ vs Heat Capacity $C_V/k_B$'
plot [0:5] exp(-1/x)/(1+exp(-1/x)) lt 0 lw 3 title '$U/\epsilon = \dfrac{e^{-\epsilon/\tau}}{1 + e^{-\epsilon/\tau}}$',  exp(1/x)/((x**2)*(1+exp(1/x))**2) lc rgb "#0074C8" lw 3 title '$C_V/k_B = \left(\dfrac{\epsilon}{\tau}\right)^2 \dfrac{e^{\epsilon/\tau}}{\left(1 + e^{\epsilon/\tau}\right)^2}$'
