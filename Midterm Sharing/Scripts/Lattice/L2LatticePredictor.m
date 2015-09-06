function [ ErrorForw,ErrorBack ] = L2LatticePredictor(X,k0,k1)
%L2LatticePredictor Generate forward/ backward prediction error from input
%sequence, k0 and k1
[Ef1,Eb1]=LatticePredictor(X,X,k0);
[ErrorForw,ErrorBack]=LatticePredictor(Ef1,Eb1,k1);


end

