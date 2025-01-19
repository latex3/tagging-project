input makecirc;
initlatex("\usepackage{amsmath}" &
          "\usepackage[T1]{fontenc}" &
          "\usepackage{fouriernc}");
beginfig(0);
   linewd:=2linewd;
   source.a(origin,I,90,"E",""); %voltage source on left
   resistor.a(S.a.p+(3.6cm,0),Up,-90,"r",""); %resistor r on right
   centreof.A(S.a.p,R.a.l-(1.8cm,0),res);
   resistor.b(c.A+(0,3mm),normal,phi.A,"r_0",""); %resistor r_0 on top left
   centreof.B(S.a.p+(1.8cm,0),R.a.l,ind);
   inductor.a(c.B+(0,3mm),normal,phi.B,"x_0",""); %inductor x_0 on top right
   wire(S.a.p,R.b.l,udsq);
   wire(R.b.r,L.a.l,rlsq);
   wire(L.a.r,R.a.l,rlsq);
   wireU(R.a.r,S.a.n,-3mm,udsq);
endfig;
end
