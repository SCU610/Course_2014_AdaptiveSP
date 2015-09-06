function Xvect= XVout(X,CoeffVect,Count)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
Length=size(X,1);
LengthCV=size(CoeffVect,1);
LengthY=Length+LengthCV-1;
XARRAY=zeros(LengthY,LengthCV);
for i=1:LengthCV
    XARRAY(i:i+Length-1,i)=X;
end
Xvect=XARRAY(Count+1,:);
end

