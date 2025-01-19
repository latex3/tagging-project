#!/bin/bash
#if [ $# -eq 0 ]; then
#   for x in *.mp
#   do
#      export TEX=latex
#      mpost $x
#   done
#fi
latex calc12book.tex
makeindex -s myindex.ist -o calc12book.ind calc12book.idx
latex calc12book.tex
makeindex calc12book.nlo -s nomencl.ist -o calc12book.nls
latex calc12book.tex
latex calc12book.tex
dvips -Pps -t letter -G0 -z calc12book.dvi -o
ps2pdf -dALLOWPSTRANSPARENCY -dMaxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true -dPDFSETTINGS=/printer -dCompatibilityLevel=1.4 calc12book.ps
