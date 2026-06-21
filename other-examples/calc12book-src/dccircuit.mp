input makecirc;
initlatex("\usepackage{amsmath}" &
          "\usepackage[T1]{fontenc}" &
          "\usepackage{fouriernc}");
beginfig(0);
   linewd:=2linewd;
   source.a(origin, DC, 90,"V","");
   capacitor.a(S.a.p+(3.6cm,0),normal,-90,"C",""); %capacitor C on right
   centreof.A(S.a.p,C.a.l-(1.8cm,0),swt);
   switch.b(c.A+(0,6mm),NO,phi.A,"",""); %switch on top left
   centreof.B(S.a.p+(1.8cm,0),C.a.l,res);
   resistor.a(c.B+(0,6mm),normal,0,"R",""); %resistor R on top right
   wire(S.a.p,st.b.l,udsq);
   wire(st.b.r,R.a.l,rlsq);
   wire(R.a.r,C.a.l,rlsq);
   wireU(C.a.r,S.a.n,-6mm,udsq);
   imesh(S.a.n+(18mm,2mm),22mm,10mm,cw,0,"I(t)");
endfig;
end
