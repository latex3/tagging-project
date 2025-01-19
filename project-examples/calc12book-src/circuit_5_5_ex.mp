input makecirc;
initlatex("\usepackage{amsmath}" &
          "\usepackage[T1]{fontenc}" &
          "\usepackage{fouriernc}");
beginfig(0);
   linewd:=2linewd;
   source.a(origin,DC,90,"E",""); %voltage source on left
   resistor.a(S.a.p+(3.6cm,0),Up,-90,"R",""); %resistor R on right
   centreof.A(S.a.p,R.a.l-(1.8cm,0),swt);
   switch.b(c.A+(0,3mm),NO,phi.A,"s",""); %switch s on top left
   centreof.B(S.a.p+(1.8cm,0),R.a.l,cap);
   capacitor.a(c.B+(0,3mm),normal,phi.B,"C",""); %capacitor C on top right
   wire(S.a.p,st.b.l,udsq);
   wire(st.b.r,C.a.l,rlsq);
   wire(C.a.r,R.a.l,rlsq);
   wireU(R.a.r,S.a.n,-3mm,udsq);
endfig;
end
