function Xvect= XVout(X,CoeffVect,Count)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Length=size(X,1);
LengthCV=size(CoeffVect,1);
LengthY=Length+LengthCV-1;
XARRAY=zeros(LengthY,LengthCV);
for i=1:LengthCV
    XARRAY(i:i+Length-1,i)=X;
end
Xvect=XARRAY(Count+1,:);
end

