k=0:1023;
S=sin(2*pi*k/16)';
X=S+wgn(1024,1,-20);
[ ErrorForw,ErrorBack ]=L2LatticePredictor(X,-0.9,0.5);
